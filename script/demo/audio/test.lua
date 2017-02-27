module(...,package.seeall)

local function testcb(r)
	print("testcb",r)
end

--播放音频文件测试接口，每次打开一行代码进行测试
local function testplayfile()
	--单次播放来电铃声，默认音量等级
	--audioapp.play(audioapp.CALL,"/ldata/call.mp3")
	--单次播放来电铃声，音量等级7
	--audioapp.play(audioapp.CALL,"/ldata/call.mp3",audiocore.VOL7)
	--单次播放来电铃声，音量等级7，播放结束或者出错调用testcb回调函数
	--audioapp.play(audioapp.CALL,"/ldata/call.mp3",audiocore.VOL7,testcb)
	--循环播放来电铃声，音量等级7，没有循环间隔(一次播放结束后，立即播放下一次)
	audioapp.play(audioapp.CALL,"/ldata/call.mp3",audiocore.VOL7,nil,true)
	--循环播放来电铃声，音量等级7，循环间隔为2000毫秒
	--audioapp.play(audioapp.CALL,"/ldata/call.mp3",audiocore.VOL7,nil,true,2000)
end


--播放tts测试接口，每次打开一行代码进行测试
--“你好，这里是上海合宙通信科技有限公司，现在时刻18点30分”
local ttstr = "你好，这里是上海合宙通信科技有限公司，现在时刻18点30分"
local function testplaytts()
	--单次播放，默认音量等级
	--audioapp.play(audioapp.TTS,common.binstohexs(common.gb2312toucs2(ttstr)))
	--单次播放，音量等级7
	--audioapp.play(audioapp.TTS,common.binstohexs(common.gb2312toucs2(ttstr)),audiocore.VOL7)
	--单次播放，音量等级7，播放结束或者出错调用testcb回调函数
	--audioapp.play(audioapp.TTS,common.binstohexs(common.gb2312toucs2(ttstr)),audiocore.VOL7,testcb)
	--循环播放，音量等级7，没有循环间隔(一次播放结束后，立即播放下一次)
	audioapp.play(audioapp.TTS,common.binstohexs(common.gb2312toucs2(ttstr)),audiocore.VOL7,nil,true)
	--循环播放，音量等级7，循环间隔为2000毫秒
	--audioapp.play(audioapp.TTS,common.binstohexs(common.gb2312toucs2(ttstr)),audiocore.VOL7,nil,true,2000)
end


--播放冲突测试接口，每次打开一个if语句进行测试
local function testplayconflict()	

	if true then
		--循环播放来电铃声
		audioapp.play(audioapp.CALL,"/ldata/call.mp3",audiocore.VOL7,nil,true)
		--5秒钟后，循环播放开机铃声
		sys.timer_start(audioapp.play,5000,audioapp.PWRON,"/ldata/pwron.mp3",audiocore.VOL7,nil,true)
		
	end

	
	--[[
	if true then
		--循环播放来电铃声
		audioapp.play(audioapp.CALL,"/ldata/call.mp3",audiocore.VOL7,nil,true)
		--5秒钟后，尝试循环播放新短信铃声，但是优先级不够，不会播放
		sys.timer_start(audioapp.play,5000,audioapp.SMS,"/ldata/sms.mp3",audiocore.VOL7,nil,true)
		
	end
	]]
	
	--[[
	if true then
		--循环播放TTS
		audioapp.play(audioapp.TTS,common.binstohexs(common.gb2312toucs2(ttstr)),audiocore.VOL7,nil,true)
		--10秒钟后，循环播放开机铃声
		sys.timer_start(audioapp.play,10000,audioapp.PWRON,"/ldata/pwron.mp3",audiocore.VOL7,nil,true)
		
	end
	]]
end


--每次打开下面的一行代码进行测试
sys.timer_start(testplayfile,5000)
--sys.timer_start(testplaytts,5000)
--sys.timer_start(testplayconflict,5000)
