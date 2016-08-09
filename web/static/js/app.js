import socket from "./socket"

const Players = new Mongo.Collection("players");

Template.leaderboard.onCreated(function() {
  this.channel = socket.channel("players");
  this.channel.join()
    .receive("ok", players => {
      players.map(player => Players.upsert(player.id, player));
    })
    .receive("error", resp => console.log("Unable to join", resp));

  this.channel.on("add_points", (player) => {
    Players.update(player.id, {
      $set: {
        score: player.score
      }
    });
  })
});

Template.leaderboard.helpers({
  players: function () {
    return Players.find({}, { sort: { score: -1, name: 1 } });
  },
  selectedName: function () {
    var player = Players.findOne(Session.get("selectedPlayer"));
    return player && player.name;
  }
});

Template.leaderboard.events({
  'click .inc': function () {
    Template.instance().channel.push("add_points", {
      id: Session.get("selectedPlayer")
    });
  }
});

Template.player.helpers({
  selected: function () {
    return Session.equals("selectedPlayer", this.id) ? "selected" : '';
  }
});

Template.player.events({
  'click': function () {
    Session.set("selectedPlayer", this.id);
  }
});
