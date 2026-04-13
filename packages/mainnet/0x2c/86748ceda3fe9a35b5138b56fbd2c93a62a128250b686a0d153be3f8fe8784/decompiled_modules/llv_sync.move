module 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_sync {
    fun assert_sync_deviation_within_guard<T0, T1>(arg0: &0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128) {
        let v0 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1);
        if (v0 == 0) {
            assert!(arg2 == 0, 1);
        } else if (arg2 != v0) {
            let v1 = if (arg2 > v0) {
                arg2 - v0
            } else {
                v0 - arg2
            };
            let v2 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_math::mul_div(v0, (0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_max_sync_deviation_bps<T0, T1>(arg0) as u128), 10000);
            let v3 = if (v2 == 0) {
                1
            } else {
                v2
            };
            assert!(v1 <= v3, 1);
        };
    }

    public(friend) fun sync_balances<T0, T1>(arg0: &mut 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T0, T1>, arg1: vector<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>(&arg1)) {
            let v1 = 0x1::vector::borrow<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>(&arg1, v0);
            sync_protocol_balance<T0, T1>(arg0, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::protocol_id(v1), 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::amount(v1), arg2);
            v0 = v0 + 1;
        };
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_events::emit_balances_synced(0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::id<T0, T1>(arg0), arg1, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_total_assets<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun sync_protocol_balance<T0, T1>(arg0: &mut 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        let v0 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::update_protocol_balance<T0, T1>(arg0, arg1, arg2, v1);
        if (arg2 != v0) {
            let v2 = if (arg2 > v0) {
                arg2 - v0
            } else {
                0
            };
            0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_events::emit_accrue_interest(0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::id<T0, T1>(arg0), arg1, v0, arg2, v2, v1);
        };
    }

    public(friend) fun sync_protocol_balance_guarded<T0, T1>(arg0: &mut 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        assert_sync_deviation_within_guard<T0, T1>(arg0, arg1, arg2);
        sync_protocol_balance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

