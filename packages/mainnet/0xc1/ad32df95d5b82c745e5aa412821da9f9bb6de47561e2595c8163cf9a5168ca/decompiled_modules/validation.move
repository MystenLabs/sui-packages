module 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::validation {
    public fun validate_borrow<T0>(arg0: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_coin_type(arg0, arg1), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_coin_type());
        assert!(arg2 != 0, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_amount());
        let (v0, v1) = 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_index(arg0, arg1);
        let v4 = 0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::ray_math::ray_mul(v0, v2);
        let v5 = 0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::ray_math::ray_mul(v1, v3);
        assert!(v5 + arg2 < v4, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::insufficient_balance());
        assert!(0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::ray_math::ray_div(v5 + arg2, v4), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::exceeded_maximum_borrow_cap());
    }

    public fun validate_deposit<T0>(arg0: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_coin_type(arg0, arg1), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_coin_type());
        assert!(arg2 != 0, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_amount());
        let (v0, _) = 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_total_supply(arg0, arg1);
        let (v2, _) = 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_index(arg0, arg1);
        assert!(0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_supply_cap_ceiling(arg0, arg1) >= (0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::ray_math::ray_mul(v0, v2) + arg2) * 0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::ray_math::ray(), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::exceeded_maximum_deposit_cap());
    }

    public fun validate_liquidate<T0, T1>(arg0: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg1: u8, arg2: u8, arg3: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_coin_type(arg0, arg1), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_coin_type());
        assert!(0x1::type_name::into_string(0x1::type_name::get<T1>()) == 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_coin_type(arg0, arg2), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_coin_type());
        assert!(arg3 != 0, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_amount());
    }

    public fun validate_repay<T0>(arg0: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_coin_type(arg0, arg1), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_coin_type());
        assert!(arg2 != 0, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_amount());
    }

    public fun validate_withdraw<T0>(arg0: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_coin_type(arg0, arg1), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_coin_type());
        assert!(arg2 != 0, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_amount());
        let (v0, v1) = 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::get_index(arg0, arg1);
        assert!(0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::ray_math::ray_mul(v0, v2) >= 0x934a15b6a5e5bbe9f9cd0a74f91e8500b069aa99dd8fc318cef8e9c684f96a87::ray_math::ray_mul(v1, v3) + arg2, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::insufficient_balance());
    }

    // decompiled from Move bytecode v6
}

