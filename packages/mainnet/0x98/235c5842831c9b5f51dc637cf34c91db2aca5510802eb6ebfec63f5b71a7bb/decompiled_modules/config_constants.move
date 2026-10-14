module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants {
    public(friend) fun chk_attempts(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 3, 17);
    }

    public(friend) fun chk_base_fee(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 1000000000, 0);
    }

    public(friend) fun chk_bs_age(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 60000, 5);
    }

    public(friend) fun chk_cad_win(arg0: u64) {
        assert!(arg0 <= 10, 15);
    }

    public(friend) fun chk_fee_mult(arg0: u64) {
        assert!(arg0 >= 1000000000 && arg0 <= 10000000000, 9);
    }

    public(friend) fun chk_fee_win(arg0: u64) {
        assert!(arg0 >= 60000 && arg0 <= 31536000000, 8);
    }

    public(friend) fun chk_impact(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 21);
    }

    public(friend) fun chk_lambda(arg0: u64) {
        assert!(arg0 >= 50000000 && arg0 <= 1000000000, 14);
    }

    public(friend) fun chk_life_cap(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 27);
    }

    public(friend) fun chk_live_tgt(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 26);
    }

    public(friend) fun chk_max_pool(arg0: u64) {
        assert!(arg0 >= 20000000 && arg0 <= 18446744073709551615, 18);
    }

    public(friend) fun chk_max_prob(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 999999999, 3);
    }

    public(friend) fun chk_min_fee(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 1);
    }

    public(friend) fun chk_min_prob(arg0: u64) {
        assert!(arg0 >= 10000000 && arg0 <= 999999999, 2);
    }

    public(friend) fun chk_no_trade(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 15000, 24);
    }

    public(friend) fun chk_pyth_age(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 60000, 4);
    }

    public(friend) fun chk_referral(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 250000000, 22);
    }

    public(friend) fun chk_rsv_shr(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 1000000000, 6);
    }

    public(friend) fun chk_subsidy(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 500000000, 25);
    }

    public(friend) fun chk_sup_fee(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 50000000, 19);
    }

    public(friend) fun chk_svi_age(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 120000, 7);
    }

    public(friend) fun chk_ticks(arg0: u64) {
        assert!(arg0 > 0 && arg0 % 10000 == 0, 10);
        assert!(arg0 <= 17179869200, 16);
    }

    public(friend) fun chk_val_win(arg0: u64) {
        assert!(arg0 >= 60000 && arg0 <= 14400000, 23);
    }

    public(friend) fun chk_wd_fee(arg0: u64) {
        assert!(arg0 >= 0 && arg0 <= 50000000, 20);
    }

    // decompiled from Move bytecode v7
}

