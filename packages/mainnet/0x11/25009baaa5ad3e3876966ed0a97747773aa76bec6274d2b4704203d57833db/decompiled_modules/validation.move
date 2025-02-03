module 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::validation {
    public fun validate_borrow<T0>(arg0: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_coin_type(arg0, arg1), 44005);
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_index(arg0, arg1);
        let v4 = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::ray_math::ray_mul(v0, v2);
        let v5 = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::ray_math::ray_mul(v1, v3);
        assert!(v5 + arg2 < v4, 44004);
        assert!(0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::ray_math::ray_div(v5 + arg2, v4), 44003);
    }

    public fun validate_deposit<T0>(arg0: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_coin_type(arg0, arg1), 44005);
        assert!(arg2 != 0, 44001);
        let (v0, _) = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_total_supply(arg0, arg1);
        let (v2, _) = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_index(arg0, arg1);
        assert!(0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_supply_cap_ceiling(arg0, arg1) >= (0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::ray_math::ray_mul(v0, v2) + arg2) * 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::ray_math::ray(), 44002);
    }

    public fun validate_liquidate<T0, T1>(arg0: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg1: u8, arg2: u8, arg3: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_coin_type(arg0, arg1), 44005);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T1>()) == 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_coin_type(arg0, arg2), 44005);
        assert!(arg3 != 0, 44001);
    }

    public fun validate_repay<T0>(arg0: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_coin_type(arg0, arg1), 44005);
        assert!(arg2 != 0, 44001);
    }

    public fun validate_withdraw<T0>(arg0: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_coin_type(arg0, arg1), 44005);
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_index(arg0, arg1);
        assert!(0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::ray_math::ray_mul(v0, v2) >= 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::ray_math::ray_mul(v1, v3) + arg2, 44004);
    }

    // decompiled from Move bytecode v6
}

