macro "Dot to Count" {
    width = getWidth();
    height = getHeight();
    sum = 0.0;
    for (row = 0; row < height; row++) {
        for (col = 0; col < width; col++) {
            pxl = getPixel(col, row);
            if (pxl > 0) {
                    sum += pxl;
            }
        }
    }
    Dialog.create("Total Cell Count");
    Dialog.addMessage("Cell count manual: " + sum / 255);
    Dialog.show();
    sum = 0.0;
}