module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types {
    public fun assert_binary_outcome(arg0: u8) {
        assert!(is_binary_outcome(arg0), 3);
    }

    public fun assert_fee_bps(arg0: u64) {
        assert!(arg0 <= 10000, 6);
    }

    public fun assert_limit_price(arg0: u64) {
        assert!(arg0 > 0 && arg0 < 1000000, 5);
    }

    public fun assert_order_side(arg0: u8) {
        assert!(is_order_side(arg0), 4);
    }

    public fun assert_resolution_outcome(arg0: u8) {
        assert!(is_resolution_outcome(arg0), 3);
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun ceil_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 7);
        if (arg0 == 0 || arg1 == 0) {
            0
        } else {
            let v1 = ((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128);
            assert!(v1 <= (18446744073709551615 as u128), 8);
            (v1 as u64)
        }
    }

    public fun collateral_for_fill(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0, 7);
        assert_limit_price(arg1);
        ceil_mul_div(arg0, arg1, 1000000)
    }

    public fun e_amount_too_large() : u64 {
        8
    }

    public fun e_fee_exceeds_cap() : u64 {
        16
    }

    public fun e_fill_already_settled() : u64 {
        14
    }

    public fun e_insufficient_balance() : u64 {
        9
    }

    public fun e_invalid_fee() : u64 {
        6
    }

    public fun e_invalid_outcome() : u64 {
        3
    }

    public fun e_invalid_price() : u64 {
        5
    }

    public fun e_invalid_side() : u64 {
        4
    }

    public fun e_invalid_signature() : u64 {
        15
    }

    public fun e_invalid_state() : u64 {
        2
    }

    public fun e_nonce_too_low() : u64 {
        12
    }

    public fun e_not_authorized() : u64 {
        1
    }

    public fun e_order_cancelled() : u64 {
        11
    }

    public fun e_order_expired() : u64 {
        10
    }

    public fun e_overfill() : u64 {
        13
    }

    public fun e_zero_amount() : u64 {
        7
    }

    public fun fee_for_collateral(arg0: u64, arg1: u64) : u64 {
        let (v0, _) = fee_for_collateral_with_remainder(arg0, arg1, 0);
        v0
    }

    public fun fee_for_collateral_with_remainder(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        assert_fee_bps(arg1);
        assert!(arg2 < 10000, 6);
        if (arg0 == 0 || arg1 == 0) {
            (0, arg2)
        } else {
            let v2 = (arg0 as u128) * (arg1 as u128) + (arg2 as u128);
            (((v2 / (10000 as u128)) as u64), ((v2 % (10000 as u128)) as u64))
        }
    }

    public fun is_binary_outcome(arg0: u8) : bool {
        arg0 == 1 || arg0 == 2
    }

    public fun is_market_state(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        }
    }

    public fun is_order_side(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    public fun is_resolution_outcome(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        }
    }

    public fun outcome_invalid() : u8 {
        3
    }

    public fun outcome_no() : u8 {
        2
    }

    public fun outcome_unresolved() : u8 {
        0
    }

    public fun outcome_yes() : u8 {
        1
    }

    public fun price_scale() : u64 {
        1000000
    }

    public fun settlement_amounts(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let (v0, v1, _) = settlement_amounts_with_remainder(arg0, arg1, arg2, 0);
        (v0, v1)
    }

    public fun settlement_amounts_with_remainder(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        let v0 = collateral_for_fill(arg0, arg1);
        let (v1, v2) = fee_for_collateral_with_remainder(v0, arg2, arg3);
        assert!(v1 == 0 || v1 < v0, 6);
        (v0, v1, v2)
    }

    public fun side_buy() : u8 {
        0
    }

    public fun side_sell() : u8 {
        1
    }

    public fun state_paused() : u8 {
        2
    }

    public fun state_resolved() : u8 {
        3
    }

    public fun state_trading() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

