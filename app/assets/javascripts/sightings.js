// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  if($('#new_sighting').length == 1){
    navigator.geolocation.getCurrentPosition(GeoL);
    function GeoL(position) {
      document.getElementById('sighting_lat').value = position.coords.latitude;
      document.getElementById('sighting_lng').value = position.coords.longitude;
    }
  }

  if(navigator.geolocation){
    if($('#map').length == 1){
      navigator.geolocation.getCurrentPosition(success)
      function success(position) {
        var markers_to_add = []
        $.getJSON('/sightings').success(function(data){ markers_to_add = data})
        handler = Gmaps.build('Google');
        handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
          handler.map.centerOn({ lat: position.coords.latitude, lng: position.coords.longitude })
          markers = handler.addMarkers(markers_to_add);
          handler.fitMapToBounds();
          handler.getMap().setZoom(18);
        });
      }
    }
  }
})
