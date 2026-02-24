module 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_withdraw {
    struct WithdrawResult has copy, drop {
        shares_to_burn: u128,
        assets_to_receive: u128,
        recall_plan: vector<0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::ProtocolAmount>,
    }

    public(friend) fun record_withdraw<T0>(arg0: &mut 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::LLVPool<T0>, arg1: &WithdrawResult, arg2: &vector<0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::ProtocolAmount>, arg3: u64, arg4: 0x2::object::ID, arg5: address, arg6: &0x2::clock::Clock) {
        record_withdraw_state<T0>(arg0, arg1.shares_to_burn, arg2);
        0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_events::emit_withdrawn(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::id<T0>(arg0), arg4, arg5, arg1.shares_to_burn, arg3, *arg2, 0x2::clock::timestamp_ms(arg6));
    }

    public fun assets_to_receive(arg0: &WithdrawResult) : u128 {
        arg0.assets_to_receive
    }

    fun calculate_recall_plan_with_queue<T0>(arg0: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::LLVPool<T0>, arg1: u128) : vector<0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::ProtocolAmount> {
        let v0 = arg1;
        let v1 = 0x1::vector::empty<0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::ProtocolAmount>();
        let v2 = 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::get_withdraw_queue<T0>(arg0);
        let v3 = 0x1::vector::length<u8>(&v2);
        assert!(v3 > 0, 7);
        let v4 = 0;
        while (v4 < v3 && v0 > 0) {
            let v5 = *0x1::vector::borrow<u8>(&v2, v4);
            let v6 = 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::get_protocol_balance<T0>(arg0, v5);
            let v7 = if (v0 < v6) {
                v0
            } else {
                v6
            };
            if (v7 > 0) {
                0x1::vector::push_back<0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::ProtocolAmount>(&mut v1, 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::create(v5, v7));
                v0 = v0 - v7;
            };
            v4 = v4 + 1;
        };
        assert!(v0 == 0, 5);
        v1
    }

    public fun calculate_withdraw_all<T0>(arg0: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::LLVPool<T0>, arg1: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::LLVPoolPosition<T0>) : WithdrawResult {
        calculate_withdraw_by_shares<T0>(arg0, arg1, 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::shares<T0>(arg1))
    }

    public fun calculate_withdraw_by_assets<T0>(arg0: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::LLVPool<T0>, arg1: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::LLVPoolPosition<T0>, arg2: u64) : WithdrawResult {
        assert!(!0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::is_paused<T0>(arg0), 1);
        assert!(arg2 > 0, 2);
        assert!(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::pool_id<T0>(arg1) == 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::id<T0>(arg0), 3);
        let v0 = 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_math::calculate_shares_for_assets(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::total_shares<T0>(arg0), 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::get_total_assets<T0>(arg0), arg2);
        assert!(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::shares<T0>(arg1) >= v0, 4);
        let v1 = (arg2 as u128);
        WithdrawResult{
            shares_to_burn    : v0,
            assets_to_receive : v1,
            recall_plan       : calculate_recall_plan_with_queue<T0>(arg0, v1),
        }
    }

    public fun calculate_withdraw_by_shares<T0>(arg0: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::LLVPool<T0>, arg1: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::LLVPoolPosition<T0>, arg2: u128) : WithdrawResult {
        assert!(!0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::is_paused<T0>(arg0), 1);
        assert!(arg2 > 0, 2);
        assert!(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::pool_id<T0>(arg1) == 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::id<T0>(arg0), 3);
        assert!(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::shares<T0>(arg1) >= arg2, 4);
        let v0 = 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::get_total_assets<T0>(arg0);
        let v1 = 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_math::calculate_assets_for_shares(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::total_shares<T0>(arg0), v0, arg2);
        let v2 = v1;
        if (v1 > v0) {
            v2 = v0;
        };
        WithdrawResult{
            shares_to_burn    : arg2,
            assets_to_receive : v2,
            recall_plan       : calculate_recall_plan_with_queue<T0>(arg0, v2),
        }
    }

    public fun calculate_withdraw_with_queue<T0>(arg0: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::LLVPool<T0>, arg1: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::LLVPoolPosition<T0>, arg2: u128) : WithdrawResult {
        assert!(!0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::is_paused<T0>(arg0), 1);
        assert!(arg2 > 0, 2);
        assert!(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::pool_id<T0>(arg1) == 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::id<T0>(arg0), 3);
        assert!(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::shares<T0>(arg1) >= arg2, 4);
        let v0 = 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::get_total_assets<T0>(arg0);
        let v1 = 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_math::calculate_assets_for_shares(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::total_shares<T0>(arg0), v0, arg2);
        let v2 = v1;
        if (v1 > v0) {
            v2 = v0;
        };
        WithdrawResult{
            shares_to_burn    : arg2,
            assets_to_receive : v2,
            recall_plan       : calculate_recall_plan_with_queue<T0>(arg0, v2),
        }
    }

    public(friend) fun deduct_from_position<T0>(arg0: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::LLVPool<T0>, arg1: &mut 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::LLVPoolPosition<T0>, arg2: u128, arg3: u128) : u128 {
        assert!(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::pool_id<T0>(arg1) == 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::id<T0>(arg0), 3);
        0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::deduct_shares<T0>(arg1, arg2, arg3)
    }

    public(friend) fun destroy_empty_position<T0>(arg0: 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::LLVPoolPosition<T0>) {
        0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::destroy_empty<T0>(arg0);
    }

    public fun is_position_empty<T0>(arg0: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::LLVPoolPosition<T0>) : bool {
        0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::is_empty<T0>(arg0)
    }

    fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun query_max_withdrawable<T0>(arg0: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::LLVPool<T0>) : u128 {
        let v0 = 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::get_withdraw_queue<T0>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            v1 = v1 + 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::get_protocol_balance<T0>(arg0, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun query_user_max_withdraw<T0>(arg0: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::LLVPool<T0>, arg1: &0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::LLVPoolPosition<T0>) : u128 {
        assert!(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::pool_id<T0>(arg1) == 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::id<T0>(arg0), 3);
        min_u128(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_math::calculate_assets_for_shares(0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::total_shares<T0>(arg0), 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::get_total_assets<T0>(arg0), 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_position::shares<T0>(arg1)), query_max_withdrawable<T0>(arg0))
    }

    public fun recall_plan(arg0: &WithdrawResult) : &vector<0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::ProtocolAmount> {
        &arg0.recall_plan
    }

    public(friend) fun record_withdraw_state<T0>(arg0: &mut 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::LLVPool<T0>, arg1: u128, arg2: &vector<0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::total_shares<T0>(arg0) - arg1;
        0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::set_total_shares<T0>(arg0, v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::ProtocolAmount>(arg2)) {
            let v2 = 0x1::vector::borrow<0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::ProtocolAmount>(arg2, v1);
            let v3 = 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::amount(v2);
            if (v3 > 0) {
                0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::record_withdraw<T0>(arg0, 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_allocation_plan::protocol_id(v2), v3);
            };
            v1 = v1 + 1;
        };
        0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::set_yield_index<T0>(arg0, 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_math::calculate_yield_index(v0, 0x7d27a6f3369bd7d61f4c6f859a8c1face5a11b18a17e07c2c8be3a5c4f7cd0e1::llv_pool::get_total_assets<T0>(arg0)));
    }

    public fun shares_to_burn(arg0: &WithdrawResult) : u128 {
        arg0.shares_to_burn
    }

    public fun verify_min_assets(arg0: u128, arg1: u64) {
        assert!(arg0 >= (arg1 as u128), 6);
    }

    // decompiled from Move bytecode v6
}

