module 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_withdraw {
    struct WithdrawResult has copy, drop {
        shares_to_burn: u128,
        assets_to_receive: u128,
        recall_plan: vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>,
    }

    fun append_protocol_recall_if_available<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: &mut u128, arg3: &mut vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>) {
        if (!0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::is_protocol_withdraw_enabled<T0, T1>(arg0, arg1)) {
            return
        };
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1);
        let v1 = if (*arg2 < v0) {
            *arg2
        } else {
            v0
        };
        if (v1 > 0) {
            0x1::vector::push_back<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(arg3, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::create(arg1, v1));
            *arg2 = *arg2 - v1;
        };
    }

    public fun assets_to_receive(arg0: &WithdrawResult) : u128 {
        arg0.assets_to_receive
    }

    public fun calculate_recall_plan_best_effort<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: u128) : (vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>, u128) {
        let v0 = 0x1::vector::empty<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>();
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_withdraw_queue<T0, T1>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1) && arg1 > 0) {
            let v3 = &mut arg1;
            let v4 = &mut v0;
            append_protocol_recall_if_available<T0, T1>(arg0, *0x1::vector::borrow<u8>(&v1, v2), v3, v4);
            v2 = v2 + 1;
        };
        if (arg1 > 0 && should_include_implicit_idle_fallback(&v1)) {
            let v5 = &mut arg1;
            let v6 = &mut v0;
            append_protocol_recall_if_available<T0, T1>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_IDLE(), v5, v6);
        };
        (v0, arg1 - arg1)
    }

    fun calculate_recall_plan_with_queue<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: u128) : vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount> {
        let v0 = 0x1::vector::empty<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>();
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_withdraw_queue<T0, T1>(arg0);
        let v2 = 0x1::vector::length<u8>(&v1);
        let v3 = 0;
        while (v3 < v2 && arg1 > 0) {
            let v4 = &mut arg1;
            let v5 = &mut v0;
            append_protocol_recall_if_available<T0, T1>(arg0, *0x1::vector::borrow<u8>(&v1, v3), v4, v5);
            v3 = v3 + 1;
        };
        if (arg1 > 0 && should_include_implicit_idle_fallback(&v1)) {
            let v6 = &mut arg1;
            let v7 = &mut v0;
            append_protocol_recall_if_available<T0, T1>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_IDLE(), v6, v7);
        };
        if (v2 == 0 && 0x1::vector::length<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(&v0) == 0) {
            abort 5
        };
        assert!(arg1 == 0, 3);
        v0
    }

    public fun calculate_withdraw_by_assets<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: u64, arg2: u128) : WithdrawResult {
        assert!(arg1 > 0, 2);
        let v0 = if (arg2 > 0) {
            arg2
        } else {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_total_assets<T0, T1>(arg0)
        };
        let v1 = (arg1 as u128);
        WithdrawResult{
            shares_to_burn    : 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_math::calculate_shares_for_assets(0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::total_shares<T0, T1>(arg0), v0, arg1),
            assets_to_receive : v1,
            recall_plan       : calculate_recall_plan_with_queue<T0, T1>(arg0, v1),
        }
    }

    public fun calculate_withdraw_by_shares<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: u128) : WithdrawResult {
        assert!(arg1 > 0, 2);
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_total_assets<T0, T1>(arg0);
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_math::calculate_assets_for_shares(0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::total_shares<T0, T1>(arg0), v0, arg1);
        let v2 = v1;
        if (v1 > v0) {
            v2 = v0;
        };
        WithdrawResult{
            shares_to_burn    : arg1,
            assets_to_receive : v2,
            recall_plan       : calculate_recall_plan_with_queue<T0, T1>(arg0, v2),
        }
    }

    fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun query_max_withdrawable<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>) : u128 {
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_withdraw_queue<T0, T1>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            v1 = v1 + query_protocol_withdrawable_balance<T0, T1>(arg0, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        if (should_include_implicit_idle_fallback(&v0)) {
            v1 = v1 + query_protocol_withdrawable_balance<T0, T1>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_IDLE());
        };
        v1
    }

    public fun query_max_withdrawable_shares<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>) : u128 {
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_total_assets<T0, T1>(arg0);
        if (v0 == 0) {
            return 0
        };
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_math::calculate_max_shares_for_assets_u128(0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::total_shares<T0, T1>(arg0), v0, query_max_withdrawable<T0, T1>(arg0))
    }

    fun query_protocol_withdrawable_balance<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: u8) : u128 {
        if (!0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::is_protocol_withdraw_enabled<T0, T1>(arg0, arg1)) {
            return 0
        };
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1)
    }

    public fun query_user_max_withdraw<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: u128) : u128 {
        min_u128(0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_math::calculate_assets_for_shares(0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::total_shares<T0, T1>(arg0), 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_total_assets<T0, T1>(arg0), arg1), query_max_withdrawable<T0, T1>(arg0))
    }

    fun queue_contains_protocol(arg0: &vector<u8>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun recall_plan(arg0: &WithdrawResult) : &vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount> {
        &arg0.recall_plan
    }

    public(friend) fun record_withdraw_state<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: &vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(arg1)) {
            let v1 = 0x1::vector::borrow<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(arg1, v0);
            let v2 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::amount(v1);
            if (v2 > 0) {
                0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_withdraw<T0, T1>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::protocol_id(v1), v2, arg2);
            };
            v0 = v0 + 1;
        };
    }

    public fun shares_to_burn(arg0: &WithdrawResult) : u128 {
        arg0.shares_to_burn
    }

    fun should_include_implicit_idle_fallback(arg0: &vector<u8>) : bool {
        0x1::vector::length<u8>(arg0) > 0 && !queue_contains_protocol(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_IDLE())
    }

    public fun verify_min_assets(arg0: u128, arg1: u64) {
        assert!(arg0 >= (arg1 as u128), 4);
    }

    // decompiled from Move bytecode v7
}

