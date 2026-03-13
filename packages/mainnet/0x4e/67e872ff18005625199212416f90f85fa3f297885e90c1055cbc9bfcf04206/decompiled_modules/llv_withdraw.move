module 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_withdraw {
    struct WithdrawResult has copy, drop {
        shares_to_burn: u128,
        assets_to_receive: u128,
        recall_plan: vector<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount>,
    }

    public(friend) fun record_withdraw<T0, T1>(arg0: &mut 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::LLVPool<T0, T1>, arg1: &WithdrawResult, arg2: &vector<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock) {
        record_withdraw_state<T0, T1>(arg0, arg1.shares_to_burn, arg2);
        0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_events::emit_withdrawn(0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::id<T0, T1>(arg0), arg4, arg1.shares_to_burn, arg3, *arg2, 0x2::clock::timestamp_ms(arg5));
        0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_events::emit_vault_withdraw(0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::id<T0, T1>(arg0), arg4, (arg3 as u128), arg1.shares_to_burn, *arg2, 0x2::clock::timestamp_ms(arg5));
    }

    public fun assets_to_receive(arg0: &WithdrawResult) : u128 {
        arg0.assets_to_receive
    }

    fun calculate_recall_plan_with_queue<T0, T1>(arg0: &0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::LLVPool<T0, T1>, arg1: u128) : vector<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount> {
        let v0 = arg1;
        let v1 = 0x1::vector::empty<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount>();
        let v2 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_withdraw_queue<T0, T1>(arg0);
        let v3 = 0x1::vector::length<u8>(&v2);
        assert!(v3 > 0, 5);
        let v4 = 0;
        while (v4 < v3 && v0 > 0) {
            let v5 = *0x1::vector::borrow<u8>(&v2, v4);
            let v6 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_protocol_balance<T0, T1>(arg0, v5);
            let v7 = if (v0 < v6) {
                v0
            } else {
                v6
            };
            if (v7 > 0) {
                0x1::vector::push_back<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount>(&mut v1, 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::create(v5, v7));
                v0 = v0 - v7;
            };
            v4 = v4 + 1;
        };
        assert!(v0 == 0, 3);
        v1
    }

    public fun calculate_withdraw_by_assets<T0, T1>(arg0: &0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::LLVPool<T0, T1>, arg1: u64) : WithdrawResult {
        assert!(!0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::is_paused<T0, T1>(arg0), 1);
        assert!(arg1 > 0, 2);
        let v0 = (arg1 as u128);
        WithdrawResult{
            shares_to_burn    : 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_math::calculate_shares_for_assets(0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::total_shares<T0, T1>(arg0), 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_total_assets<T0, T1>(arg0), arg1),
            assets_to_receive : v0,
            recall_plan       : calculate_recall_plan_with_queue<T0, T1>(arg0, v0),
        }
    }

    public fun calculate_withdraw_by_shares<T0, T1>(arg0: &0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::LLVPool<T0, T1>, arg1: u128) : WithdrawResult {
        assert!(!0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::is_paused<T0, T1>(arg0), 1);
        assert!(arg1 > 0, 2);
        let v0 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_total_assets<T0, T1>(arg0);
        let v1 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_math::calculate_assets_for_shares(0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::total_shares<T0, T1>(arg0), v0, arg1);
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

    public fun calculate_withdraw_with_queue<T0, T1>(arg0: &0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::LLVPool<T0, T1>, arg1: u128) : WithdrawResult {
        assert!(!0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::is_paused<T0, T1>(arg0), 1);
        assert!(arg1 > 0, 2);
        let v0 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_total_assets<T0, T1>(arg0);
        let v1 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_math::calculate_assets_for_shares(0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::total_shares<T0, T1>(arg0), v0, arg1);
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

    public fun query_max_withdrawable<T0, T1>(arg0: &0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::LLVPool<T0, T1>) : u128 {
        let v0 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_withdraw_queue<T0, T1>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            v1 = v1 + 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_protocol_balance<T0, T1>(arg0, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun query_user_max_withdraw<T0, T1>(arg0: &0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::LLVPool<T0, T1>, arg1: u128) : u128 {
        min_u128(0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_math::calculate_assets_for_shares(0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::total_shares<T0, T1>(arg0), 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_total_assets<T0, T1>(arg0), arg1), query_max_withdrawable<T0, T1>(arg0))
    }

    public fun recall_plan(arg0: &WithdrawResult) : &vector<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount> {
        &arg0.recall_plan
    }

    public(friend) fun record_withdraw_state<T0, T1>(arg0: &mut 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::LLVPool<T0, T1>, arg1: u128, arg2: &vector<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount>(arg2)) {
            let v1 = 0x1::vector::borrow<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount>(arg2, v0);
            let v2 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::amount(v1);
            if (v2 > 0) {
                0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::record_withdraw<T0, T1>(arg0, 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::protocol_id(v1), v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun shares_to_burn(arg0: &WithdrawResult) : u128 {
        arg0.shares_to_burn
    }

    public fun verify_min_assets(arg0: u128, arg1: u64) {
        assert!(arg0 >= (arg1 as u128), 4);
    }

    // decompiled from Move bytecode v6
}

