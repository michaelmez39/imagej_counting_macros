## Macros for automated cell counting
`process1.txt` Macro to count cells with black and white thresholding, one image at a time
`process2.txt` Macro to count cells with color thresholding, count all images in a selected directory
`process3.txt` Use ML model to count cells. Requires setup of DeepImageJ [setup instructions](https://deepimagej.github.io/deepimagej/download.html)and installation of the model [found here](https://github.com/michaelmez39/cell_counting_analysis/tree/ammar_branch) into DeepImageJ
`process4.txt` Macro to threshold / count cells, uses one color channel of the image and thresholds with autothreshold, counts all images in a selected directory

See the [imagej macro documentation](https://imagej.nih.gov/ij/developer/macro/macros.html) for more about writing macros!
