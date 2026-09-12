module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config {
    struct EwmaConfig has store {
        alpha: u64,
        z_score_threshold: u64,
        penalty_rate: u64,
        enabled: bool,
    }

    public(friend) fun alpha(arg0: &EwmaConfig) : u64 {
        arg0.alpha
    }

    public(friend) fun enabled(arg0: &EwmaConfig) : bool {
        arg0.enabled
    }

    public(friend) fun new() : EwmaConfig {
        EwmaConfig{
            alpha             : 10000000,
            z_score_threshold : 3000000000,
            penalty_rate      : 1000000,
            enabled           : false,
        }
    }

    public(friend) fun penalty_rate(arg0: &EwmaConfig) : u64 {
        arg0.penalty_rate
    }

    public(friend) fun set_enabled(arg0: &mut EwmaConfig, arg1: bool) {
        arg0.enabled = arg1;
    }

    public(friend) fun set_params(arg0: &mut EwmaConfig, arg1: u64, arg2: u64, arg3: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_ewma_alpha(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_ewma_z_score_threshold(arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_ewma_penalty_rate(arg3);
        arg0.alpha = arg1;
        arg0.z_score_threshold = arg2;
        arg0.penalty_rate = arg3;
    }

    public(friend) fun z_score_threshold(arg0: &EwmaConfig) : u64 {
        arg0.z_score_threshold
    }

    // decompiled from Move bytecode v7
}

