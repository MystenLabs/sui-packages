module 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_sync {
    fun assert_deviation_within_guard<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: bool, arg4: u64) {
        let v0 = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1);
        if (v0 == 0) {
            if (!arg3) {
                assert!(arg2 == 0, arg4);
            };
            return
        };
        if (arg2 != v0) {
            let v1 = if (arg2 > v0) {
                arg2 - v0
            } else {
                v0 - arg2
            };
            let v2 = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_math::mul_div(v0, (0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_max_sync_deviation_bps<T0, T1>(arg0) as u128), 10000);
            let v3 = sync_dust_floor<T0, T1>(arg0);
            let v4 = if (v2 > v3) {
                v2
            } else {
                v3
            };
            assert!(v1 <= v4, arg4);
        };
    }

    fun assert_receipt_sync_within_guard<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128) {
        assert_deviation_within_guard<T0, T1>(arg0, arg1, arg2, true, 2);
    }

    fun assert_sync_deviation_within_guard<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128) {
        assert_deviation_within_guard<T0, T1>(arg0, arg1, arg2, false, 1);
    }

    public(friend) fun sync_balances<T0, T1>(arg0: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg1: vector<0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::ProtocolAmount>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::ProtocolAmount>(&arg1)) {
            let v1 = 0x1::vector::borrow<0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::ProtocolAmount>(&arg1, v0);
            sync_protocol_balance<T0, T1>(arg0, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::protocol_id(v1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::amount(v1), arg2);
            v0 = v0 + 1;
        };
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_balances_synced(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg0), arg1, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_total_assets<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    fun sync_dust_floor<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>) : u128 {
        0x1::u128::pow(10, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::asset_decimals<T0, T1>(arg0) - 3)
    }

    public(friend) fun sync_protocol_balance<T0, T1>(arg0: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        let v0 = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_protocol_last_sync_ms<T0, T1>(arg0, arg1) == v1 && arg2 == v0) {
            return
        };
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::update_protocol_balance<T0, T1>(arg0, arg1, arg2, v1);
        if (arg2 != v0) {
            let v2 = if (arg2 > v0) {
                arg2 - v0
            } else {
                0
            };
            0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_accrue_interest(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg0), arg1, v0, arg2, v2, v1);
        };
    }

    public(friend) fun sync_protocol_balance_guarded<T0, T1>(arg0: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        assert_sync_deviation_within_guard<T0, T1>(arg0, arg1, arg2);
        sync_protocol_balance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun sync_protocol_balance_receipt_guarded<T0, T1>(arg0: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        assert_receipt_sync_within_guard<T0, T1>(arg0, arg1, arg2);
        sync_protocol_balance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

