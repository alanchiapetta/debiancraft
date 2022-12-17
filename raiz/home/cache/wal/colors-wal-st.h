const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#1b1e25", /* black   */
  [1] = "#C5716D", /* red     */
  [2] = "#AD8C75", /* green   */
  [3] = "#D49676", /* yellow  */
  [4] = "#556F8B", /* blue    */
  [5] = "#6D889C", /* magenta */
  [6] = "#959796", /* cyan    */
  [7] = "#e6d2ba", /* white   */

  /* 8 bright colors */
  [8]  = "#a19382",  /* black   */
  [9]  = "#C5716D",  /* red     */
  [10] = "#AD8C75", /* green   */
  [11] = "#D49676", /* yellow  */
  [12] = "#556F8B", /* blue    */
  [13] = "#6D889C", /* magenta */
  [14] = "#959796", /* cyan    */
  [15] = "#e6d2ba", /* white   */

  /* special colors */
  [256] = "#1b1e25", /* background */
  [257] = "#e6d2ba", /* foreground */
  [258] = "#e6d2ba",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
