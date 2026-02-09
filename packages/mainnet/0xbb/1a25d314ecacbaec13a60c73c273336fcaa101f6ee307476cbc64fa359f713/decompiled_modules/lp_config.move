module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::lp_config {
    struct LPConfig has store {
        lockup_period_ms: u64,
    }

    public fun lockup_period_ms(arg0: &LPConfig) : u64 {
        arg0.lockup_period_ms
    }

    public(friend) fun new() : LPConfig {
        LPConfig{lockup_period_ms: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::constants::default_min_lockup_ms()}
    }

    public(friend) fun set_lockup_period(arg0: &mut LPConfig, arg1: u64) {
        arg0.lockup_period_ms = arg1;
    }

    // decompiled from Move bytecode v6
}

