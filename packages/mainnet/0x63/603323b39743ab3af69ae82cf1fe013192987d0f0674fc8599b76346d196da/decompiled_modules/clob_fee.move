module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_fee {
    public fun curve_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_limit_price(arg1);
        if (arg0 == 0 || arg2 == 0) {
            0
        } else {
            let v1 = (arg0 as u128) * ((0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::price_scale() - arg1) as u128) * (arg2 as u128) / (0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::price_scale() as u128) * (1000000 as u128);
            assert!(v1 <= (18446744073709551615 as u128), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_amount_too_large());
            (v1 as u64)
        }
    }

    public fun fee_cap_for(arg0: u64, arg1: u64) : u64 {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_fee_bps(arg1);
        let v0 = if (arg1 > 2000) {
            2000
        } else {
            arg1
        };
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::fee_for_collateral(arg0, v0)
    }

    public fun final_k_ppm(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::bps_denominator() as u128);
        assert!(v0 <= (18446744073709551615 as u128), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_amount_too_large());
        (v0 as u64)
    }

    public fun k_scale() : u64 {
        1000000
    }

    public fun max_final_k_ppm() : u64 {
        2000 * 1000000 / 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::bps_denominator()
    }

    // decompiled from Move bytecode v7
}

