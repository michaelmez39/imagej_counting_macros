var background = "black";
var label_color = "white";

macro "Label Cells - Dxy" {
    title = "Cell Labeler"
    msg = "Click once cells have been labeled"
    setTool("multipoint")
    waitForUser(title, msg);
    roiManager("add")
    run("Select None")
    run("Select All")
    roiManager("add")
    roiManager("select", 1)
    setForegroundColor(0, 0, 0);
    roiManager("fill")

    roiManager("select", 0)
    setForegroundColor(255, 255, 255);
    roiManager("fill")
    roiManager("reset")
}

macro "Label Cells Options" {
    getString("Background color:", background)
    getString("Label color:", label_color)
}