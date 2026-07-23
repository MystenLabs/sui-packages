module 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance {
    struct RebalanceReceipt<phantom T0> {
        pool_id: 0x2::object::ID,
        expected_withdraw_plan: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        expected_deposit_plan: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        rebalance_balance: 0x2::balance::Balance<T0>,
        actual_withdraws: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        source_debits: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        actual_deposits: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        total_withdrawn: u128,
        total_deposited: u128,
        snapshot_total_assets: u128,
        snapshot_idle_balance: u128,
        timestamp_ms: u64,
    }

    struct RebalanceWithdrawTicket<phantom T0> {
        protocol_id: u8,
        amount_extracted: u64,
        source_debit: u128,
    }

    struct RebalanceDepositTicket<phantom T0> {
        protocol_id: u8,
        before_balance: u64,
    }

    fun add_idle_recall_withdrawals<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: &mut vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg2: u128) : u128 {
        let v0 = 0;
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_withdraw_queue<T0, T1>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1) && arg2 > 0) {
            let v3 = *0x1::vector::borrow<u8>(&v1, v2);
            if (!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_idle_protocol(v3) && 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::is_protocol_withdraw_enabled<T0, T1>(arg0, v3)) {
                let v4 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, v3);
                let v5 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(arg1, v3);
                let v6 = if (v4 > v5) {
                    v4 - v5
                } else {
                    0
                };
                let v7 = if (v6 < arg2) {
                    v6
                } else {
                    arg2
                };
                if (v7 > 0) {
                    0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(arg1, v3, v7);
                    arg2 = arg2 - v7;
                    v0 = v0 + v6;
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun add_rebalance_withdraw_leg<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T0>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2, arg4);
        settle_rebalance_withdraw_compatible<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun assert_rebalance_plan_bounds(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg1: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg1)) {
            let v1 = 0x1::vector::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg1, v0);
            assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::amount(v1) <= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::protocol_id(v1)), 20);
            v0 = v0 + 1;
        };
    }

    fun assert_rebalance_progress(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg1: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg2: u128, arg3: u128) {
        if (has_positive_non_idle_plan(arg0) || has_positive_non_idle_plan(arg1)) {
            assert!(arg2 > 0 || arg3 > 0, 25);
        };
    }

    public fun begin_rebalance<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : RebalanceReceipt<T0> {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::assert_version(arg0);
        assert!(!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::is_paused<T0, T1>(arg1), 1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_keeper<T0, T1>(arg1, 0x2::tx_context::sender(arg3));
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::begin_operation<T0, T1>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_rebalance_allowed<T0, T1>(arg1, v0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::refresh_idle_balance<T0, T1>(arg1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_all_protocols_fresh<T0, T1>(arg1, v0);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::accrue_fees<T0, T1>(arg1, v1, v0);
        let (v2, v3) = calculate_rebalance_plan<T0, T1>(arg1);
        RebalanceReceipt<T0>{
            pool_id                : 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1),
            expected_withdraw_plan : v2,
            expected_deposit_plan  : v3,
            rebalance_balance      : 0x2::balance::zero<T0>(),
            actual_withdraws       : 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(),
            source_debits          : 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(),
            actual_deposits        : 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(),
            total_withdrawn        : 0,
            total_deposited        : 0,
            snapshot_total_assets  : v1,
            snapshot_idle_balance  : 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE()),
            timestamp_ms           : v0,
        }
    }

    public fun begin_rebalance_deposit_leg<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) : (0x2::balance::Balance<T0>, RebalanceDepositTicket<T0>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2, arg4);
        assert!((arg3 as u128) <= remaining_rebalance_deposit_plan<T0>(arg0, arg2), 20);
        let v0 = 0x2::balance::value<T0>(&arg0.rebalance_balance);
        let v1 = if ((arg3 as u64) > v0) {
            v0
        } else {
            arg3
        };
        let v2 = RebalanceDepositTicket<T0>{
            protocol_id    : arg2,
            before_balance : v0,
        };
        (0x2::balance::split<T0>(&mut arg0.rebalance_balance, v1), v2)
    }

    public fun begin_rebalance_withdraw_leg<T0, T1, T2, T3>(arg0: &RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T3>) : (0x2::balance::Balance<T2>, RebalanceWithdrawTicket<T0>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2, arg4);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::query_holding_balance<T0, T1, T2>(arg1, arg2);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::extract_balance<T0, T1, T2>(arg1, arg2, arg3);
        let v2 = 0x2::balance::value<T2>(&v1);
        let v3 = if (v2 == 0 || v0 == 0) {
            0
        } else {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg1, arg2), (v2 as u128), (v0 as u128))
        };
        let v4 = RebalanceWithdrawTicket<T0>{
            protocol_id      : arg2,
            amount_extracted : v2,
            source_debit     : v3,
        };
        (v1, v4)
    }

    public fun borrow_cap_for_rebalance<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &RebalanceReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T4>) : &T3 {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2, arg4);
        0x2::dynamic_field::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::ProtocolCapKey<T2>, T3>(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::borrow_uid<T0, T1>(arg1), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::protocol_cap_key<T2>(arg2, arg3))
    }

    public fun borrow_cap_for_rebalance_mut<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T4>) : &mut T3 {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2, arg4);
        0x2::dynamic_field::borrow_mut<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::ProtocolCapKey<T2>, T3>(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::borrow_uid_mut<T0, T1>(arg1), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::protocol_cap_key<T2>(arg2, arg3))
    }

    fun build_target_deficit_deposit_plan<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128, arg2: u128, arg3: u128, arg4: bool) : (vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, u128) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_supply_queue<T0, T1>(arg0);
        let v1 = 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v0) && arg3 > 0) {
            let v4 = *0x1::vector::borrow<u8>(&v0, v3);
            if (!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_idle_protocol(v4) && 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::is_protocol_supply_enabled<T0, T1>(arg0, v4)) {
                let v5 = target_deficit_amount<T0, T1>(arg0, arg1, arg2, v4, arg4);
                if (v5 > 0) {
                    let v6 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_remaining_capacity<T0, T1>(arg0, v4);
                    let v7 = if (v5 < v6) {
                        v5
                    } else {
                        v6
                    };
                    let v8 = if (v7 < arg3) {
                        v7
                    } else {
                        arg3
                    };
                    if (v8 > 0 && v8 >= (0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_min_deposit<T0, T1>(arg0, v4) as u128)) {
                        0x1::vector::push_back<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(&mut v1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::create(v4, v8));
                        arg3 = arg3 - v8;
                        v2 = v2 + v7;
                    };
                };
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    fun build_target_excess_withdraw_plan<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128, arg2: u128, arg3: u128) : (vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, u128) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_withdraw_queue<T0, T1>(arg0);
        let v1 = 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v0) && arg3 > 0) {
            let v4 = *0x1::vector::borrow<u8>(&v0, v3);
            if (!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_idle_protocol(v4) && 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::is_protocol_withdraw_enabled<T0, T1>(arg0, v4)) {
                let v5 = target_excess_amount<T0, T1>(arg0, arg1, arg2, v4);
                let v6 = if (v5 < arg3) {
                    v5
                } else {
                    arg3
                };
                if (v6 > 0) {
                    0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut v1, v4, v6);
                    arg3 = arg3 - v6;
                    v2 = v2 + v5;
                };
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    fun build_target_rebalance_plan<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128) : (vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) {
        let (v0, v1) = build_target_excess_withdraw_plan<T0, T1>(arg0, arg1, arg2, total_withdrawable_target_excess<T0, T1>(arg0, arg1, arg2));
        let v2 = v1;
        let v3 = v0;
        let v4 = arg3 + v1;
        if (arg3 < arg5 && v4 < arg4) {
            let v5 = &mut v3;
            v2 = v1 + add_idle_recall_withdrawals<T0, T1>(arg0, v5, arg4 - v4);
        };
        let v6 = arg3 > arg4 && arg3 - arg4 > arg2;
        if (v2 == 0 && !v6) {
            return (0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(), 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>())
        };
        let v7 = if (arg4 > arg3) {
            arg4 - arg3
        } else {
            0
        };
        let v8 = if (v2 > v7) {
            v2 - v7
        } else {
            0
        };
        let v9 = if (arg3 > arg4 && (v6 || v2 > 0)) {
            arg3 - arg4
        } else {
            0
        };
        let (v10, v11) = build_target_deficit_deposit_plan<T0, T1>(arg0, arg1, arg2, v8 + v9, !v6);
        let v12 = v10;
        let v13 = if (v11 > v8) {
            v11 - v8
        } else {
            0
        };
        if (v13 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut v3, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE(), v13);
        };
        let v14 = v2 + v13;
        let v15 = if (v14 > v11) {
            v14 - v11
        } else {
            0
        };
        if (v15 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut v12, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE(), v15);
        };
        if (v14 == 0) {
            (0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(), 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>())
        } else {
            (v3, v12)
        }
    }

    public fun calculate_rebalance_plan<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>) : (vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg0);
        if (v0 == 0) {
            return (0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(), 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>())
        };
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_required_idle_balance<T0, T1>(arg0);
        let v2 = v0 * (0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_min_rebalance_deviation_bps<T0, T1>(arg0) as u128) / 10000;
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        build_target_rebalance_plan<T0, T1>(arg0, v0, v2, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE()), v1, v3)
    }

    public fun complete_rebalance<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: RebalanceReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let RebalanceReceipt {
            pool_id                : v0,
            expected_withdraw_plan : v1,
            expected_deposit_plan  : v2,
            rebalance_balance      : v3,
            actual_withdraws       : v4,
            source_debits          : _,
            actual_deposits        : v6,
            total_withdrawn        : v7,
            total_deposited        : v8,
            snapshot_total_assets  : v9,
            snapshot_idle_balance  : v10,
            timestamp_ms           : _,
        } = arg1;
        let v12 = v6;
        let v13 = v4;
        let v14 = v3;
        let v15 = v2;
        let v16 = v1;
        assert!(v0 == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg0), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_keeper<T0, T1>(arg0, 0x2::tx_context::sender(arg3));
        assert_rebalance_plan_bounds(&v16, &v13);
        assert_rebalance_plan_bounds(&v15, &v12);
        assert_rebalance_progress(&v16, &v15, v7, v8);
        let v17 = 0x2::balance::value<T0>(&v14);
        if (v17 > 0) {
            assert!(v17 <= 100, 19);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_deposit<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE(), (v17 as u128), 0);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_or_join_idle_balance<T0, T1>(arg0, v14);
        } else {
            0x2::balance::destroy_zero<T0>(v14);
        };
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::refresh_idle_balance<T0, T1>(arg0);
        let v18 = 0x2::clock::timestamp_ms(arg2);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::accrue_fees<T0, T1>(arg0, v9, v18);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::update_last_total_assets<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::total_shares<T0, T1>(arg0));
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::update_last_rebalance<T0, T1>(arg0, v18);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::end_operation<T0, T1>(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_rebalanced(v0, 0x2::tx_context::sender(arg3), v7, v8, v9, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg0), v10, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE()), v13, v12, v18);
    }

    fun credit_idle_deposit_plan_for_leftover<T0>(arg0: &mut RebalanceReceipt<T0>, arg1: u8, arg2: u64) {
        if (arg2 == 0 || 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_idle_protocol(arg1)) {
            return
        };
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.expected_deposit_plan, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE(), (arg2 as u128));
    }

    public fun expected_deposit_plan<T0>(arg0: &RebalanceReceipt<T0>) : &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount> {
        &arg0.expected_deposit_plan
    }

    public fun expected_withdraw_plan<T0>(arg0: &RebalanceReceipt<T0>) : &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount> {
        &arg0.expected_withdraw_plan
    }

    public fun extract_rebalance_holding<T0, T1, T2, T3>(arg0: &RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T3>) : 0x2::balance::Balance<T2> {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2, arg4);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::extract_balance<T0, T1, T2>(arg1, arg2, arg3)
    }

    public fun finish_rebalance_deposit_leg<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: RebalanceDepositTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        let RebalanceDepositTicket {
            protocol_id    : v0,
            before_balance : v1,
        } = arg2;
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0, arg4);
        let v2 = 0x2::balance::value<T0>(&arg3);
        let v3 = 0x2::balance::value<T0>(&arg0.rebalance_balance) + v2;
        0x2::balance::join<T0>(&mut arg0.rebalance_balance, arg3);
        assert!(v1 >= v3, 18);
        credit_idle_deposit_plan_for_leftover<T0>(arg0, v0, v2);
        let v4 = ((v1 - v3) as u128);
        if (v4 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_deposit<T0, T1>(arg1, v0, v4, arg0.timestamp_ms);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.actual_deposits, v0, v4);
            arg0.total_deposited = arg0.total_deposited + v4;
        };
    }

    public fun finish_rebalance_deposit_leg_accounted<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: RebalanceDepositTicket<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        let RebalanceDepositTicket {
            protocol_id    : v0,
            before_balance : v1,
        } = arg2;
        let v2 = 0x2::balance::value<T0>(&arg0.rebalance_balance);
        finish_rebalance_deposit_leg_accounted_impl<T0, T1, T2>(arg0, arg1, v0, v1, v2, arg3, arg4, arg5, arg6);
    }

    fun finish_rebalance_deposit_leg_accounted_impl<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2, arg8);
        assert!(arg3 >= arg4, 18);
        assert!(arg5 == ((arg3 - arg4) as u64), 18);
        assert!(arg6 <= arg5, 16);
        assert!(arg7 <= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::max_accounted_value_gap_for_protocol_input<T0, T1>(arg1, arg2, arg5), 17);
        assert!(arg5 - arg6 <= arg7, 17);
        if (arg6 > 0) {
            let v0 = (arg6 as u128);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_deposit<T0, T1>(arg1, arg2, v0, arg0.timestamp_ms);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.actual_deposits, arg2, v0);
            arg0.total_deposited = arg0.total_deposited + v0;
        };
    }

    public fun finish_rebalance_deposit_leg_accounted_with_leftover<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: RebalanceDepositTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        let RebalanceDepositTicket {
            protocol_id    : v0,
            before_balance : v1,
        } = arg2;
        let v2 = 0x2::balance::value<T0>(&arg3);
        let v3 = 0x2::balance::value<T0>(&arg0.rebalance_balance) + v2;
        0x2::balance::join<T0>(&mut arg0.rebalance_balance, arg3);
        credit_idle_deposit_plan_for_leftover<T0>(arg0, v0, v2);
        finish_rebalance_deposit_leg_accounted_impl<T0, T1, T2>(arg0, arg1, v0, v1, v3, arg4, arg5, arg6, arg7);
    }

    public fun finish_rebalance_withdraw_leg<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: RebalanceWithdrawTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        let RebalanceWithdrawTicket {
            protocol_id      : v0,
            amount_extracted : v1,
            source_debit     : v2,
        } = arg2;
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0, arg4);
        if (v1 > 0) {
            assert!(0x2::balance::value<T0>(&arg3) > 0, 14);
        };
        settle_rebalance_withdraw_strict<T0, T1>(arg0, arg1, v0, v2, arg3);
    }

    public fun finish_rebalance_withdraw_leg_accounted<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: RebalanceWithdrawTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!((arg4 as u128) == arg2.source_debit, 24);
        finish_rebalance_withdraw_leg<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6);
    }

    fun has_positive_non_idle_plan(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg0)) {
            let v1 = 0x1::vector::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg0, v0);
            if (!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_idle_protocol(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::protocol_id(v1)) && 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::amount(v1) > 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun protocol_target_amount<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128, arg2: u8) : u128 {
        arg1 * (0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_ratio<T0, T1>(arg0, arg2) as u128) / 10000
    }

    public fun rebalance_balance_value<T0>(arg0: &RebalanceReceipt<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rebalance_balance)
    }

    public fun rebalance_deposit_to_idle<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: &mut RebalanceReceipt<T0>) {
        assert!(arg1.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg0), 8);
        let v0 = 0x2::balance::value<T0>(&arg1.rebalance_balance);
        if (v0 == 0) {
            return
        };
        let v1 = (v0 as u128);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_or_join_idle_balance<T0, T1>(arg0, 0x2::balance::withdraw_all<T0>(&mut arg1.rebalance_balance));
        let v2 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE();
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_deposit<T0, T1>(arg0, v2, v1, 0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg1.actual_deposits, v2, v1);
        arg1.total_deposited = arg1.total_deposited + v1;
    }

    public fun rebalance_withdraw_from_idle<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: &mut RebalanceReceipt<T0>, arg2: u64) {
        assert!(arg1.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg0), 8);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE();
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&arg1.expected_withdraw_plan, v0);
        let v2 = if ((arg2 as u128) > v1) {
            (v1 as u64)
        } else {
            arg2
        };
        let v3 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::extract_idle_balance<T0, T1>(arg0, v2);
        let v4 = (0x2::balance::value<T0>(&v3) as u128);
        0x2::balance::join<T0>(&mut arg1.rebalance_balance, v3);
        if (v4 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_withdraw<T0, T1>(arg0, v0, v4, 0);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg1.actual_withdraws, v0, v4);
            arg1.total_withdrawn = arg1.total_withdrawn + v4;
        };
    }

    public fun receipt_pool_id<T0>(arg0: &RebalanceReceipt<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    fun remaining_rebalance_deposit_plan<T0>(arg0: &RebalanceReceipt<T0>, arg1: u8) : u128 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&arg0.expected_deposit_plan, arg1);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&arg0.actual_deposits, arg1);
        if (v1 >= v0) {
            0
        } else {
            v0 - v1
        }
    }

    fun remaining_rebalance_withdraw_plan<T0>(arg0: &RebalanceReceipt<T0>, arg1: u8) : u128 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&arg0.expected_withdraw_plan, arg1);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&arg0.actual_withdraws, arg1);
        if (v1 >= v0) {
            0
        } else {
            v0 - v1
        }
    }

    public fun resolve_requested_rebalance_deposit_amount<T0>(arg0: &RebalanceReceipt<T0>, arg1: u8, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = remaining_rebalance_deposit_plan<T0>(arg0, arg1);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x2::balance::value<T0>(&arg0.rebalance_balance);
        let v2 = if (arg2 > v1) {
            v1
        } else {
            arg2
        };
        if ((v2 as u128) > v0) {
            (v0 as u64)
        } else {
            v2
        }
    }

    public fun resolve_requested_rebalance_withdraw_amount<T0>(arg0: &RebalanceReceipt<T0>, arg1: u8, arg2: u128) : u128 {
        let v0 = remaining_rebalance_withdraw_plan<T0>(arg0, arg1);
        if (arg2 < v0) {
            arg2
        } else {
            v0
        }
    }

    fun route_rebalance_surplus_to_idle<T0, T1>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: u128) {
        if (arg3 > 0) {
            let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE();
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_or_join_idle_balance<T0, T1>(arg1, 0x2::balance::split<T0>(arg2, (arg3 as u64)));
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_deposit<T0, T1>(arg1, v0, arg3, 0);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.actual_deposits, v0, arg3);
            arg0.total_deposited = arg0.total_deposited + arg3;
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.expected_deposit_plan, v0, arg3);
        };
    }

    fun settle_rebalance_withdraw_compatible<T0, T1>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T0>) {
        let v0 = (0x2::balance::value<T0>(&arg3) as u128);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return
        };
        let v1 = min_u128(v0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg1, arg2));
        let v2 = min_u128(v1, remaining_rebalance_withdraw_plan<T0>(arg0, arg2));
        assert!(v2 > 0, 20);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_withdraw_preserve_report<T0, T1>(arg1, arg2, v1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.source_debits, arg2, v1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.actual_withdraws, arg2, v2);
        arg0.total_withdrawn = arg0.total_withdrawn + v0;
        let v3 = &mut arg3;
        route_rebalance_surplus_to_idle<T0, T1>(arg0, arg1, v3, v0 - v2);
        0x2::balance::join<T0>(&mut arg0.rebalance_balance, arg3);
    }

    fun settle_rebalance_withdraw_strict<T0, T1>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u128, arg4: 0x2::balance::Balance<T0>) {
        let v0 = (0x2::balance::value<T0>(&arg4) as u128);
        assert!(arg3 > 0 || v0 == 0, 24);
        assert!(v0 >= arg3, 24);
        let v1 = min_u128(arg3, remaining_rebalance_withdraw_plan<T0>(arg0, arg2));
        assert!(v1 > 0 || v0 == 0, 20);
        if (arg3 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_withdraw_preserve_report<T0, T1>(arg1, arg2, arg3);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.source_debits, arg2, arg3);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.actual_withdraws, arg2, v1);
        };
        arg0.total_withdrawn = arg0.total_withdrawn + v0;
        let v2 = &mut arg4;
        route_rebalance_surplus_to_idle<T0, T1>(arg0, arg1, v2, v0 - v1);
        0x2::balance::join<T0>(&mut arg0.rebalance_balance, arg4);
    }

    public fun store_rebalance_holding<T0, T1, T2, T3>(arg0: &RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T2>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T3>) {
        assert!(arg0.pool_id == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::id<T0, T1>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2, arg4);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_or_join_balance<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun sync_protocol_balance_for_rebalance<T0, T1, T2>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: &RebalanceReceipt<T0>, arg2: u8, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg1.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg0), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg0, arg2, arg5);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, arg2);
        assert!(arg3 <= v0, 21);
        assert!(v0 - arg3 <= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&arg1.actual_withdraws, arg2) + 100, 22);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_sync::sync_protocol_balance<T0, T1>(arg0, arg2, arg3, arg4);
    }

    fun target_deficit_amount<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128, arg2: u128, arg3: u8, arg4: bool) : u128 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, arg3);
        let v1 = protocol_target_amount<T0, T1>(arg0, arg1, arg3);
        if (v1 > v0) {
            let v2 = v1 - v0;
            if (!arg4 || v2 > arg2) {
                return v2
            };
        };
        0
    }

    fun target_excess_amount<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128, arg2: u128, arg3: u8) : u128 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, arg3);
        let v1 = protocol_target_amount<T0, T1>(arg0, arg1, arg3);
        if (v0 > v1) {
            let v2 = v0 - v1;
            if (v2 > arg2) {
                return v2
            };
        };
        0
    }

    public fun total_deposited<T0>(arg0: &RebalanceReceipt<T0>) : u128 {
        arg0.total_deposited
    }

    fun total_withdrawable_target_excess<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_withdraw_queue<T0, T1>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            if (!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_idle_protocol(v3) && 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::is_protocol_withdraw_enabled<T0, T1>(arg0, v3)) {
                v1 = v1 + target_excess_amount<T0, T1>(arg0, arg1, arg2, v3);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun total_withdrawn<T0>(arg0: &RebalanceReceipt<T0>) : u128 {
        arg0.total_withdrawn
    }

    public fun withdraw_ticket_source_debit<T0>(arg0: &RebalanceWithdrawTicket<T0>) : u128 {
        arg0.source_debit
    }

    // decompiled from Move bytecode v7
}

