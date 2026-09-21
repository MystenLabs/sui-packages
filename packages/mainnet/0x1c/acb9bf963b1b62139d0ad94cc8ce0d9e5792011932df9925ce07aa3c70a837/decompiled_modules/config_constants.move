module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants {
    public(friend) fun assert_backing_buffer_lambda(arg0: u64) {
        assert!(arg0 >= 50000000 && arg0 <= 1000000000, 14);
    }

    public(friend) fun assert_base_fee(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 1000000000, 0);
    }

    public(friend) fun assert_block_scholes_price_freshness_ms(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 60000, 5);
    }

    public(friend) fun assert_block_scholes_svi_freshness_ms(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 120000, 7);
    }

    public(friend) fun assert_cadence_window_size(arg0: u64) {
        assert!(arg0 <= 10, 15);
    }

    public(friend) fun assert_ewma_alpha(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 100000000, 11);
    }

    public(friend) fun assert_ewma_penalty_rate(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 2000000, 13);
    }

    public(friend) fun assert_ewma_z_score_threshold(arg0: u64) {
        assert!(arg0 >= 1000000000 && arg0 <= 10000000000, 12);
    }

    public(friend) fun assert_expiry_fee_max_multiplier(arg0: u64) {
        assert!(arg0 >= 1000000000 && arg0 <= 10000000000, 9);
    }

    public(friend) fun assert_expiry_fee_window_ms(arg0: u64) {
        assert!(arg0 >= 60000 && arg0 <= 31536000000, 8);
    }

    public(friend) fun assert_inventory_impact_max_rate(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 21);
    }

    public(friend) fun assert_lp_request_limit_flush_attempts(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 3, 17);
    }

    public(friend) fun assert_market_tick_size_bounds(arg0: u64) {
        assert!(arg0 > 0 && arg0 % 10000 == 0, 10);
        assert!(arg0 <= 17179869200, 16);
    }

    public(friend) fun assert_max_entry_probability(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 999999999, 3);
    }

    public(friend) fun assert_max_lp_pool_value(arg0: u64) {
        assert!(arg0 >= 20000000 && arg0 <= 18446744073709551615, 18);
    }

    public(friend) fun assert_max_valuation_window_ms(arg0: u64) {
        assert!(arg0 >= 60000 && arg0 <= 14400000, 23);
    }

    public(friend) fun assert_min_entry_probability(arg0: u64) {
        assert!(arg0 >= 10000000 && arg0 <= 999999999, 2);
    }

    public(friend) fun assert_min_fee(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 1);
    }

    public(friend) fun assert_no_trade_window_ms(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 15000, 24);
    }

    public(friend) fun assert_plp_supply_fee_rate(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 50000000, 19);
    }

    public(friend) fun assert_plp_withdraw_fee_rate(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 50000000, 20);
    }

    public(friend) fun assert_protocol_reserve_profit_share(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 6);
    }

    public(friend) fun assert_pyth_spot_freshness_ms(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 60000, 4);
    }

    public(friend) fun assert_referral_fee_rate(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 250000000, 22);
    }

    // decompiled from Move bytecode v7
}

