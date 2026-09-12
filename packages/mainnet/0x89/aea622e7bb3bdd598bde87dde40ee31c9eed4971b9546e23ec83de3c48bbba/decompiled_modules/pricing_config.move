module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config {
    struct PricingConfig has store {
        use_pyth_spot_for_forward: bool,
        pyth_spot_freshness_ms: u64,
        block_scholes_price_freshness_ms: u64,
        block_scholes_svi_freshness_ms: u64,
    }

    public(friend) fun block_scholes_price_freshness_ms(arg0: &PricingConfig) : u64 {
        arg0.block_scholes_price_freshness_ms
    }

    public(friend) fun block_scholes_svi_freshness_ms(arg0: &PricingConfig) : u64 {
        arg0.block_scholes_svi_freshness_ms
    }

    public(friend) fun new() : PricingConfig {
        PricingConfig{
            use_pyth_spot_for_forward        : true,
            pyth_spot_freshness_ms           : 2000,
            block_scholes_price_freshness_ms : 2000,
            block_scholes_svi_freshness_ms   : 60000,
        }
    }

    public(friend) fun pyth_spot_freshness_ms(arg0: &PricingConfig) : u64 {
        arg0.pyth_spot_freshness_ms
    }

    public(friend) fun set_block_scholes_price_freshness_ms(arg0: &mut PricingConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_block_scholes_price_freshness_ms(arg1);
        arg0.block_scholes_price_freshness_ms = arg1;
    }

    public(friend) fun set_block_scholes_svi_freshness_ms(arg0: &mut PricingConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_block_scholes_svi_freshness_ms(arg1);
        arg0.block_scholes_svi_freshness_ms = arg1;
    }

    public(friend) fun set_pyth_spot_freshness_ms(arg0: &mut PricingConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_pyth_spot_freshness_ms(arg1);
        arg0.pyth_spot_freshness_ms = arg1;
    }

    public(friend) fun set_use_pyth_spot_for_forward(arg0: &mut PricingConfig, arg1: bool) {
        arg0.use_pyth_spot_for_forward = arg1;
    }

    public(friend) fun use_pyth_spot_for_forward(arg0: &PricingConfig) : bool {
        arg0.use_pyth_spot_for_forward
    }

    // decompiled from Move bytecode v7
}

