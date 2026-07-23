module 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall {
    struct AdminRecallReceipt<phantom T0> {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        requested_amount: u128,
        source_debit: u128,
        has_receipt_token_leg: bool,
        recall_balance: 0x2::balance::Balance<T0>,
    }

    struct AdminRecallWithdrawTicket<phantom T0> {
        protocol_id: u8,
        amount_extracted: u64,
        source_debit: u128,
    }

    public fun add_recall_withdraw_leg<T0, T1, T2>(arg0: &mut AdminRecallReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T0>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2, arg4);
        0x2::balance::join<T0>(&mut arg0.recall_balance, arg3);
        arg0.source_debit = arg0.source_debit + (0x2::balance::value<T0>(&arg3) as u128);
    }

    public fun begin_admin_recall_to_idle<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : AdminRecallReceipt<T0> {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::assert_version(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_pool_admin<T0, T1>(arg1, 0x2::tx_context::sender(arg5));
        assert!(!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_idle_protocol(arg2), 200);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::begin_operation<T0, T1>(arg1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_fresh<T0, T1>(arg1, arg2, 0x2::clock::timestamp_ms(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::accrue_fees<T0, T1>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg1), v0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_admin_recall_started(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), arg2, v0);
        AdminRecallReceipt<T0>{
            pool_id               : 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1),
            protocol_id           : arg2,
            requested_amount      : (arg3 as u128),
            source_debit          : 0,
            has_receipt_token_leg : false,
            recall_balance        : 0x2::balance::zero<T0>(),
        }
    }

    public fun begin_recall_withdraw_leg<T0, T1, T2, T3>(arg0: &AdminRecallReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T3>) : (0x2::balance::Balance<T2>, AdminRecallWithdrawTicket<T0>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2, arg4);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::query_holding_balance<T0, T1, T2>(arg1, arg2);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::extract_balance<T0, T1, T2>(arg1, arg2, arg3);
        let v2 = 0x2::balance::value<T2>(&v1);
        let v3 = if (v2 == 0 || v0 == 0) {
            0
        } else {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg1, arg2), (v2 as u128), (v0 as u128))
        };
        let v4 = AdminRecallWithdrawTicket<T0>{
            protocol_id      : arg2,
            amount_extracted : v2,
            source_debit     : v3,
        };
        (v1, v4)
    }

    public fun borrow_cap_for_recall<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &AdminRecallReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T4>) : &T3 {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2, arg4);
        0x2::dynamic_field::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::ProtocolCapKey<T2>, T3>(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::borrow_uid<T0, T1>(arg1), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::protocol_cap_key<T2>(arg2, arg3))
    }

    public fun borrow_cap_for_recall_mut<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &AdminRecallReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T4>) : &mut T3 {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2, arg4);
        0x2::dynamic_field::borrow_mut<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::ProtocolCapKey<T2>, T3>(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::borrow_uid_mut<T0, T1>(arg1), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::protocol_cap_key<T2>(arg2, arg3))
    }

    public fun complete_admin_recall_to_idle<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: AdminRecallReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let AdminRecallReceipt {
            pool_id               : v0,
            protocol_id           : v1,
            requested_amount      : v2,
            source_debit          : v3,
            has_receipt_token_leg : v4,
            recall_balance        : v5,
        } = arg1;
        let v6 = v5;
        assert!(v0 == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg0), 8);
        let v7 = (0x2::balance::value<T0>(&v6) as u128);
        if (!v4) {
            assert!(v7 <= v2, 202);
        };
        assert!(v7 >= v3, 203);
        if (v7 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_withdraw_preserve_report<T0, T1>(arg0, v1, v3);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::invalidate_protocol_report<T0, T1>(arg0, v1);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_or_join_idle_balance<T0, T1>(arg0, v6);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_deposit<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE(), v7, 0);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::refresh_idle_balance<T0, T1>(arg0);
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::end_operation<T0, T1>(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_admin_recalled_to_idle(v0, v1, v7, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE()), 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2));
    }

    public fun extract_recall_holding<T0, T1, T2, T3>(arg0: &AdminRecallReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T3>) : 0x2::balance::Balance<T2> {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2, arg4);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::extract_balance<T0, T1, T2>(arg1, arg2, arg3)
    }

    public fun finish_recall_withdraw_leg<T0, T1, T2>(arg0: &mut AdminRecallReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: AdminRecallWithdrawTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        let AdminRecallWithdrawTicket {
            protocol_id      : v0,
            amount_extracted : v1,
            source_debit     : v2,
        } = arg2;
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0, arg4);
        if (v1 > 0) {
            assert!(0x2::balance::value<T0>(&arg3) > 0, 14);
        };
        assert!((0x2::balance::value<T0>(&arg3) as u128) >= v2, 203);
        0x2::balance::join<T0>(&mut arg0.recall_balance, arg3);
        arg0.source_debit = arg0.source_debit + v2;
        arg0.has_receipt_token_leg = true;
    }

    public fun finish_recall_withdraw_leg_accounted<T0, T1, T2>(arg0: &mut AdminRecallReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: AdminRecallWithdrawTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!((arg4 as u128) == arg2.source_debit, 203);
        finish_recall_withdraw_leg<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6);
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

    public fun store_recall_holding<T0, T1, T2, T3>(arg0: &AdminRecallReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T2>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T3>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        assert!(arg0.protocol_id == arg2, 201);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2, arg4);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_or_join_balance<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun withdraw_ticket_source_debit<T0>(arg0: &AdminRecallWithdrawTicket<T0>) : u128 {
        arg0.source_debit
    }

    // decompiled from Move bytecode v7
}

