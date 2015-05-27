document.addEventListener("readystatechange", function(event) {
  document.getElementById('refresh_button').addEventListener('mouseclick', refreshVideos, false);
});

var views_date = "2015-05-04";

var fb_num = Math.floor(Math.random()*38);
var yt_num = Math.floor(Math.random()*400);

var fb_titles = [];
var yt_titles = [];
var fb_dates= [];
var yt_dates = [];
var fb_lengths = [];
var yt_lengths = [];
var fb_views = [];
var yt_views = [];
var fb_ids = [];
var yt_ids = [];

function refreshVideos() {
  fb_num = Math.floor(Math.random()*38);
  yt_num = Math.floor(Math.random()*400);
  
  document.getElementById("fb_title").innerHTML = "<b>Title: </b>" + fb_titles[fb_num];
  document.getElementById("yt_title").innerHTML = "<b>Title: </b>" + yt_titles[yt_num];
  
  document.getElementById("fb_date").innerHTML = "<b>Date posted: </b>" + fb_dates[fb_num];
  document.getElementById("yt_date").innerHTML = "<b>Date posted: </b>" + yt_dates[yt_num];
  
  document.getElementById("fb_length").innerHTML = "<b>Length:</b> " + fb_lengths[fb_num] + " seconds";
  document.getElementById("yt_length").innerHTML = "<b>Length:</b> " + yt_lengths[yt_num] + " seconds";
  
  document.getElementById('fb_views').innerHTML = "<b>Viewership:</b> " + fb_views[fb_num] + " views (as of " + views_date + ")";
  document.getElementById('yt_views').innerHTML = "<b>Viewership:</b> " + yt_views[yt_num] + " views (as of " + views_date + ")";
  
  document.getElementById("fb_vid").innerHTML = "<iframe src='https://www.facebook.com/video/embed?video_id=" + fb_ids[fb_num] + "' width='480' height='270' frameborder='0'></iframe>";
  document.getElementById('fb_mobilevid').innerHTML = "<iframe src='https://www.facebook.com/video/embed?video_id=" + fb_ids[fb_num] + "' width='300' height='169' frameborder='0'></iframe>";
  document.getElementById('fb_largevid').innerHTML = "<iframe src='https://www.facebook.com/video/embed?video_id=" + fb_ids[fb_num] + "' width='560' height='315' frameborder='0'></iframe>";
  document.getElementById("yt_vid").innerHTML = "<iframe type='text/html' src='http://www.youtube.com/embed/" + yt_ids[yt_num] + "' width='480' height='270' frameborder='0' allowfullscreen='true'/>";
  document.getElementById('yt_mobilevid').innerHTML = "<iframe type='text/html' src='http://www.youtube.com/embed/" + yt_ids[yt_num] + "' width='300' height='169' frameborder='0' allowfullscreen='true'/>";
  document.getElementById('yt_largevid').innerHTML = "<iframe type='text/html' src='http://www.youtube.com/embed/" + yt_ids[yt_num] + "' width='560' height='315' frameborder='0' allowfullscreen='true'/>";
}

function pullText(x, callback) {
  console.log("fired function");
  var fileReturn=new XMLHttpRequest();
  fileReturn.onreadystatechange=function() {
    if (fileReturn.readyState==4 && fileReturn.status==200) {
      var entireTextFile = fileReturn.responseText;
      var lines = fileReturn.responseText;
      callback(lines);
    }
  };
  fileReturn.open("GET",x,true);
  fileReturn.send();
}

// TITLES
pullText([SOURCE URL], function(lines) {
	fb_titles = JSON.parse(lines);
    document.getElementById("fb_title").innerHTML = "<b>Title: </b>" + fb_titles[fb_num];
});

pullText([SOURCE URL], function(lines) {
	yt_titles = JSON.parse(lines);
    document.getElementById("yt_title").innerHTML = "<b>Title: </b>" + yt_titles[yt_num];
});

// DATES
pullText([SOURCE URL], function(lines) {
	fb_dates = JSON.parse(lines);
    document.getElementById("fb_date").innerHTML = "<b>Date posted: </b>" + fb_dates[fb_num];
});

pullText([SOURCE URL], function(lines) {
	yt_dates = JSON.parse(lines);
    document.getElementById("yt_date").innerHTML = "<b>Date posted: </b>" + yt_dates[yt_num];
});

// LENGTHS
pullText([SOURCE URL], function(lines) {
	fb_lengths = JSON.parse(lines);
    document.getElementById("fb_length").innerHTML = "<b>Length:</b> " + fb_lengths[fb_num] + " seconds";
});

pullText([SOURCE URL], function(lines) {
	yt_lengths = JSON.parse(lines);
    document.getElementById("yt_length").innerHTML = "<b>Length:</b> " + yt_lengths[yt_num] + " seconds";
});

// VIEWS
pullText([SOURCE URL], function(lines) {
	fb_views = JSON.parse(lines);
    document.getElementById('fb_views').innerHTML = "<b>Viewership:</b> " + fb_views[fb_num] + " views (as of " + views_date + ")";
});

pullText([SOURCE URL], function(lines) {
	yt_views = JSON.parse(lines);
    document.getElementById('yt_views').innerHTML = "<b>Viewership:</b> " + yt_views[yt_num] + " views (as of " + views_date + ")";
});

// EMBEDS
pullText([SOURCE URL], function(lines) {
	fb_ids = JSON.parse(lines);
    document.getElementById("fb_vid").innerHTML = "<iframe src='https://www.facebook.com/video/embed?video_id=" + fb_ids[fb_num] + "' width='480' height='270' frameborder='0'></iframe>";
    document.getElementById('fb_mobilevid').innerHTML = "<iframe src='https://www.facebook.com/video/embed?video_id=" + fb_ids[fb_num] + "' width='300' height='169' frameborder='0'></iframe>";
    document.getElementById('fb_largevid').innerHTML = "<iframe src='https://www.facebook.com/video/embed?video_id=" + fb_ids[fb_num] + "' width='560' height='315' frameborder='0'></iframe>";
});

pullText([SOURCE URL], function(lines) {
	yt_ids = JSON.parse(lines);
    document.getElementById("yt_vid").innerHTML = "<iframe type='text/html' src='http://www.youtube.com/embed/" + yt_ids[yt_num] + "' width='480' height='270' frameborder='0' allowfullscreen='true'/>";
    document.getElementById('yt_mobilevid').innerHTML = "<iframe type='text/html' src='http://www.youtube.com/embed/" + yt_ids[yt_num] + "' width='300' height='169' frameborder='0' allowfullscreen='true'/>";
    document.getElementById('yt_largevid').innerHTML = "<iframe type='text/html' src='http://www.youtube.com/embed/" + yt_ids[yt_num] + "' width='560' height='315' frameborder='0' allowfullscreen='true'/>";
});
