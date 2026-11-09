module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config {
    struct EwmaConfig has store {
        alpha: u64,
        z_score_threshold: u64,
        penalty_rate: u64,
        enabled: bool,
    }

    public(friend) fun new() : EwmaConfig {
        EwmaConfig{
            alpha             : 10000000,
            z_score_threshold : 3000000000,
            penalty_rate      : 1000000,
            enabled           : false,
        }
    }

    // decompiled from Move bytecode v7
}

