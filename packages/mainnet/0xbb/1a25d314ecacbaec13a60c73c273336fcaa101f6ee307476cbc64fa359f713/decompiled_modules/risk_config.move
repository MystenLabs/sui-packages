module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::risk_config {
    struct RiskConfig has store {
        max_total_exposure_pct: u64,
        max_per_market_exposure_pct: u64,
    }

    public fun max_per_market_exposure_pct(arg0: &RiskConfig) : u64 {
        arg0.max_per_market_exposure_pct
    }

    public fun max_total_exposure_pct(arg0: &RiskConfig) : u64 {
        arg0.max_total_exposure_pct
    }

    public(friend) fun new() : RiskConfig {
        RiskConfig{
            max_total_exposure_pct      : 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::constants::default_max_total_exposure_pct(),
            max_per_market_exposure_pct : 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::constants::default_max_exposure_per_market_pct(),
        }
    }

    public(friend) fun set_max_per_market_exposure_pct(arg0: &mut RiskConfig, arg1: u64) {
        arg0.max_per_market_exposure_pct = arg1;
    }

    public(friend) fun set_max_total_exposure_pct(arg0: &mut RiskConfig, arg1: u64) {
        arg0.max_total_exposure_pct = arg1;
    }

    // decompiled from Move bytecode v6
}

