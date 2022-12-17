static const char norm_fg[] = "#e6d2ba";
static const char norm_bg[] = "#1b1e25";
static const char norm_border[] = "#a19382";

static const char sel_fg[] = "#e6d2ba";
static const char sel_bg[] = "#AD8C75";
static const char sel_border[] = "#e6d2ba";

static const char urg_fg[] = "#e6d2ba";
static const char urg_bg[] = "#C5716D";
static const char urg_border[] = "#C5716D";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
