module 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall {
    struct AdminRecallReceipt<phantom T0> {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        requested_amount: u128,
        recall_balance: 0x2::balance::Balance<T0>,
    }

    struct AdminRecallWithdrawTicket<phantom T0> {
        protocol_id: u8,
        amount_extracted: u64,
    }

    public fun add_recall_withdraw_leg<T0, T1, T2>(arg0: &mut AdminRecallReceipt<T0>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T0>, arg4: &T2) {
        assert!(arg0.pool_id == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2);
        0x2::balance::join<T0>(&mut arg0.recall_balance, arg3);
    }

    public fun begin_admin_recall_to_idle<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) : AdminRecallReceipt<T0> {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1));
        assert!(!0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::is_idle_protocol(arg3), 200);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::begin_operation<T0, T1>(arg1);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_protocol_fresh<T0, T1>(arg1, arg3, 0x2::clock::timestamp_ms(arg5));
        let v0 = 0x2::clock::timestamp_ms(arg5);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::accrue_fees<T0, T1>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_total_assets<T0, T1>(arg1), v0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_admin_recall_started(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), arg3, v0);
        AdminRecallReceipt<T0>{
            pool_id          : 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1),
            protocol_id      : arg3,
            requested_amount : (arg4 as u128),
            recall_balance   : 0x2::balance::zero<T0>(),
        }
    }

    public fun begin_recall_withdraw_leg<T0, T1, T2, T3>(arg0: &AdminRecallReceipt<T0>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &T3) : (0x2::balance::Balance<T2>, AdminRecallWithdrawTicket<T0>) {
        assert!(arg0.pool_id == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2);
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::extract_balance<T0, T1, T2>(arg1, arg2, arg3);
        let v1 = AdminRecallWithdrawTicket<T0>{
            protocol_id      : arg2,
            amount_extracted : 0x2::balance::value<T2>(&v0),
        };
        (v0, v1)
    }

    public fun borrow_cap_for_recall<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &AdminRecallReceipt<T0>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &T4) : &T3 {
        assert!(arg0.pool_id == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2);
        0x2::dynamic_field::borrow<T2, T3>(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::borrow_uid<T0, T1>(arg1), arg3)
    }

    public fun borrow_cap_for_recall_mut<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &AdminRecallReceipt<T0>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &T4) : &mut T3 {
        assert!(arg0.pool_id == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2);
        0x2::dynamic_field::borrow_mut<T2, T3>(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::borrow_uid_mut<T0, T1>(arg1), arg3)
    }

    public fun complete_admin_recall_to_idle<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: AdminRecallReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let AdminRecallReceipt {
            pool_id          : v0,
            protocol_id      : v1,
            requested_amount : v2,
            recall_balance   : v3,
        } = arg1;
        let v4 = v3;
        assert!(v0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg0), 8);
        let v5 = (0x2::balance::value<T0>(&v4) as u128);
        assert!(v5 <= v2, 202);
        if (v5 > 0) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::record_withdraw<T0, T1>(arg0, v1, v5, 0x2::clock::timestamp_ms(arg2));
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::store_or_join_idle_balance<T0, T1>(arg0, v4);
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::record_deposit<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_IDLE(), v5, 0);
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::refresh_idle_balance<T0, T1>(arg0);
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::end_operation<T0, T1>(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_admin_recalled_to_idle(v0, v1, v5, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_balance<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_IDLE()), 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2));
    }

    public fun extract_recall_holding<T0, T1, T2, T3>(arg0: &AdminRecallReceipt<T0>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &T3) : 0x2::balance::Balance<T2> {
        assert!(arg0.pool_id == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::extract_balance<T0, T1, T2>(arg1, arg2, arg3)
    }

    public fun finish_recall_withdraw_leg<T0, T1, T2>(arg0: &mut AdminRecallReceipt<T0>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: AdminRecallWithdrawTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &T2) {
        assert!(arg0.pool_id == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 8);
        let AdminRecallWithdrawTicket {
            protocol_id      : _,
            amount_extracted : v1,
        } = arg2;
        if (v1 > 0) {
            assert!(0x2::balance::value<T0>(&arg3) > 0, 14);
        };
        0x2::balance::join<T0>(&mut arg0.recall_balance, arg3);
    }

    public fun recall_balance_value<T0>(arg0: &AdminRecallReceipt<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.recall_balance)
    }

    public fun receipt_pool_id<T0>(arg0: &AdminRecallReceipt<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun receipt_protocol_id<T0>(arg0: &AdminRecallReceipt<T0>) : u8 {
        arg0.protocol_id
    }

    public fun receipt_requested_amount<T0>(arg0: &AdminRecallReceipt<T0>) : u128 {
        arg0.requested_amount
    }

    public fun store_recall_holding<T0, T1, T2, T3>(arg0: &AdminRecallReceipt<T0>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T2>, arg4: &T3) {
        assert!(arg0.pool_id == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 8);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::store_or_join_balance<T0, T1, T2>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

