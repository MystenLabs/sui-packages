module 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset {
    struct BoundedValueChecker has copy, drop, store {
        deviation_lower_bound_bps: u64,
        deviation_upper_bound_bps: u64,
        max_update_time_gap_ms: u64,
    }

    struct AssetConfig has drop, store {
        base_token_id: u8,
        primary_sources: 0x2::vec_set::VecSet<u8>,
        check_sources: 0x2::vec_map::VecMap<u8, BoundedValueChecker>,
    }

    public(friend) fun admin_ref_source() : u8 {
        255
    }

    public(friend) fun asset_check_success() : u64 {
        0
    }

    public(friend) fun base_token_id(arg0: &AssetConfig) : u8 {
        arg0.base_token_id
    }

    public(friend) fun check_source(arg0: &AssetConfig) : (u8, &BoundedValueChecker) {
        let (v0, v1) = 0x2::vec_map::get_entry_by_idx<u8, BoundedValueChecker>(&arg0.check_sources, 0);
        (*v0, v1)
    }

    fun ensure_valid_source(arg0: u8) {
        let v0 = &arg0;
        let v1 = 1;
        if (v0 == &v1) {
        } else {
            let v2 = 2;
            if (v0 == &v2) {
            } else {
                let v3 = 255;
                assert!(v0 == &v3, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::unknown_source());
            };
        };
    }

    public(friend) fun is_check_pass(arg0: &BoundedValueChecker, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::PriceFeedComponent, arg2: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::PriceFeedComponent) : u64 {
        let v0 = is_timestamp_pass(arg0, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::update_time(arg1), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::update_time(arg2));
        if (v0 != 0) {
            return v0
        };
        is_value_bounded(arg0, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::value(arg1), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::value(arg2))
    }

    fun is_timestamp_pass(arg0: &BoundedValueChecker, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        if (v0 * 1000 <= arg0.max_update_time_gap_ms) {
            0
        } else {
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::update_time_gap_too_large()
        }
    }

    fun is_value_bounded(arg0: &BoundedValueChecker, arg1: u64, arg2: u64) : u64 {
        if (arg1 == arg2) {
            return 0
        };
        let v0 = (arg2 as u128);
        if (arg1 > arg2) {
            if ((arg1 as u128) >= v0 + v0 * (arg0.deviation_upper_bound_bps as u128) / (10000 as u128)) {
                return 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::value_above_upper_bound()
            };
        } else if ((arg1 as u128) <= v0 - v0 * (arg0.deviation_lower_bound_bps as u128) / (10000 as u128)) {
            return 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::value_below_lower_bound()
        };
        0
    }

    public(friend) fun new_asset_config(arg0: u8, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: u64) : AssetConfig {
        ensure_valid_source(arg1);
        ensure_valid_source(arg2);
        assert!(arg1 != arg2, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::asset_source_conflict());
        let v0 = 0x2::vec_set::empty<u8>();
        0x2::vec_set::insert<u8>(&mut v0, arg1);
        let v1 = 0x2::vec_map::empty<u8, BoundedValueChecker>();
        0x2::vec_map::insert<u8, BoundedValueChecker>(&mut v1, arg2, new_bounded_value_checker(arg3, arg4, arg5));
        AssetConfig{
            base_token_id   : arg0,
            primary_sources : v0,
            check_sources   : v1,
        }
    }

    fun new_bounded_value_checker(arg0: u64, arg1: u64, arg2: u64) : BoundedValueChecker {
        assert!(arg0 < 10000, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::invalid_bound());
        assert!(arg1 < 10000, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::invalid_bound());
        BoundedValueChecker{
            deviation_lower_bound_bps : arg0,
            deviation_upper_bound_bps : arg1,
            max_update_time_gap_ms    : arg2,
        }
    }

    public(friend) fun primary_source(arg0: &AssetConfig) : u8 {
        *0x1::vector::borrow<u8>(0x2::vec_set::keys<u8>(&arg0.primary_sources), 0)
    }

    public(friend) fun pyth_source() : u8 {
        1
    }

    public(friend) fun stork_source() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

