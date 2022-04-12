macro "Count Cells ML Batch" {

    // These are relevant values to change
    // ********************** //


    results_path = "cell_counting_results.txt"
    output_dir = "processed"

    // ********************** //
    // Get user input for input directory
	img_dir = getDirectory("Choose directory containing images");
	img_paths = getFileList(img_dir);	

	File.makeDirectory(img_dir+output_dir);
	// Suppress warnings and hide operation...
	setBatchMode(true);
    counts = newArray();
    // Go through and process all the images
	for (i=0; i<img_paths.length; i++) {
		if (endsWith(toUpperCase(img_paths[i]), ".JPG")) {
			
			open(img_dir+img_paths[i]);
			fileNoExt = split(img_paths[i], ".");
		
			run("DeepImageJ Run", "model=final_model format=Tensorflow preprocessing=[no preprocessing] postprocessing=[no postprocessing] axes=X,Y,C tile=512,512,3 logging=mute");
            selectWindow("final_model_output_"+img_paths[i]);
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
            counts = Array.concat(counts, sum);
            sum = 0;
			// save the file in a new directory under a new name and close all windows
			saveAs("Png", img_dir+output_dir+File.separator+"counted"+fileNoExt[0]);  
			close();
		}
	}
	Array.show("Image Counts", img_paths, counts);

	//create a text file with counting results, output only cell count
	//copy the results into clipboard
	//reset string buffer
	String.resetBuffer;	
	selectWindow("Summary");
	//copy all values into the clipboard
	String.copy(String.buffer);
	setBatchMode(false);
}
