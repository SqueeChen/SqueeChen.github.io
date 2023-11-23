<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>胖妞专属小剧场</title>
    <link href="https://vjs.zencdn.net/7.4.1/video-js.css" rel="stylesheet">
    <script src='https://vjs.zencdn.net/7.4.1/video.js'></script>
    <!-- videojs-contrib-hls 用于在电脑端播放 如果只需手机播放可以不引入 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/videojs-contrib-hls/5.15.0/videojs-contrib-hls.min.js"></script>
</head>
 
<body>
<style>
    .video-js .vjs-tech {position: relative !important;}

    .father{
           display: flex;
           justify-content: center;
           align-items: center;
        }
   .video-js .vjs-time-control {
    display: block;
}

</style>
<div class="father">
    <video id="myVideo" class="video-js vjs-default-skin vjs-big-play-centered" controls preload="auto" data-setup='{}' width="800" height="500">
        <source id="source" src="https://media.w3.org/2010/05/sintel/trailer.mp4" type="application/x-mpegURL"></source>
    </video>
</div>
<div class="father">
        <button class="control" onclick=operation("play")>播放</button>&nbsp&nbsp&nbsp&nbsp&nbsp
        <button class="control" onclick=operation("stop")>停止</button>&nbsp&nbsp&nbsp&nbsp&nbsp
        <button class="control" onclick=reload()>重载</button>&nbsp&nbsp&nbsp&nbsp&nbsp
        <%--<button class="control" onclick=operation("reset")>重置</button>&nbsp&nbsp&nbsp&nbsp&nbsp--%>
        <button class="control" onclick=operation("fastForward")>快进</button>&nbsp&nbsp&nbsp&nbsp&nbsp
        <button class="control" onclick=operation("back")>后退</button>&nbsp&nbsp&nbsp&nbsp&nbsp
        <button class="control" onclick=operation("volumeUp")>音量+</button>&nbsp&nbsp&nbsp&nbsp&nbsp
        <button class="control" onclick=operation("volumeUp")>音量-</button>&nbsp&nbsp&nbsp&nbsp&nbsp
        <button class="control" onclick=operation("fullScreen")>全屏</button>&nbsp&nbsp&nbsp&nbsp&nbsp
        <button class="control" onclick=operation("exitFullScreen")>退出全屏</button><br /><br /><br />
</div>
<div class="father" width="800" height="100">
    <input type="text" id="url" value=""  style="width:600px; height:50px;"/>
    <button class="qiehuan" onclick=cut()>切换视频</button>
</div>
</body>
<script>
    // videojs 简单使用
    var myVideo = videojs('myVideo', {
        bigPlayButton: true,
        textTrackDisplay: false,
        posterImage: false,
        errorDisplay: false,
          controlBar: { // 设置控制条组件
		    children: [
		      {name: 'playToggle'}, // 播放按钮
		      {name: 'currentTimeDisplay'}, // 当前已播放时间
		      {name: 'progressControl'}, // 播放进度条
		      {name: 'durationDisplay'}, // 总时间
		      { // 倍数播放
		        name: 'playbackRateMenuButton',
		        'playbackRates': [0.5, 1, 1.5, 2, 2.5]
		      },
		      {
		        name: 'volumePanel', // 音量控制
		        inline: false, // 不使用水平方式
		      },
		      {name: 'FullscreenToggle'} // 全屏
		    ]
		  },
    })
    myVideo.play()// 视频播放
    myVideo.pause() // 视频暂停
    var changeVideo = function (vdoSrc) {
        if (/\.m3u8$/.test(vdoSrc)) { //判断视频源是否是m3u8的格式
            myVideo.src({
                src: vdoSrc,
                type: 'application/x-mpegURL' //在重新添加视频源的时候需要给新的type的值
            })
        } if (/\.mp4$/.test(vdoSrc)){
        	  myVideo.src({
                src: vdoSrc,
                type: 'video/mp4' //在重新添加视频源的时候需要给新的type的值
            })

        	}else {
            myVideo.src(vdoSrc)
        }
        myVideo.load();
        myVideo.play();
 
    }
 changeVideo("https://media.w3.org/2010/05/sintel/trailer.mp4");

	function cut() {
	 var src = document.getElementById("url").value;
        changeVideo(src);
	}
	function reload(){
		var whereYouAt = myVideo.currentTime();
		 var src = document.getElementById("url").value;
       	 changeVideo(src);  
       	 myVideo.currentTime(whereYouAt);
	}



//reurn false 禁止函数内部执行其他的事件或者方法
      var vol = 0.1;  //1代表100%音量，每次增减0.1
      var time = 10; //单位秒，每次增减10秒

  var v_paused = true;
      document.onkeyup = function (event) {//键盘事件

        var e = event || window.event || arguments.callee.caller.arguments[0];
 
         //鼠标上下键控制视频音量
        if (e && e.keyCode === 38) {
 
             // 按 向上键
            var howLoudIsIt = myVideo.volume();
            myVideo.volume(howLoudIsIt+vol);
            return false;
 
         } else if (e && e.keyCode === 40) {
 
             // 按 向下键
              var howLoudIsIt = myVideo.volume();
            myVideo.volume(howLoudIsIt-vol);
             return false;
 
         } else if (e && e.keyCode === 37) {
 
            // 按 向左键
               var whereYouAt = myVideo.currentTime();
            myVideo.currentTime(whereYouAt-time);
             return false;
 
         } else if (e && e.keyCode === 39) {
 
            // 按 向右键
              var whereYouAt = myVideo.currentTime();
            myVideo.currentTime(time+whereYouAt);
             return false;
 
         } else if (e && e.keyCode === 32) {
 			
            // 按空格键 判断当前是否暂停
            if(v_paused){
            	myVideo.play()
            } else {
            	 myVideo.pause()
            }
            v_paused = !v_paused;
             //myVideo.paused == true ? myVideo.play() : myVideo.pause();
             return false;
         }
     };


    /**
     * 方法
     */
    function operation(param){
        if("play"==param){	//开始播放
            myVideo.play();
        }else if("stop"==param){	//停止播放
            myVideo.pause();
        }else if("fastForward"==param){ //快进
            var whereYouAt = myVideo.currentTime();
            myVideo.currentTime(time+whereYouAt);
        }else if("reload"==param){	//重新加载
            myVideo.pause();
            myVideo.load();
            myVideo.play();
        }else if("back"==param){	//后退
            var whereYouAt = myVideo.currentTime();
            myVideo.currentTime(whereYouAt-time);
        }else if("fullScreen"==param){	//全屏
            myVideo.enterFullScreen();
        }else if("exitFullScreen"==param){	//退出全屏
            myVideo.enterFullScreen();
        }else if("volumeUp"==param){	//音量加
            var howLoudIsIt = myVideo.volume();
            myVideo.volume(howLoudIsIt+vol);
        }else if("volumeDown"==param){	//音量减
            var howLoudIsIt = myVideo.volume();
            myVideo.volume(howLoudIsIt-vol);
        }else if("reset"==param){	//重置，视频不会播放
            myVideo.reset();
        }
    }
</script>
</html>