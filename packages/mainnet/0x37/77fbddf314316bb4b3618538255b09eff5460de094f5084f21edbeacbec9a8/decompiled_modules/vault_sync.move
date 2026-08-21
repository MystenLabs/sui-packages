module 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_sync {
    public(friend) fun sync_balances<T0, T1>(arg0: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg1: vector<0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::ProtocolAmount>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::ProtocolAmount>(&arg1)) {
            let v1 = 0x1::vector::borrow<0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::ProtocolAmount>(&arg1, v0);
            sync_protocol_balance<T0, T1>(arg0, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::protocol_id(v1), 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::amount(v1), arg2);
            v0 = v0 + 1;
        };
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_events::emit_balances_synced(0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::id<T0, T1>(arg0), arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::get_total_assets<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun sync_protocol_balance<T0, T1>(arg0: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        let v0 = 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::get_protocol_balance<T0, T1>(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::get_protocol_last_sync_ms<T0, T1>(arg0, arg1) == v1 && arg2 == v0) {
            return
        };
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::update_protocol_balance<T0, T1>(arg0, arg1, arg2, v1);
        if (arg2 != v0) {
            let v2 = if (arg2 > v0) {
                arg2 - v0
            } else {
                0
            };
            0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_events::emit_accrue_interest(0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::id<T0, T1>(arg0), arg1, v0, arg2, v2, v1);
        };
    }

    public(friend) fun sync_protocol_balance_guarded<T0, T1>(arg0: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        let v0 = 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::get_protocol_balance<T0, T1>(arg0, arg1);
        if (v0 == 0) {
            assert!(arg2 == 0 || 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::get_protocol_deposited_amount<T0, T1>(arg0, arg1) == 0 && arg2 <= 0x1::u128::pow(10, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::asset_decimals<T0, T1>(arg0) - 3), 1);
        } else if (arg2 != v0) {
            let v1 = if (arg2 > v0) {
                arg2 - v0
            } else {
                v0 - arg2
            };
            let v2 = 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_math::mul_div(v0, (0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::get_max_sync_deviation_bps<T0, T1>(arg0) as u128), 10000);
            let v3 = 0x1::u128::pow(10, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::asset_decimals<T0, T1>(arg0) - 3);
            let v4 = if (v2 > v3) {
                v2
            } else {
                v3
            };
            assert!(v1 <= v4, 1);
        };
        sync_protocol_balance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

