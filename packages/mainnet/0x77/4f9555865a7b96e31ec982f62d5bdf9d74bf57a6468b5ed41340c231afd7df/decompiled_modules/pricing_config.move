module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing_config {
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
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_block_scholes_price_freshness_ms(arg1);
        arg0.block_scholes_price_freshness_ms = arg1;
    }

    public(friend) fun set_block_scholes_svi_freshness_ms(arg0: &mut PricingConfig, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_block_scholes_svi_freshness_ms(arg1);
        arg0.block_scholes_svi_freshness_ms = arg1;
    }

    public(friend) fun set_pyth_spot_freshness_ms(arg0: &mut PricingConfig, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_pyth_spot_freshness_ms(arg1);
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

