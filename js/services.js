


var app= angular.module('myApp',
        [
            "ngSanitize",
            "com.2fdevs.videogular",
            "com.2fdevs.videogular.plugins.controls"
        ]
    )

  
      //service to work with set of songs
      app.service('songService',function(){
         var songs = [{
                sources:[{src: './music/Hello.mp3', type: "audio/mp3",votes:5,songName:'Hello',artworkUrl:'http://i.dailymail.co.uk/i/pix/2015/10/22/18/0F32C58D00000578-0-Long_time_coming_Adele_on_the_cover_of_her_second_album_21_which-m-14_1445536475695.jpg',artist:'Adele',fileName:'Hello'}]
              },
              {
                sources: [{src: './music/LoveYourself.mp3', type: "audio/mp3",votes:7,songName:'Love Yourself',artworkUrl:'http://cdn.defjam.com/wp-content/uploads/2015/10/JB_Purpose-digital-deluxe-album-cover_lr.jpg',artist:'Justin Beiber',fileName:'LoveYourself'}]
              },
              {
               sources: [{src: './music/LoveTheWayYouLie.mp3', type: "audio/mp3",votes:3,songName:'Love The Way You Lie',artworkUrl:'https://upload.wikimedia.org/wikipedia/en/e/ed/Love_the_Way_You_Lie_cover.png',artist:'Eminem',fileName:'LoveTheWayYouLie'}]        
              },
              {
                sources: [{src: './music/Sorry.mp3', type: "audio/mp3",votes:19,songName:'Sorry',artworkUrl:'http://cdn.defjam.com/wp-content/uploads/2015/10/JB_Purpose-digital-deluxe-album-cover_lr.jpg',artist:'Justin Beiber',fileName:'LoveYourself'}]
              }
              ];
            console.log(songs)
            //sorting function
        
        function sort_by(a,b) {
          var aVotes = a.sources[0].votes;
          var bVotes = b.sources[0].votes;
          if (aVotes < bVotes) {
            return 1;
          } else if (aVotes > bVotes) {
            return -1;
          } else {
            return 0;
          }
        }
        var addSong = function(newObj){          
         console.log('add song was called',songs)
         for(var i=0; i<songs.length; i++){
            console.log('songs of i that sources.source',songs[i].sources[0].src)
            console.log('new obj src',newObj.sources[0].src)
            if(songs[i].sources[0].src===newObj.sources[0].src){
              songs[i].sources[0].votes=newObj.sources[0].votes;
              songs.sort(sort_by);
              return;
            }
         } 
          songs.push(newObj);
              songs.sort(sort_by);
          
        };

        //removes the first object from the songs array
        var removeSong = function(){
          console.log(songs);
          songs=songs.splice(0,1);
        }
        
        var getSongs = function(){
          songs.sort(sort_by)
          return songs;
        };

        return {
          addSong: addSong,
          getSongs: getSongs,
          removeSong: removeSong
        }

      })      

    

    console.log('before the controller')
    app.controller('update',['songService','$scope',function(songService,$scope){
      

    }])




    //recieves the mp3 filhttp://10.69.178.157:12000/from the backend and extracts data, creates object, and pushes to array
   /* app.controller('socket',['socketio','songService','$scope','$http',function(socketio,songService,$scope,$http){
      'use strict';
       socketio.on('Sahas', function (data) {
           //song name, vote count, cover art, album name, song title, artist
          console.log(data);



            
        for(var i=0; i<data.length; i++ ){
          $scope.object={
                      src:'../../music/'+data[i].path+'.mp3', 
                      type:'audio/mp3',
                      votes:data[i].vote_count,
                      songName:data[i].song_name,
                      artworkUrl:data[i].artwork,
                      artist:data[i].artist,                      
                      fileName:data[i].path

                  };

      $scope.songObj = {
        sources: [this.object]
      };


      songService.addSong($scope.songObj);

        }
           
      //adding the object to the songs array
      

      console.log($scope.songObj.sources);
      
        
      });
      
     
      }]);*/
   
    //controller for the music player
      app.controller('HomeCtrl',
          ["$sce",'$timeout','songService', '$scope', function ($sce,$timeout,songService,$scope) {
              
              
           var controller=$scope;
            console.log('before function');
      function update() {
      console.log('test')
      $.get('https://crossorigin.me/http://10.69.178.157:12000/Gagan', function(data){
        console.log(data)
        for(var i=0; i<data.length; i++ ){
          var fun = $scope;
          fun.object={
                      src:'../../music/'+data[i].path+'.mp3', 
                      type:'audio/mp3',
                      votes:data[i].vote_count,
                      songName:data[i].song_name,
                      artworkUrl:data[i].artwork,
                      artist:data[i].artist,                      
                      fileName:data[i].path

                  };
            console.log(fun.object)

        }

      fun.songObj = {
        sources: [fun.object]
      };

      songService.addSong(fun.songObj);
      controller.songs=songService.getSongs();

        })
   }

   setInterval(update,1000);
   update();











              
              
              controller.API = null;
              controller.currentTrack=0;

              controller.songs=songService.getSongs()
              console.log(controller.songs)

              controller.onPlayerReady = function(API) {
                   controller.API = API;
              };

              controller.config = {
                  sources: controller.songs[0].sources,
                           
                  theme: {
                  url: "./css/musicplayer.css"
                  }
          
              };

              console.log(controller.config);
        
            controller.setTrack = function(index) {
                controller.API.stop();
                controller.currentTrack = index;
                controller.config.sources = controller.songs[index].sources;
                $timeout(controller.API.play.bind(controller.API), 100);
                //socketio.emit('Sahas',{vote: false,song:controller.songs[index].sources[0].path,removeSong:true})
            };



            controller.onComplete = function() {
                console.log('on complete has been called')
                controller.isCompleted = true;

                songService.removeSong();

                //controller.currentTrack++;

                /*if (controller.currentTrack >= controller.config.sources.length) 
                  controller.currentVideo = 0;*/

                controller.setTrack(controller.currentTrack);
            };
        }]
    );

      //factory for socket.io
     /* app.factory('socketio', ['$rootScope', function ($rootScope) {
        'use strict';
        
        var socket = io.connect('http://10.69.178.157:12000');
        return {
            on: function (eventName, callback) {
                socket.on(eventName, function () {
                    var args = arguments;
                    $rootScope.$apply(function () {
                        callback.apply(socket, args);
                    });
                });
            },
            emit: function (eventName, data, callback) {
                socket.emit(eventName, data, function () {
                    var args = arguments;
                    $rootScope.$apply(function () {
                        if (callback) {
                            callback.apply(socket, args);
                        }
                    });
                });
            }
        };
    }]);*/
    