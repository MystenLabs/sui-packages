module 0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_sync {
    public fun get_protocol_balance<T0>(arg0: &0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::LLVPool<T0>, arg1: u8) : u128 {
        0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::get_protocol_balance<T0>(arg0, arg1)
    }

    public fun get_synced_total_assets<T0>(arg0: &0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::LLVPool<T0>) : u128 {
        0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::get_total_assets<T0>(arg0)
    }

    public(friend) fun sync_balances<T0>(arg0: &mut 0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::LLVPool<T0>, arg1: vector<0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_allocation_plan::ProtocolAmount>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_allocation_plan::ProtocolAmount>(&arg1)) {
            let v2 = 0x1::vector::borrow<0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_allocation_plan::ProtocolAmount>(&arg1, v1);
            let v3 = 0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_allocation_plan::protocol_id(v2);
            let v4 = 0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_allocation_plan::amount(v2);
            validate_balance_update(0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::get_protocol_balance<T0>(arg0, v3), v4);
            0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::update_protocol_balance<T0>(arg0, v3, v4, v0);
            v1 = v1 + 1;
        };
        let v5 = 0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::get_total_assets<T0>(arg0);
        let v6 = 0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_math::calculate_yield_index(0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::total_shares<T0>(arg0), v5);
        0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::set_yield_index<T0>(arg0, v6);
        0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_events::emit_balances_synced(0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::id<T0>(arg0), arg1, v5, v6, v0);
    }

    public(friend) fun sync_protocol_balance<T0>(arg0: &mut 0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::LLVPool<T0>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        validate_balance_update(0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::get_protocol_balance<T0>(arg0, arg1), arg2);
        0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::update_protocol_balance<T0>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3));
        0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::set_yield_index<T0>(arg0, 0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_math::calculate_yield_index(0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::total_shares<T0>(arg0), 0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_pool::get_total_assets<T0>(arg0)));
    }

    fun validate_balance_update(arg0: u128, arg1: u128) {
        if (arg1 <= arg0) {
            return
        };
        if (arg0 == 0) {
            return
        };
        assert!((arg1 - arg0) * 10000 / arg0 <= 20000, 1);
    }

    // decompiled from Move bytecode v6
}

