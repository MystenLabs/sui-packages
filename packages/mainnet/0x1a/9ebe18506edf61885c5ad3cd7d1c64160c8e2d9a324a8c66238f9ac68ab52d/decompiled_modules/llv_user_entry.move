module 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry {
    struct DepositReceipt<phantom T0> {
        pool_id: 0x2::object::ID,
        min_shares_out: u128,
        remaining: 0x2::balance::Balance<T0>,
        expected_allocation_plan: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        actual_deposits: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        side_deductions: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        used_protocols: vector<u8>,
        total_deposited: u128,
        total_accounted_gap: u128,
        snapshot_total_assets: u128,
        snapshot_total_shares: u128,
    }

    struct DepositLegTicket<phantom T0> {
        protocol_id: u8,
        before_remaining: u64,
    }

    struct WithdrawLegTicket<phantom T0> {
        protocol_id: u8,
        amount_extracted: u64,
        min_recalled_assets: u128,
        source_debit: u128,
    }

    struct WithdrawReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        shares_to_withdraw: u128,
        share_coin: 0x2::coin::Coin<T1>,
        expected_recall_plan: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        total_withdrawed: 0x2::balance::Balance<T0>,
        actual_withdraws: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        source_debits: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>,
        used_protocols: vector<u8>,
        snapshot_total_assets: u128,
        snapshot_total_shares: u128,
        settlement_assets: u128,
        max_loss_bps: u64,
    }

    public fun get_min_deposit<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>) : u64 {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_min_deposit<T0, T1>(arg0)
    }

    public fun get_protocol_balance<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u8) : u128 {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1)
    }

    public fun get_protocol_ratio<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u8) : u64 {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_ratio<T0, T1>(arg0, arg1)
    }

    public fun add_withdraw_leg<T0, T1, T2>(arg0: &mut WithdrawReceipt<T0, T1>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T0>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::is_protocol_registered<T0, T1>(arg1, arg2) || 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_idle_protocol(arg2), 15);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2, arg4);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&arg0.expected_recall_plan, arg2);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&arg0.source_debits, arg2);
        let v2 = if (v1 >= v0) {
            0
        } else {
            v0 - v1
        };
        let v3 = (0x2::balance::value<T0>(&arg3) as u128);
        assert!(v2 > 0 || v3 == 0, 26);
        0x2::balance::join<T0>(&mut arg0.total_withdrawed, arg3);
        if (v2 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.source_debits, arg2, v2);
        };
        if (v3 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.actual_withdraws, arg2, v3);
        };
    }

    public fun add_withdraw_leg_exact_payout<T0, T1, T2>(arg0: &mut WithdrawReceipt<T0, T1>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T0>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::is_protocol_registered<T0, T1>(arg1, arg2), 15);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2, arg4);
        let v0 = (0x2::balance::value<T0>(&arg3) as u128);
        let v1 = &mut arg0.used_protocols;
        claim_withdraw_protocol(v1, arg2, (v0 as u64));
        let v2 = min_u128(v0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg1, arg2));
        assert!(v2 > 0 || v0 == 0, 26);
        0x2::balance::join<T0>(&mut arg0.total_withdrawed, arg3);
        if (v2 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.source_debits, arg2, v2);
        };
        if (v0 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.actual_withdraws, arg2, v0);
        };
    }

    fun assert_deposit_plan_bounds(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg1: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg1)) {
            let v1 = 0x1::vector::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg1, v0);
            let v2 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::protocol_id(v1);
            if (!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_idle_protocol(v2)) {
                assert_protocol_within_plan(arg0, v2, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::amount(v1), 0);
            };
            v0 = v0 + 1;
        };
    }

    fun assert_protocol_within_plan(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg1: u8, arg2: u128, arg3: u128) {
        assert!(arg2 <= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(arg0, arg1) + arg3, 13);
    }

    fun assert_settlement_legs(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg1: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg0)) {
            let v1 = 0x1::vector::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg0, v0);
            assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::protocol_id(v1)) >= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::amount(v1), 10000 - (arg2 as u128), 10000), 4);
            v0 = v0 + 1;
        };
    }

    fun assert_user_nav_fresh<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: &0x2::clock::Clock) {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_all_protocols_fresh<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg1));
    }

    fun assert_withdraw_source_debits_cover_plan(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg1: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg0)) {
            let v1 = 0x1::vector::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg0, v0);
            assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::protocol_id(v1)) >= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::amount(v1), 13);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg1)) {
            let v2 = 0x1::vector::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg1, v0);
            assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::protocol_id(v2)) > 0 || 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::amount(v2) == 0, 13);
            v0 = v0 + 1;
        };
    }

    public fun begin_deposit<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : DepositReceipt<T0> {
        begin_session_prologue<T0, T1>(arg0, arg1, arg5);
        assert_user_nav_fresh<T0, T1>(arg1, arg4);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_real_shares_guard_for_deposit<T0, T1>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg1));
        new_idle_deposit_receipt<T0, T1>(arg1, arg2, arg3)
    }

    public fun begin_deposit_leg<T0, T1, T2>(arg0: &mut DepositReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) : (0x2::balance::Balance<T0>, DepositLegTicket<T0>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2, arg4);
        let v0 = 0x2::balance::value<T0>(&arg0.remaining);
        let v1 = if (arg3 >= v0) {
            0x2::balance::withdraw_all<T0>(&mut arg0.remaining)
        } else {
            0x2::balance::split<T0>(&mut arg0.remaining, arg3)
        };
        let v2 = DepositLegTicket<T0>{
            protocol_id      : arg2,
            before_remaining : v0,
        };
        (v1, v2)
    }

    fun begin_session_prologue<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::assert_version(arg0);
        assert!(!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::is_paused<T0, T1>(arg1), 1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::begin_operation<T0, T1>(arg1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::refresh_idle_balance<T0, T1>(arg1);
    }

    public fun begin_withdraw<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : WithdrawReceipt<T0, T1> {
        begin_withdraw_by_shares<T0, T1>(arg0, arg1, arg2, 0, arg3, arg4)
    }

    fun begin_withdraw_by_shares<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : WithdrawReceipt<T0, T1> {
        assert!(arg3 <= 100, 25);
        begin_session_prologue<T0, T1>(arg0, arg1, arg5);
        assert_user_nav_fresh<T0, T1>(arg1, arg4);
        let v0 = (0x2::coin::value<T1>(&arg2) as u128);
        assert!(v0 > 0, 2);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::accrue_fees<T0, T1>(arg1, v1, 0x2::clock::timestamp_ms(arg4));
        let v2 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::calculate_withdraw_by_shares<T0, T1>(arg1, v0);
        assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::assets_to_receive(&v2) > 0, 23);
        new_withdraw_receipt<T0, T1>(0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), v0, arg2, *0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::recall_plan(&v2), v1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::total_shares<T0, T1>(arg1), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::assets_to_receive(&v2), arg3)
    }

    fun begin_withdraw_from_idle<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : WithdrawReceipt<T0, T1> {
        begin_session_prologue<T0, T1>(arg0, arg1, arg4);
        assert_user_nav_fresh<T0, T1>(arg1, arg3);
        let v0 = (0x2::coin::value<T1>(&arg2) as u128);
        assert!(v0 > 0, 2);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::accrue_fees<T0, T1>(arg1, v1, 0x2::clock::timestamp_ms(arg3));
        let v2 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::total_shares<T0, T1>(arg1);
        let v3 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::calculate_assets_for_shares(v2, v1, v0);
        assert!(v3 > 0, 23);
        assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE()) >= v3, 22);
        new_withdraw_receipt<T0, T1>(0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), v0, arg2, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::idle_only(v3), v1, v2, v3, 0)
    }

    public fun begin_withdraw_idle_only<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : WithdrawReceipt<T0, T1> {
        begin_withdraw_from_idle<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun begin_withdraw_leg<T0, T1, T2, T3>(arg0: &mut WithdrawReceipt<T0, T1>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T3>) : (0x2::balance::Balance<T2>, WithdrawLegTicket<T0>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2, arg4);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::query_holding_balance<T0, T1, T2>(arg1, arg2);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg1, arg2);
        let v2 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::extract_balance<T0, T1, T2>(arg1, arg2, arg3);
        let v3 = 0x2::balance::value<T2>(&v2);
        let v4 = &mut arg0.used_protocols;
        claim_withdraw_protocol(v4, arg2, v3);
        let v5 = if (v3 == 0) {
            true
        } else if (v0 == 0) {
            true
        } else {
            v1 == 0
        };
        let v6 = if (v5) {
            0
        } else {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(v1, (v3 as u128), (v0 as u128))
        };
        let v7 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(v6, 5000, 10000);
        let v8 = if (v6 > 0 && v7 == 0) {
            1
        } else {
            v7
        };
        let v9 = WithdrawLegTicket<T0>{
            protocol_id         : arg2,
            amount_extracted    : v3,
            min_recalled_assets : v8,
            source_debit        : v6,
        };
        (v2, v9)
    }

    public fun begin_withdraw_with_loss<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : WithdrawReceipt<T0, T1> {
        begin_withdraw_by_shares<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun borrow_cap_by_auth<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: T2, arg3: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T4>) : &T3 {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg0, arg1, arg3);
        0x2::dynamic_field::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::ProtocolCapKey<T2>, T3>(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::borrow_uid<T0, T1>(arg0), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::protocol_cap_key<T2>(arg1, arg2))
    }

    public fun borrow_cap_for_deposit<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &DepositReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T4>) : &T3 {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2, arg4);
        0x2::dynamic_field::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::ProtocolCapKey<T2>, T3>(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::borrow_uid<T0, T1>(arg1), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::protocol_cap_key<T2>(arg2, arg3))
    }

    public fun borrow_cap_for_withdraw<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &WithdrawReceipt<T0, T1>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T4>) : &T3 {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2, arg4);
        0x2::dynamic_field::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::ProtocolCapKey<T2>, T3>(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::borrow_uid<T0, T1>(arg1), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::protocol_cap_key<T2>(arg2, arg3))
    }

    fun claim_withdraw_protocol(arg0: &mut vector<u8>, arg1: u8, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        assert!(!0x1::vector::contains<u8>(arg0, &arg1), 27);
        0x1::vector::push_back<u8>(arg0, arg1);
    }

    public fun complete_deposit<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: DepositReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = complete_deposit_return<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun complete_deposit_return<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: DepositReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let DepositReceipt {
            pool_id                  : v0,
            min_shares_out           : v1,
            remaining                : v2,
            expected_allocation_plan : v3,
            actual_deposits          : v4,
            side_deductions          : v5,
            used_protocols           : _,
            total_deposited          : v7,
            total_accounted_gap      : v8,
            snapshot_total_assets    : _,
            snapshot_total_shares    : _,
        } = arg1;
        let v11 = v7;
        let v12 = v5;
        let v13 = v4;
        let v14 = v3;
        let v15 = v2;
        assert!(v0 == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg0), 8);
        let v16 = 0x2::balance::value<T0>(&v15);
        if (v16 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_or_join_idle_balance<T0, T1>(arg0, 0x2::balance::withdraw_all<T0>(&mut v15));
            let v17 = (v16 as u128);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut v13, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE(), v17);
            v11 = v7 + v17;
        };
        assert_deposit_plan_bounds(&v14, &v13);
        assert!(v11 + v8 >= (0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_min_deposit<T0, T1>(arg0) as u128), 11);
        let v18 = pre_deposit_assets_excluding_side_values(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg0), &v12);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::accrue_fees<T0, T1>(arg0, v18, 0x2::clock::timestamp_ms(arg2));
        let v19 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::total_shares<T0, T1>(arg0);
        let v20 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::calculate_shares(v19, v18, (v11 as u64));
        assert!(v20 >= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_min_shares<T0, T1>(arg0), 11);
        assert!(v20 > 0, 11);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_deposit::verify_min_shares(v20, v1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_deposit_cap<T0, T1>(arg0, v18, (v11 as u64));
        let v21 = net_deposit_allocations(&v13, &v12);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_deposit::record_deposit_state<T0, T1>(arg0, &v21, 0x2::clock::timestamp_ms(arg2));
        assert!(v20 <= 18446744073709551615, 10);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::update_last_total_assets<T0, T1>(arg0, v19);
        0x2::balance::destroy_zero<T0>(v15);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::end_operation<T0, T1>(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_deposited(v0, 0x2::tx_context::sender(arg3), (v11 as u64), v20, v13, 0x2::clock::timestamp_ms(arg2));
        0x2::coin::mint<T1>(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::share_treasury_mut<T0, T1>(arg0), (v20 as u64), arg3)
    }

    public fun complete_withdraw<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: WithdrawReceipt<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = complete_withdraw_return<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
        if (0x2::coin::value<T1>(&v2) == 0) {
            0x2::coin::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg4));
        };
    }

    public fun complete_withdraw_return<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: WithdrawReceipt<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let WithdrawReceipt {
            pool_id               : v0,
            shares_to_withdraw    : v1,
            share_coin            : v2,
            expected_recall_plan  : v3,
            total_withdrawed      : v4,
            actual_withdraws      : v5,
            source_debits         : v6,
            used_protocols        : _,
            snapshot_total_assets : _,
            snapshot_total_shares : v9,
            settlement_assets     : v10,
            max_loss_bps          : v11,
        } = arg1;
        let v12 = v6;
        let v13 = v5;
        let v14 = v4;
        let v15 = v3;
        assert!(v0 == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg0), 8);
        let v16 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_IDLE();
        let v17 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&v15, v16);
        if (v17 > 0) {
            let v18 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::extract_idle_balance<T0, T1>(arg0, (v17 as u64));
            let v19 = (0x2::balance::value<T0>(&v18) as u128);
            0x2::balance::join<T0>(&mut v14, v18);
            if (v19 > 0) {
                0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut v13, v16, v19);
                0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut v12, v16, v19);
            };
        };
        assert_withdraw_source_debits_cover_plan(&v15, &v12);
        assert!(sum_plan_amounts(&v12) >= v10, 26);
        assert_settlement_legs(&v12, &v13, v11);
        let v20 = (0x2::balance::value<T0>(&v14) as u128);
        assert!(v20 >= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(v10, 10000 - (v11 as u128), 10000), 4);
        let v21 = min_u128(v20, v10);
        assert!(v21 >= (arg2 as u128), 4);
        assert!(v1 <= 18446744073709551615, 10);
        let v22 = v2;
        let v23 = if ((v1 as u64) >= 0x2::coin::value<T1>(&v22)) {
            0x2::coin::burn<T1>(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::share_treasury_mut<T0, T1>(arg0), v22);
            0x2::coin::zero<T1>(arg4)
        } else {
            0x2::coin::burn<T1>(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::share_treasury_mut<T0, T1>(arg0), 0x2::coin::split<T1>(&mut v22, (v1 as u64), arg4));
            v22
        };
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::record_withdraw_state<T0, T1>(arg0, &v12);
        let v24 = v20 - v21;
        let v14 = if (v24 == 0) {
            v14
        } else {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_or_join_idle_balance<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v14, (v24 as u64)));
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_deposit<T0, T1>(arg0, v16, v24, 0);
            v14
        };
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::update_last_total_assets<T0, T1>(arg0, v9);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::end_operation<T0, T1>(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_withdrawn(v0, 0x2::tx_context::sender(arg4), v1, (v21 as u64), v13, 0x2::clock::timestamp_ms(arg3));
        (0x2::coin::from_balance<T0>(v14, arg4), v23)
    }

    public fun deposit_receipt_pool_id<T0>(arg0: &DepositReceipt<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun deposit_receipt_remaining<T0>(arg0: &DepositReceipt<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.remaining)
    }

    public fun estimate_shares_value<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u64) : u128 {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::calculate_assets_for_shares(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::total_shares<T0, T1>(arg0), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg0), (arg1 as u128))
    }

    public fun finish_deposit_leg<T0, T1, T2>(arg0: &mut DepositReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: DepositLegTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        let DepositLegTicket {
            protocol_id      : v0,
            before_remaining : v1,
        } = arg2;
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0, arg4);
        let v2 = 0x2::balance::value<T0>(&arg0.remaining) + 0x2::balance::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.remaining, arg3);
        assert!(v1 >= v2, 4);
        let v3 = v1 - v2;
        if (v3 > 0) {
            let v4 = (v3 as u128);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.actual_deposits, v0, v4);
            arg0.total_deposited = arg0.total_deposited + v4;
        };
    }

    public fun finish_deposit_leg_accounted<T0, T1, T2>(arg0: &mut DepositReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: DepositLegTicket<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        let DepositLegTicket {
            protocol_id      : v0,
            before_remaining : v1,
        } = arg2;
        let v2 = 0x2::balance::value<T0>(&arg0.remaining);
        finish_deposit_leg_accounted_impl<T0, T1, T2>(arg0, arg1, v0, v1, v2, arg3, arg4, arg5, arg6);
    }

    fun finish_deposit_leg_accounted_impl<T0, T1, T2>(arg0: &mut DepositReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2, arg8);
        assert!(arg3 >= arg4, 18);
        assert!(arg5 == arg3 - arg4, 18);
        assert!(arg6 <= arg5, 16);
        let v0 = arg5 - arg6;
        assert!(arg7 <= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::max_accounted_value_gap_for_protocol_input<T0, T1>(arg1, arg2, arg5), 17);
        assert!(v0 <= arg7, 17);
        arg0.total_accounted_gap = arg0.total_accounted_gap + (v0 as u128);
        if (arg6 > 0) {
            let v1 = (arg6 as u128);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.actual_deposits, arg2, v1);
            arg0.total_deposited = arg0.total_deposited + v1;
        };
    }

    public fun finish_deposit_leg_accounted_with_leftover<T0, T1, T2>(arg0: &mut DepositReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: DepositLegTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        let DepositLegTicket {
            protocol_id      : v0,
            before_remaining : v1,
        } = arg2;
        let v2 = 0x2::balance::value<T0>(&arg0.remaining) + 0x2::balance::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.remaining, arg3);
        finish_deposit_leg_accounted_impl<T0, T1, T2>(arg0, arg1, v0, v1, v2, arg4, arg5, arg6, arg7);
    }

    public fun finish_withdraw_leg<T0, T1, T2>(arg0: &mut WithdrawReceipt<T0, T1>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: WithdrawLegTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        let WithdrawLegTicket {
            protocol_id         : v0,
            amount_extracted    : v1,
            min_recalled_assets : v2,
            source_debit        : v3,
        } = arg2;
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0, arg4);
        if (v1 > 0) {
            assert!(0x2::balance::value<T0>(&arg3) > 0, 14);
        };
        let v4 = (0x2::balance::value<T0>(&arg3) as u128);
        assert!(v3 > 0 || v4 == 0, 26);
        if (v1 > 0 && v2 > 0) {
            assert!(v4 >= v2, 20);
        };
        0x2::balance::join<T0>(&mut arg0.total_withdrawed, arg3);
        if (v3 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.source_debits, v0, v3);
        };
        if (v4 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.actual_withdraws, v0, v4);
        };
    }

    public fun force_sync_protocol_balance<T0, T1, T2>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext, arg5: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_pool_admin<T0, T1>(arg0, v0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_no_operation_in_progress<T0, T1>(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg0, arg1, arg5);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_sync::sync_protocol_balance<T0, T1>(arg0, arg1, arg2, arg3);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_force_balance_synced(0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg0), arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1), arg2, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg0), v0, 0x2::clock::timestamp_ms(arg3));
    }

    public fun get_exchange_rate<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>) : u128 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::total_shares<T0, T1>(arg0);
        if (v0 == 0) {
            return 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::scale()
        };
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::scale(), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg0) + 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::virtual_offset(), v0 + 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::virtual_offset())
    }

    public fun is_pool_paused<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>) : bool {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::is_paused<T0, T1>(arg0)
    }

    fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun net_deposit_allocations(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg1: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) : vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount> {
        let v0 = 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg0)) {
            let v2 = 0x1::vector::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg0, v1);
            let v3 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::protocol_id(v2);
            let v4 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::amount(v2);
            let v5 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(arg1, v3);
            assert!(v5 <= v4, 28);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut v0, v3, v4 - v5);
            v1 = v1 + 1;
        };
        v0
    }

    fun new_idle_deposit_receipt<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u128) : DepositReceipt<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        DepositReceipt<T0>{
            pool_id                  : 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg0),
            min_shares_out           : arg2,
            remaining                : 0x2::coin::into_balance<T0>(arg1),
            expected_allocation_plan : 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::idle_only((v0 as u128)),
            actual_deposits          : 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(),
            side_deductions          : 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(),
            used_protocols           : b"",
            total_deposited          : 0,
            total_accounted_gap      : 0,
            snapshot_total_assets    : 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg0),
            snapshot_total_shares    : 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::total_shares<T0, T1>(arg0),
        }
    }

    fun new_withdraw_receipt<T0, T1>(arg0: 0x2::object::ID, arg1: u128, arg2: 0x2::coin::Coin<T1>, arg3: vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg4: u128, arg5: u128, arg6: u128, arg7: u64) : WithdrawReceipt<T0, T1> {
        WithdrawReceipt<T0, T1>{
            pool_id               : arg0,
            shares_to_withdraw    : arg1,
            share_coin            : arg2,
            expected_recall_plan  : arg3,
            total_withdrawed      : 0x2::balance::zero<T0>(),
            actual_withdraws      : 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(),
            source_debits         : 0x1::vector::empty<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(),
            used_protocols        : b"",
            snapshot_total_assets : arg4,
            snapshot_total_shares : arg5,
            settlement_assets     : arg6,
            max_loss_bps          : arg7,
        }
    }

    public fun pool_total_assets<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>) : u128 {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg0)
    }

    public fun pool_total_shares<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>) : u128 {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::total_shares<T0, T1>(arg0)
    }

    fun pre_deposit_assets_excluding_side_values(arg0: u128, arg1: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) : u128 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::total_amount(arg1);
        assert!(v0 <= arg0, 28);
        arg0 - v0
    }

    public fun preview_deposit<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u64) : (u128, vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_deposit::calculate_deposit<T0, T1>(arg0, arg1);
        (0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_deposit::shares_to_mint(&v0), *0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_deposit::allocation(&v0))
    }

    public fun preview_withdraw_by_assets<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u64) : (u128, vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::calculate_withdraw_by_assets<T0, T1>(arg0, arg1, 0);
        (0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::shares_to_burn(&v0), *0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::recall_plan(&v0))
    }

    public fun preview_withdraw_by_assets_safe<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u64) : (u128, u128, u128, vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) {
        assert!(arg1 > 0, 2);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::total_shares<T0, T1>(arg0);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg0);
        let v2 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::calculate_shares_for_assets(v0, v1, arg1);
        let (v3, v4) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::calculate_recall_plan_best_effort<T0, T1>(arg0, (arg1 as u128));
        let v5 = if (v4 == (arg1 as u128)) {
            v2
        } else {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::calculate_max_shares_for_assets_u128(v0, v1, v4)
        };
        (v2, v5, v4, v3)
    }

    public fun preview_withdraw_by_shares<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128) : (u128, vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::calculate_withdraw_by_shares<T0, T1>(arg0, arg1);
        (0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::assets_to_receive(&v0), *0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::recall_plan(&v0))
    }

    public fun preview_withdraw_by_shares_safe<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128) : (u128, u128, vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) {
        assert!(arg1 > 0, 2);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_total_assets<T0, T1>(arg0);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::calculate_assets_for_shares(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::total_shares<T0, T1>(arg0), v0, arg1);
        let v2 = v1;
        if (v1 > v0) {
            v2 = v0;
        };
        let (v3, v4) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_withdraw::calculate_recall_plan_best_effort<T0, T1>(arg0, v2);
        (v2, v4, v3)
    }

    public fun record_deposit_leg_side_deduction<T0, T1, T2>(arg0: &mut DepositReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u128, arg4: u128, arg5: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2, arg5);
        assert!(arg3 <= arg4, 28);
        assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&arg0.side_deductions, arg2) + arg3 <= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(&arg0.actual_deposits, arg2), 28);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::accumulate(&mut arg0.side_deductions, arg2, arg3);
    }

    public fun resolve_requested_deposit_amount<T0>(arg0: &DepositReceipt<T0>, arg1: u8, arg2: u64) : u64 {
        resolve_requested_deposit_amount_from_plan(&arg0.expected_allocation_plan, arg1, arg2)
    }

    fun resolve_requested_deposit_amount_from_plan(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg1: u8, arg2: u64) : u64 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(arg0, arg1);
        assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_known_protocol(arg1) || v0 > 0, 15);
        let v1 = if (arg2 == 0) {
            v0
        } else {
            let v2 = (arg2 as u128);
            if (v2 < v0) {
                v2
            } else {
                v0
            }
        };
        (v1 as u64)
    }

    public fun resolve_requested_withdraw_assets<T0, T1>(arg0: &WithdrawReceipt<T0, T1>, arg1: u8, arg2: u128) : u128 {
        resolve_requested_withdraw_assets_from_plan(&arg0.expected_recall_plan, arg1, arg2)
    }

    fun resolve_requested_withdraw_assets_from_plan(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>, arg1: u8, arg2: u128) : u128 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::get_amount(arg0, arg1);
        assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_known_protocol(arg1) || v0 > 0, 15);
        if (arg2 == 0) {
            v0
        } else if (arg2 < v0) {
            arg2
        } else {
            v0
        }
    }

    public fun store_deposit_holding<T0, T1, T2, T3>(arg0: &DepositReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T2>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T3>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2, arg4);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_or_join_balance<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun store_withdraw_holding<T0, T1, T2, T3>(arg0: &WithdrawReceipt<T0, T1>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T2>, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T3>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2, arg4);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_or_join_balance<T0, T1, T2>(arg1, arg2, arg3);
    }

    fun sum_plan_amounts(arg0: &vector<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg0)) {
            v0 = v0 + 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::amount(0x1::vector::borrow<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::ProtocolAmount>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun sync_for_deposit<T0, T1, T2>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: &mut DepositReceipt<T0>, arg2: u8, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
    }

    public fun sync_for_withdraw<T0, T1, T2>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: &mut WithdrawReceipt<T0, T1>, arg2: u8, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
    }

    public fun sync_protocol_balance_by_auth<T0, T1, T2>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<T2>) {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_no_operation_in_progress<T0, T1>(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg0, arg1, arg4);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_sync::sync_protocol_balance_guarded<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun withdraw_receipt_max_loss_bps<T0, T1>(arg0: &WithdrawReceipt<T0, T1>) : u64 {
        arg0.max_loss_bps
    }

    public fun withdraw_receipt_pool_id<T0, T1>(arg0: &WithdrawReceipt<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun withdraw_receipt_shares<T0, T1>(arg0: &WithdrawReceipt<T0, T1>) : u128 {
        arg0.shares_to_withdraw
    }

    public fun withdraw_ticket_source_debit<T0>(arg0: &WithdrawLegTicket<T0>) : u128 {
        arg0.source_debit
    }

    // decompiled from Move bytecode v7
}

