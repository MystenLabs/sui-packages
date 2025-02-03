module 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::validation {
    public fun validate_borrow<T0>(arg0: &mut 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::Storage, arg1: u8, arg2: u64) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_reserve_type(arg0, arg1), 44005);
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_index(arg0, arg1);
        let v4 = 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::ray_math::ray_mul(v0, v2);
        let v5 = 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::ray_math::ray_mul(v1, v3);
        assert!(v5 + (arg2 as u256) < v4, 44004);
        assert!(0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::ray_math::ray_div(v5 + (arg2 as u256), v4), 44003);
    }

    public fun validate_deposit<T0>(arg0: &mut 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::Storage, arg1: u8, arg2: u64) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_reserve_type(arg0, arg1), 44005);
        assert!(arg2 != 0, 44001);
        let (v0, _) = 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_total_supply(arg0, arg1);
        assert!(0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_supply_cap_ceiling(arg0, arg1) >= (v0 + (arg2 as u256)) * 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::ray_math::ray(), 44002);
    }

    public fun validate_liquidate<T0, T1>(arg0: &mut 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::Storage, arg1: u8, arg2: u8, arg3: u64) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_reserve_type(arg0, arg1), 44005);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T1>()) == 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_reserve_type(arg0, arg2), 44005);
        assert!(arg3 != 0, 44001);
    }

    public fun validate_repay<T0>(arg0: &mut 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::Storage, arg1: u8, arg2: address, arg3: u64) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_reserve_type(arg0, arg1), 44005);
        assert!(arg3 != 0, 44001);
        assert!(0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::logic::user_loan_balance(arg0, arg1, arg2) > 0, 44007);
    }

    public fun validate_withdraw<T0>(arg0: &mut 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::Storage, arg1: u8, arg2: address, arg3: u64) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_reserve_type(arg0, arg1), 44005);
        assert!(arg3 != 0, 44001);
        assert!(0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::logic::user_collateral_balance(arg0, arg1, arg2) > 0, 44006);
        let (v0, v1) = 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::storage::get_total_supply(arg0, arg1);
        assert!(v0 >= v1 + (arg3 as u256), 44004);
    }

    // decompiled from Move bytecode v6
}

