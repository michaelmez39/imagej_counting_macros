macro "Count Cells Multicolor Batch" {
    // These are relevant values to change
    results_path = "cell_counting_results.txt"
    output_dir = "processed"

    // Get user input
	img_dir = getDirectory("Choose directory containing images");
	img_paths = getFileList(img_dir);	

	File.makeDirectory(img_dir+output_dir);
	// Suppress warnings and hide operation...
	setBatchMode(true);

    // Go through and process all the images
	for (i=0; i<img_paths.length; i++) {
		if (endsWith(toUpperCase(img_paths[i]), ".JPG")) {
			
			open(img_dir+img_paths[i]);
			fileNoExt = split(img_paths[i], ".");
		
			run("Split Channels");	
			
			// Green usually too noisy
			selectWindow(img_paths[i]+" (green)"); 
			close();
			
            // Red - usually no data
			selectWindow(img_paths[i]+" (red)"); 
			close();

			// Blues - best view of the cells
			selectWindow(img_paths[i]+" (blue)");
            // May want to find the best method and change this
			run("Auto Threshold", "method=MaxEntropy Dark");

			// Fill small holes
            run("Fill Holes");
            // Separate more chunky images
            run("Watershed");
            //convert to mask and analyze
			run("Convert to Mask");
			run("Analyze Particles...", "size=15-300 circularity=0.00-1.00 show=Outlines clear include summarize");

			// save the file in a new directory under a new name and close all windows
			saveAs("Png", img_dir+output_dir+File.separator+"counted"+fileNoExt[0]+"_green");  
			close();

			selectWindow(img_paths[i]+" (blue)");
			close();
		}
	}
	
	// save the summary
	selectWindow("Summary");
	img_counts = getInfo("window.contents"); 
	lines = split(img_counts, "\n"); 
	
	//create a text file with counting results, output only cell count
	//copy the results into clipboard
	//reset string buffer
	String.resetBuffer;	
	
	for (i=0; i<lines.length; i++) {
		
		if (i==0){
			File.saveString("",img_dir+results_path);
			f = File.open(img_dir+results_path);
		}
		
		labels = split(lines[i], "\t");
		print(f,labels[0]+"\t"+labels[1]);
		String.append(labels[1]+"\n");	
	}
	File.close(f);

	selectWindow("Summary");
	//copy all values into the clipboard
	String.copy(String.buffer);
	setBatchMode(false);
}
