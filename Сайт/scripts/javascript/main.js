let defaultLeft = -100;
let intervalProgress;

intervalProgress = setInterval(() => {
    if(defaultLeft > -62){
        clearInterval(intervalProgress);
        return defaultLeft = -100;
    }
    $(".progress-bar").css("left", "+=1")
    defaultLeft += 0.1;
}, 25/1.5)