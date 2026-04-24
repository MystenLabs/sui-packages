module 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_rebalance {
    struct RebalanceReceipt<phantom T0> {
        pool_id: 0x2::object::ID,
        expected_withdraw_plan: vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>,
        expected_deposit_plan: vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>,
        rebalance_balance: 0x2::balance::Balance<T0>,
        actual_withdraws: vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>,
        actual_deposits: vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>,
        total_withdrawn: u128,
        total_deposited: u128,
        snapshot_total_assets: u128,
        snapshot_idle_balance: u128,
        timestamp_ms: u64,
    }

    struct RebalanceWithdrawTicket<phantom T0> {
        protocol_id: u8,
        amount_extracted: u64,
    }

    struct RebalanceDepositTicket<phantom T0> {
        protocol_id: u8,
        before_balance: u64,
    }

    public fun add_rebalance_withdraw_leg<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T0>, arg4: &T2) {
        assert!(arg0.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1), 8);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2);
        let v0 = (0x2::balance::value<T0>(&arg3) as u128);
        0x2::balance::join<T0>(&mut arg0.rebalance_balance, arg3);
        if (v0 > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_withdraw<T0, T1>(arg1, arg2, v0, arg0.timestamp_ms);
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::accumulate(&mut arg0.actual_withdraws, arg2, v0);
            arg0.total_withdrawn = arg0.total_withdrawn + v0;
        };
    }

    fun assert_rebalance_plan_bounds(arg0: &vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>, arg1: &vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(arg1)) {
            let v1 = 0x1::vector::borrow<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(arg1, v0);
            assert!(0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::amount(v1) <= 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::get_amount(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::protocol_id(v1)), 20);
            v0 = v0 + 1;
        };
    }

    public fun begin_rebalance<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::LLVGlobal, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : RebalanceReceipt<T0> {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::assert_version(arg0);
        assert!(!0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::is_paused<T0, T1>(arg1), 1);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_keeper<T0, T1>(arg1, 0x2::tx_context::sender(arg3));
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::begin_operation<T0, T1>(arg1);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_begin<T0, T1>(arg1, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_rebalance_allowed<T0, T1>(arg1, v0);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::refresh_idle_balance<T0, T1>(arg1);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_all_protocols_fresh<T0, T1>(arg1, v0);
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_total_assets<T0, T1>(arg1);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::accrue_fees<T0, T1>(arg1, v1, v0);
        let (v2, v3) = calculate_rebalance_plan<T0, T1>(arg1);
        RebalanceReceipt<T0>{
            pool_id                : 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1),
            expected_withdraw_plan : v2,
            expected_deposit_plan  : v3,
            rebalance_balance      : 0x2::balance::zero<T0>(),
            actual_withdraws       : 0x1::vector::empty<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(),
            actual_deposits        : 0x1::vector::empty<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(),
            total_withdrawn        : 0,
            total_deposited        : 0,
            snapshot_total_assets  : v1,
            snapshot_idle_balance  : 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_protocol_balance<T0, T1>(arg1, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_IDLE()),
            timestamp_ms           : v0,
        }
    }

    public fun begin_rebalance_deposit_leg<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &T2) : (0x2::balance::Balance<T0>, RebalanceDepositTicket<T0>) {
        assert!(arg0.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1), 8);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2);
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

    public fun begin_rebalance_withdraw_leg<T0, T1, T2, T3>(arg0: &RebalanceReceipt<T0>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &T3) : (0x2::balance::Balance<T2>, RebalanceWithdrawTicket<T0>) {
        assert!(arg0.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1), 8);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2);
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::extract_balance<T0, T1, T2>(arg1, arg2, arg3);
        let v1 = RebalanceWithdrawTicket<T0>{
            protocol_id      : arg2,
            amount_extracted : 0x2::balance::value<T2>(&v0),
        };
        (v0, v1)
    }

    public fun borrow_cap_for_rebalance<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &RebalanceReceipt<T0>, arg1: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &T4) : &T3 {
        assert!(arg0.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1), 8);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2);
        0x2::dynamic_field::borrow<T2, T3>(0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::borrow_uid<T0, T1>(arg1), arg3)
    }

    public fun borrow_cap_for_rebalance_mut<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &RebalanceReceipt<T0>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &T4) : &mut T3 {
        assert!(arg0.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1), 8);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2);
        0x2::dynamic_field::borrow_mut<T2, T3>(0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::borrow_uid_mut<T0, T1>(arg1), arg3)
    }

    public fun calculate_rebalance_plan<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>) : (vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>, vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_total_assets<T0, T1>(arg0);
        if (v0 == 0) {
            return (0x1::vector::empty<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(), 0x1::vector::empty<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>())
        };
        let v1 = 0x1::vector::empty<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>();
        let v2 = 0x1::vector::empty<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>();
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_all_protocol_ids<T0, T1>(arg0);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u8>(&v5)) {
            let v7 = *0x1::vector::borrow<u8>(&v5, v6);
            let v8 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_protocol_balance<T0, T1>(arg0, v7);
            let v9 = v0 * (0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_protocol_ratio<T0, T1>(arg0, v7) as u128) / 10000;
            if (v8 > v9) {
                if (0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::is_protocol_withdraw_enabled<T0, T1>(arg0, v7)) {
                    let v10 = v8 - v9;
                    let v11 = if (v9 > 0) {
                        v10 * 10000 / v9
                    } else {
                        10000
                    };
                    if (v11 >= (0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_min_rebalance_deviation_bps<T0, T1>(arg0) as u128)) {
                        0x1::vector::push_back<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(&mut v1, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::create(v7, v10));
                        v3 = v3 + v10;
                    };
                };
            } else if (v9 > v8) {
                if (0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::is_protocol_supply_enabled<T0, T1>(arg0, v7)) {
                    let v12 = v9 - v8;
                    let v13 = if (v9 > 0) {
                        v12 * 10000 / v9
                    } else {
                        0
                    };
                    if (v13 >= (0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_min_rebalance_deviation_bps<T0, T1>(arg0) as u128)) {
                        let v14 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_protocol_remaining_capacity<T0, T1>(arg0, v7);
                        let v15 = if (v12 < v14) {
                            v12
                        } else {
                            v14
                        };
                        if (v15 > 0) {
                            0x1::vector::push_back<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(&mut v2, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::create(v7, v15));
                            v4 = v4 + v15;
                        };
                    };
                };
            };
            v6 = v6 + 1;
        };
        if (v3 > v4) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::accumulate(&mut v2, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_IDLE(), v3 - v4);
        } else if (v4 > v3) {
            let v16 = &v2;
            v2 = truncate_deposits_by_queue<T0, T1>(arg0, v16, v3);
        };
        (v1, v2)
    }

    public fun complete_rebalance<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: RebalanceReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let RebalanceReceipt {
            pool_id                : v0,
            expected_withdraw_plan : v1,
            expected_deposit_plan  : v2,
            rebalance_balance      : v3,
            actual_withdraws       : v4,
            actual_deposits        : v5,
            total_withdrawn        : v6,
            total_deposited        : v7,
            snapshot_total_assets  : v8,
            snapshot_idle_balance  : v9,
            timestamp_ms           : _,
        } = arg1;
        let v11 = v5;
        let v12 = v4;
        let v13 = v3;
        let v14 = v2;
        let v15 = v1;
        assert!(v0 == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg0), 8);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_keeper<T0, T1>(arg0, 0x2::tx_context::sender(arg3));
        assert_rebalance_plan_bounds(&v15, &v12);
        assert_rebalance_plan_bounds(&v14, &v11);
        let v16 = 0x2::balance::value<T0>(&v13);
        if (v16 > 0) {
            assert!(v16 <= 100, 19);
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_deposit<T0, T1>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_IDLE(), (v16 as u128), 0);
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::store_or_join_idle_balance<T0, T1>(arg0, v13);
        } else {
            0x2::balance::destroy_zero<T0>(v13);
        };
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::refresh_idle_balance<T0, T1>(arg0);
        let v17 = 0x2::clock::timestamp_ms(arg2);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::accrue_fees<T0, T1>(arg0, v8, v17);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::update_last_total_assets<T0, T1>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::total_shares<T0, T1>(arg0));
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::update_last_rebalance<T0, T1>(arg0, v17);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::end_operation<T0, T1>(arg0);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_events::emit_rebalanced(v0, 0x2::tx_context::sender(arg3), v6, v7, v8, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_total_assets<T0, T1>(arg0), v9, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_protocol_balance<T0, T1>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_IDLE()), v12, v11, v17);
    }

    public fun expected_deposit_plan<T0>(arg0: &RebalanceReceipt<T0>) : &vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount> {
        &arg0.expected_deposit_plan
    }

    public fun expected_withdraw_plan<T0>(arg0: &RebalanceReceipt<T0>) : &vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount> {
        &arg0.expected_withdraw_plan
    }

    public fun extract_rebalance_holding<T0, T1, T2, T3>(arg0: &RebalanceReceipt<T0>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &T3) : 0x2::balance::Balance<T2> {
        assert!(arg0.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1), 8);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::extract_balance<T0, T1, T2>(arg1, arg2, arg3)
    }

    public fun finish_rebalance_deposit_leg<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: RebalanceDepositTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &T2) {
        assert!(arg0.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1), 8);
        let RebalanceDepositTicket {
            protocol_id    : v0,
            before_balance : v1,
        } = arg2;
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0);
        let v2 = 0x2::balance::value<T0>(&arg0.rebalance_balance) + 0x2::balance::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.rebalance_balance, arg3);
        assert!(v1 >= v2, 18);
        let v3 = ((v1 - v2) as u128);
        if (v3 > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_deposit<T0, T1>(arg1, v0, v3, arg0.timestamp_ms);
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::accumulate(&mut arg0.actual_deposits, v0, v3);
            arg0.total_deposited = arg0.total_deposited + v3;
        };
    }

    public fun finish_rebalance_deposit_leg_accounted<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: RebalanceDepositTicket<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &T2) {
        assert!(arg0.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1), 8);
        let RebalanceDepositTicket {
            protocol_id    : v0,
            before_balance : v1,
        } = arg2;
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0);
        let v2 = 0x2::balance::value<T0>(&arg0.rebalance_balance);
        assert!(v1 >= v2, 18);
        assert!(arg3 == ((v1 - v2) as u64), 18);
        assert!(arg4 <= arg3, 16);
        assert!(arg5 <= 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::max_accounted_value_gap_for_input<T0, T1>(arg1, arg3), 17);
        assert!(arg3 - arg4 <= arg5, 17);
        if (arg4 > 0) {
            let v3 = (arg4 as u128);
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_deposit<T0, T1>(arg1, v0, v3, arg0.timestamp_ms);
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::accumulate(&mut arg0.actual_deposits, v0, v3);
            arg0.total_deposited = arg0.total_deposited + v3;
        };
    }

    public fun finish_rebalance_withdraw_leg<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: RebalanceWithdrawTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &T2) {
        assert!(arg0.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1), 8);
        let RebalanceWithdrawTicket {
            protocol_id      : v0,
            amount_extracted : v1,
        } = arg2;
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0);
        if (v1 > 0) {
            assert!(0x2::balance::value<T0>(&arg3) > 0, 14);
        };
        let v2 = (0x2::balance::value<T0>(&arg3) as u128);
        0x2::balance::join<T0>(&mut arg0.rebalance_balance, arg3);
        if (v2 > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_withdraw<T0, T1>(arg1, v0, v2, arg0.timestamp_ms);
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::accumulate(&mut arg0.actual_withdraws, v0, v2);
            arg0.total_withdrawn = arg0.total_withdrawn + v2;
        };
    }

    public fun rebalance_balance_value<T0>(arg0: &RebalanceReceipt<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rebalance_balance)
    }

    public fun rebalance_deposit_to_idle<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: &mut RebalanceReceipt<T0>) {
        assert!(arg1.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg0), 8);
        let v0 = 0x2::balance::value<T0>(&arg1.rebalance_balance);
        if (v0 == 0) {
            return
        };
        let v1 = (v0 as u128);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::store_or_join_idle_balance<T0, T1>(arg0, 0x2::balance::withdraw_all<T0>(&mut arg1.rebalance_balance));
        let v2 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_IDLE();
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_deposit<T0, T1>(arg0, v2, v1, 0);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::accumulate(&mut arg1.actual_deposits, v2, v1);
        arg1.total_deposited = arg1.total_deposited + v1;
    }

    public fun rebalance_withdraw_from_idle<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: &mut RebalanceReceipt<T0>, arg2: u64) {
        assert!(arg1.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg0), 8);
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_IDLE();
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::get_amount(&arg1.expected_withdraw_plan, v0);
        let v2 = if ((arg2 as u128) > v1) {
            (v1 as u64)
        } else {
            arg2
        };
        let v3 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::extract_idle_balance<T0, T1>(arg0, v2);
        let v4 = (0x2::balance::value<T0>(&v3) as u128);
        0x2::balance::join<T0>(&mut arg1.rebalance_balance, v3);
        if (v4 > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_withdraw<T0, T1>(arg0, v0, v4, 0);
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::accumulate(&mut arg1.actual_withdraws, v0, v4);
            arg1.total_withdrawn = arg1.total_withdrawn + v4;
        };
    }

    public fun receipt_pool_id<T0>(arg0: &RebalanceReceipt<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun store_rebalance_holding<T0, T1, T2, T3>(arg0: &RebalanceReceipt<T0>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T2>, arg4: &T3) {
        assert!(arg0.pool_id == 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::id<T0, T1>(arg1), 8);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::store_or_join_balance<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun sync_protocol_balance_for_rebalance<T0, T1, T2>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: &RebalanceReceipt<T0>, arg2: u8, arg3: u128, arg4: &0x2::clock::Clock, arg5: &T2) {
        assert!(arg1.pool_id == 0x2::object::id<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>>(arg0), 8);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg0, arg2);
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_protocol_balance<T0, T1>(arg0, arg2);
        assert!(arg3 <= v0, 21);
        assert!(v0 - arg3 <= 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::get_amount(&arg1.actual_withdraws, arg2) + 100, 22);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_sync::sync_protocol_balance<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun total_deposited<T0>(arg0: &RebalanceReceipt<T0>) : u128 {
        arg0.total_deposited
    }

    public fun total_withdrawn<T0>(arg0: &RebalanceReceipt<T0>) : u128 {
        arg0.total_withdrawn
    }

    fun truncate_deposits_by_queue<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg1: &vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>, arg2: u128) : vector<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount> {
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_supply_queue<T0, T1>(arg0);
        let v1 = 0x1::vector::empty<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0) && arg2 > 0) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            let v4 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::get_amount(arg1, v3);
            if (v4 > 0) {
                let v5 = if (v4 < arg2) {
                    v4
                } else {
                    arg2
                };
                0x1::vector::push_back<0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::ProtocolAmount>(&mut v1, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::create(v3, v5));
                arg2 = arg2 - v5;
            };
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v7
}

