module 0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_sync {
    public fun get_protocol_balance<T0>(arg0: &0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::LLVPool<T0>, arg1: u8) : u128 {
        0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::get_protocol_balance<T0>(arg0, arg1)
    }

    public fun get_synced_total_assets<T0>(arg0: &0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::LLVPool<T0>) : u128 {
        0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::get_total_assets<T0>(arg0)
    }

    public(friend) fun sync_balances<T0>(arg0: &mut 0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::LLVPool<T0>, arg1: vector<0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_allocation_plan::ProtocolAmount>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_allocation_plan::ProtocolAmount>(&arg1)) {
            let v2 = 0x1::vector::borrow<0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_allocation_plan::ProtocolAmount>(&arg1, v1);
            let v3 = 0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_allocation_plan::protocol_id(v2);
            let v4 = 0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_allocation_plan::amount(v2);
            validate_balance_update(0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::get_protocol_balance<T0>(arg0, v3), v4);
            0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::update_protocol_balance<T0>(arg0, v3, v4, v0);
            v1 = v1 + 1;
        };
        let v5 = 0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::get_total_assets<T0>(arg0);
        let v6 = 0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_math::calculate_yield_index(0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::total_shares<T0>(arg0), v5);
        0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::set_yield_index<T0>(arg0, v6);
        0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_events::emit_balances_synced(0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::id<T0>(arg0), arg1, v5, v6, v0);
    }

    public(friend) fun sync_protocol_balance<T0>(arg0: &mut 0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::LLVPool<T0>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        validate_balance_update(0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::get_protocol_balance<T0>(arg0, arg1), arg2);
        0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::update_protocol_balance<T0>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3));
        0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::set_yield_index<T0>(arg0, 0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_math::calculate_yield_index(0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::total_shares<T0>(arg0), 0x4b93e2827ba0ef63e0e4d376db457f6fc4e199939c495f48a6f816baf02f9dcc::llv_pool::get_total_assets<T0>(arg0)));
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

