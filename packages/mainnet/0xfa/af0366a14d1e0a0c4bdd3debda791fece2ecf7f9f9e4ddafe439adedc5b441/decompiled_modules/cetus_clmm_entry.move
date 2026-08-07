module 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_entry {
    struct CetusClmmLegAuth has drop {
        dummy_field: bool,
    }

    struct CetusClmmRefreshed has copy, drop {
        pool_id: 0x2::object::ID,
        lp_amount: u64,
        conservative_value: u128,
        timestamp_ms: u64,
        forced: bool,
    }

    struct CetusClmmWithdrawAccounted has copy, drop {
        pool_id: 0x2::object::ID,
        path: u8,
        accounted_value: u64,
        actual_received: u64,
        max_gap: u64,
        loss_bps: u64,
    }

    struct CetusClmmSupplySplitComputed has copy, drop {
        pool_id: 0x2::object::ID,
        input_is_base: bool,
        vault_amount_a: u64,
        vault_amount_b: u64,
        sqrt_price: u128,
        gross_input: u64,
        swap_amount: u64,
        post_swap_vault_amount_a: u64,
        post_swap_vault_amount_b: u64,
        fixed_pair_amount: u64,
        final_asset_leftover: u64,
    }

    struct CetusClmmRebalanceDepositAccounted has copy, drop {
        pool_id: 0x2::object::ID,
        gross_consumed: u64,
        physical_value: u64,
        conservative_value: u64,
        accounted_value: u64,
        realised_loss: u64,
        valuation_haircut: u64,
        accounted_gap: u64,
    }

    public fun admin_recall_base<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::AdminRecallReceipt<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = risk_params<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0, T1>(arg2);
        let v1 = authorize(arg0);
        let (v2, v3, v4, v5) = begin_recall_withdraw_base_from_cetus<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T0, T1>(arg1, arg2, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &v1);
        complete_recall_withdraw_from_cetus<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>(arg1, arg2, &v0, v3, v4, v5, v2, &v1);
    }

    public fun admin_recall_lst<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::AdminRecallReceipt<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = risk_params<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T0, T1>(arg2);
        let v1 = authorize(arg0);
        let (v2, v3, v4, v5) = begin_recall_withdraw_lst_from_cetus<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0, T1>(arg1, arg2, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &v1);
        complete_recall_withdraw_from_cetus<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>(arg1, arg2, &v0, v3, v4, v5, v2, &v1);
    }

    fun assert_admin_force_refresh_deviation<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM());
        if (v0 == 0 || arg1 <= v0) {
            return
        };
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(v0, (3000 as u128), 10000);
        let v2 = if (v1 == 0) {
            1
        } else {
            v1
        };
        assert!(arg1 - v0 <= v2, 206);
    }

    fun assert_refresh_timestamp_advanced<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u64) {
        let v0 = last_refresh_ms<T0, T1>(arg0);
        assert!(v0 == 0 || arg1 > v0, 221);
    }

    fun assert_report_fresh<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: &0x2::clock::Clock) {
        assert_report_fresh_values(last_refresh_ms<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg1), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_max_balance_age_ms<T0, T1>(arg0));
    }

    fun assert_report_fresh_values(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0 && arg1 >= arg0, 214);
        if (arg2 > 0) {
            assert!(arg1 - arg0 <= arg2, 214);
        };
    }

    public(friend) fun authorize(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal) : 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth> {
        let v0 = CetusClmmLegAuth{dummy_field: false};
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::authorize_ext<CetusClmmLegAuth>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), 1, &v0)
    }

    fun begin_rebalance_deposit_to_cetus<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) : (0x2::coin::Coin<T0>, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceDepositTicket<T0>, u64) {
        let (v0, v1) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::begin_rebalance_deposit_leg<T0, T1, CetusClmmLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::resolve_requested_rebalance_deposit_amount<T0>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), arg2), arg4);
        let v2 = v0;
        (0x2::coin::from_balance<T0>(v2, arg3), v1, 0x2::balance::value<T0>(&v2))
    }

    fun begin_rebalance_withdraw_base_from_cetus<T0, T1, T2, T3>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T3>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext, arg16: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) : (0x2::coin::Coin<T0>, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceWithdrawTicket<T0>, u64, u64) {
        assert_report_fresh<T0, T3>(arg1, arg14);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T3>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM());
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::resolve_requested_rebalance_withdraw_amount<T0>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), arg3);
        let v2 = if (v1 > v0) {
            v0
        } else {
            v1
        };
        let (v3, v4) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_plan(validated_lp_total<T0, T2, T3, T1, T0>(arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), v0, v2);
        let (v5, v6) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::begin_rebalance_withdraw_leg<T0, T3, T2, CetusClmmLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), v3, arg16);
        let (v7, v8, v9) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_base<T0, T1, T2>(v5, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg2, arg14, arg15);
        store_rebalance_lp<T0, T2, T3>(arg0, arg1, v7, arg16);
        (v8, v6, v4, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_accounting(v4, v9))
    }

    fun begin_rebalance_withdraw_lst_from_cetus<T0, T1, T2, T3>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T3>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext, arg16: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) : (0x2::coin::Coin<T0>, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceWithdrawTicket<T0>, u64, u64) {
        assert_report_fresh<T0, T3>(arg1, arg14);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T3>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM());
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::resolve_requested_rebalance_withdraw_amount<T0>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), arg3);
        let v2 = if (v1 > v0) {
            v0
        } else {
            v1
        };
        let (v3, v4) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_plan(validated_lp_total<T0, T2, T3, T0, T1>(arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), v0, v2);
        let (v5, v6) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::begin_rebalance_withdraw_leg<T0, T3, T2, CetusClmmLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), v3, arg16);
        let (v7, v8, v9) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_lst<T0, T1, T2>(v5, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg2, arg14, arg15);
        store_rebalance_lp<T0, T2, T3>(arg0, arg1, v7, arg16);
        (v8, v6, v4, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_accounting(v4, v9))
    }

    fun begin_recall_withdraw_base_from_cetus<T0, T1, T2, T3>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::AdminRecallReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T3>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext, arg16: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) : (0x2::coin::Coin<T0>, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::AdminRecallWithdrawTicket<T0>, u64, u64) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T3>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM());
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::receipt_requested_amount<T0>(arg0);
        let v2 = if (arg3 > v1) {
            v1
        } else {
            arg3
        };
        let v3 = if (v2 > v0) {
            v0
        } else {
            v2
        };
        let (v4, v5) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_plan(validated_lp_total<T0, T2, T3, T1, T0>(arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), v0, v3);
        let (v6, v7) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::begin_recall_withdraw_leg<T0, T3, T2, CetusClmmLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), v4, arg16);
        let (v8, v9, v10) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_base<T0, T1, T2>(v6, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg2, arg14, arg15);
        store_recall_lp<T0, T2, T3>(arg0, arg1, v8, arg16);
        (v9, v7, v5, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_accounting(v5, v10))
    }

    fun begin_recall_withdraw_lst_from_cetus<T0, T1, T2, T3>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::AdminRecallReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T3>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext, arg16: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) : (0x2::coin::Coin<T0>, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::AdminRecallWithdrawTicket<T0>, u64, u64) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T3>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM());
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::receipt_requested_amount<T0>(arg0);
        let v2 = if (arg3 > v1) {
            v1
        } else {
            arg3
        };
        let v3 = if (v2 > v0) {
            v0
        } else {
            v2
        };
        let (v4, v5) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_plan(validated_lp_total<T0, T2, T3, T0, T1>(arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), v0, v3);
        let (v6, v7) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::begin_recall_withdraw_leg<T0, T3, T2, CetusClmmLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), v4, arg16);
        let (v8, v9, v10) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_lst<T0, T1, T2>(v6, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg2, arg14, arg15);
        store_recall_lp<T0, T2, T3>(arg0, arg1, v8, arg16);
        (v9, v7, v5, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_accounting(v5, v10))
    }

    fun begin_withdraw_base_from_cetus<T0, T1, T2, T3>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::WithdrawReceipt<T0, T3>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T3>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext, arg16: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) : (0x2::coin::Coin<T0>, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::WithdrawLegTicket<T0>, u64, u64, u64, u64) {
        assert_report_fresh<T0, T3>(arg1, arg14);
        let (v0, v1) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_plan(validated_lp_total<T0, T2, T3, T1, T0>(arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T3>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM()), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::resolve_requested_withdraw_assets<T0, T3>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), arg3));
        let (v2, v3) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::begin_withdraw_leg<T0, T3, T2, CetusClmmLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), v0, arg16);
        let (v4, v5, v6) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_base<T0, T1, T2>(v2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg2, arg14, arg15);
        store_withdraw_lp<T0, T2, T3>(arg0, arg1, v4, arg16);
        let v7 = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_accounting(v1, v6);
        (v5, v3, v1, v7, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::user_min_output(arg2, v7), last_refresh_ms<T0, T3>(arg1))
    }

    fun begin_withdraw_lst_from_cetus<T0, T1, T2, T3>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::WithdrawReceipt<T0, T3>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T3>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext, arg16: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) : (0x2::coin::Coin<T0>, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::WithdrawLegTicket<T0>, u64, u64, u64, u64) {
        assert_report_fresh<T0, T3>(arg1, arg14);
        let (v0, v1) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_plan(validated_lp_total<T0, T2, T3, T0, T1>(arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T3>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM()), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::resolve_requested_withdraw_assets<T0, T3>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), arg3));
        let (v2, v3) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::begin_withdraw_leg<T0, T3, T2, CetusClmmLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), v0, arg16);
        let (v4, v5, v6) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_lst<T0, T1, T2>(v2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg2, arg14, arg15);
        store_withdraw_lp<T0, T2, T3>(arg0, arg1, v4, arg16);
        let v7 = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::exit_accounting(v1, v6);
        (v5, v3, v1, v7, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::user_min_output(arg2, v7), last_refresh_ms<T0, T3>(arg1))
    }

    public fun cetus_clmm_leg_auth_type() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<CetusClmmLegAuth>()))
    }

    fun complete_rebalance_deposit_base_to_cetus<T0, T1, T2, T3>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T3>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceDepositTicket<T0>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext, arg16: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::enter_base<T0, T1, T2>(arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg5, arg13, arg2, arg14, arg15);
        let v9 = v0;
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::assert_pool_spot<T1, T0>(arg13, arg12, arg2);
        let (v10, v11) = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::get_position_amounts<T1, T0, T2>(arg7, arg12, 0x2::balance::value<T2>(&v9));
        settle_rebalance_deposit<T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, v9, v1, v11, v10, true, v2, v3, v4, v5, v6, v7, v8, arg13, arg16);
    }

    fun complete_rebalance_deposit_lst_to_cetus<T0, T1, T2, T3>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T3>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceDepositTicket<T0>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext, arg16: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::enter_lst<T0, T1, T2>(arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg5, arg13, arg2, arg14, arg15);
        let v9 = v0;
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::assert_pool_spot<T0, T1>(arg13, arg12, arg2);
        let (v10, v11) = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::get_position_amounts<T0, T1, T2>(arg7, arg12, 0x2::balance::value<T2>(&v9));
        settle_rebalance_deposit<T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, v9, v1, v10, v11, false, v2, v3, v4, v5, v6, v7, v8, arg13, arg16);
    }

    fun complete_rebalance_withdraw_from_cetus<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceWithdrawTicket<T0>, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) {
        let v0 = 0x2::coin::value<T0>(&arg6);
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::assert_loss(arg2, arg5, v0);
        let v1 = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::gap(arg5, v0);
        assert!((arg4 as u128) == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::withdraw_ticket_source_debit<T0>(&arg3), 220);
        emit_withdraw_accounted<T0, T1>(arg1, 1, arg5, v0, v1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::finish_rebalance_withdraw_leg_accounted_with_loss<T0, T1, CetusClmmLegAuth>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(arg6), arg4, v1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_socialized_loss_limit_bps<T0, T1>(arg1), arg7);
    }

    fun complete_recall_withdraw_from_cetus<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::AdminRecallReceipt<T0>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::AdminRecallWithdrawTicket<T0>, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) {
        let v0 = 0x2::coin::value<T0>(&arg6);
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::assert_loss(arg2, arg5, v0);
        assert!((arg4 as u128) == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::withdraw_ticket_source_debit<T0>(&arg3), 220);
        emit_withdraw_accounted<T0, T1>(arg1, 2, arg5, v0, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::gap(arg5, v0));
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::finish_recall_withdraw_leg_with_loss<T0, T1, CetusClmmLegAuth>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(arg6), arg7);
    }

    fun complete_withdraw_from_cetus<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::WithdrawReceipt<T0, T1>, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::WithdrawLegTicket<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) {
        assert!((arg3 as u128) == 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::withdraw_ticket_source_debit<T0>(&arg2), 220);
        assert!(arg6 == last_refresh_ms<T0, T1>(arg1), 220);
        let v0 = 0x2::coin::value<T0>(&arg7);
        assert!(v0 >= arg5, 218);
        emit_withdraw_accounted<T0, T1>(arg1, 0, arg4, v0, 0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::finish_withdraw_leg<T0, T1, CetusClmmLegAuth>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg7), arg8);
    }

    fun emit_withdraw_accounted<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = CetusClmmWithdrawAccounted{
            pool_id         : 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg0),
            path            : arg1,
            accounted_value : arg2,
            actual_received : arg3,
            max_gap         : arg4,
            loss_bps        : 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::loss_bps(arg2, arg3),
        };
        0x2::event::emit<CetusClmmWithdrawAccounted>(v0);
    }

    public(friend) fun force_refresh_quote_value<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_admin_force_refresh_deviation<T0, T1>(arg1, arg3);
        let v0 = authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::force_sync_protocol_balance<T0, T1, CetusClmmLegAuth>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), arg3, arg4, arg5, &v0);
        let v1 = CetusClmmRefreshed{
            pool_id            : 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg1),
            lp_amount          : arg2,
            conservative_value : arg3,
            timestamp_ms       : last_refresh_ms<T0, T1>(arg1),
            forced             : true,
        };
        0x2::event::emit<CetusClmmRefreshed>(v1);
    }

    fun last_refresh_ms<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>) : u64 {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_last_sync_ms<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM())
    }

    public(friend) fun migration_witness() : CetusClmmLegAuth {
        CetusClmmLegAuth{dummy_field: false}
    }

    public(friend) fun observe_base_quote<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : (u64, u128) {
        observe_quote_value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0, T1>(arg0, arg1, arg2, arg3, true)
    }

    public(friend) fun observe_lst_quote<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : (u64, u128) {
        observe_quote_value<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T0, T1>(arg0, arg1, arg2, arg3, false)
    }

    fun observe_quote_value<T0, T1, T2>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg4: bool) : (u64, u128) {
        let v0 = risk_params<T0, T1, T2>(arg0);
        let v1 = validated_refresh_lp_total<T0, T1, T2, 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg0, arg1, arg2, arg3);
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::assert_pool_spot<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3, arg2, &v0);
        let (v2, v3) = if (v1 == 0) {
            (0, 0)
        } else {
            0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::get_position_amounts<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>(arg1, arg2, v1)
        };
        (v1, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::conservative_value(arg3, v2, v3, arg4, &v0))
    }

    public(friend) fun package_version() : u64 {
        1
    }

    public fun rebalance_deposit_base<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg11: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = risk_params<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0, T1>(arg2);
        let v1 = authorize(arg0);
        assert_report_fresh<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>(arg2, arg12);
        validate_full_objects<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0, T1, 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let (v2, v3, v4) = begin_rebalance_deposit_to_cetus<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>(arg1, arg2, arg3, arg13, &v1);
        complete_rebalance_deposit_base_to_cetus<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T0, T1>(arg1, arg2, &v0, v3, v4, v2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, &v1);
    }

    public fun rebalance_deposit_lst<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg11: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = risk_params<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T0, T1>(arg2);
        let v1 = authorize(arg0);
        assert_report_fresh<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>(arg2, arg12);
        validate_full_objects<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T0, T1, 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let (v2, v3, v4) = begin_rebalance_deposit_to_cetus<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>(arg1, arg2, arg3, arg13, &v1);
        complete_rebalance_deposit_lst_to_cetus<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0, T1>(arg1, arg2, &v0, v3, v4, v2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, &v1);
    }

    public fun rebalance_withdraw_base<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = risk_params<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0, T1>(arg2);
        let v1 = authorize(arg0);
        let (v2, v3, v4, v5) = begin_rebalance_withdraw_base_from_cetus<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T0, T1>(arg1, arg2, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &v1);
        complete_rebalance_withdraw_from_cetus<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>(arg1, arg2, &v0, v3, v4, v5, v2, &v1);
    }

    public fun rebalance_withdraw_lst<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = risk_params<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T0, T1>(arg2);
        let v1 = authorize(arg0);
        let (v2, v3, v4, v5) = begin_rebalance_withdraw_lst_from_cetus<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0, T1>(arg1, arg2, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &v1);
        complete_rebalance_withdraw_from_cetus<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>(arg1, arg2, &v0, v3, v4, v5, v2, &v1);
    }

    public fun refresh_base<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_keeper<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>(arg1, 0x2::tx_context::sender(arg6));
        let v0 = authorize(arg0);
        let (v1, v2) = observe_base_quote<T0, T1>(arg1, arg2, arg3, arg4);
        refresh_quote_value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>(arg1, v1, v2, arg5, &v0);
    }

    public fun refresh_lst<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_keeper<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>(arg1, 0x2::tx_context::sender(arg6));
        let v0 = authorize(arg0);
        let (v1, v2) = observe_lst_quote<T0, T1>(arg1, arg2, arg3, arg4);
        refresh_quote_value<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>(arg1, v1, v2, arg5, &v0);
    }

    fun refresh_quote_value<T0, T1>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) {
        assert_refresh_timestamp_advanced<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3));
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::sync_protocol_balance_by_auth<T0, T1, CetusClmmLegAuth>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), arg2, arg3, arg4);
        let v0 = CetusClmmRefreshed{
            pool_id            : 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>>(arg0),
            lp_amount          : arg1,
            conservative_value : arg2,
            timestamp_ms       : last_refresh_ms<T0, T1>(arg0),
            forced             : false,
        };
        0x2::event::emit<CetusClmmRefreshed>(v0);
    }

    fun risk_params<T0, T1, T2>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>) : 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_cetus_clmm_params_for_types<T0, T1, T2>(arg0)
    }

    fun settle_rebalance_deposit<T0, T1, T2>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>, arg2: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg3: 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceDepositTicket<T0>, arg4: u64, arg5: 0x2::balance::Balance<T1>, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: u128, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg18: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) {
        let v0 = 0x2::balance::value<T0>(&arg6);
        let v1 = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::consumed_input(arg4, v0);
        let v2 = if (arg9) {
            arg8
        } else {
            arg7
        };
        let v3 = if (arg9) {
            arg7
        } else {
            arg8
        };
        let v4 = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::assert_u64(0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::physical_value(arg17, v2, v3, arg9));
        let v5 = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::assert_u64(0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::conservative_value_from_physical((v4 as u128), arg2));
        let v6 = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::min_u64(v1, v5);
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position::assert_loss(arg2, v1, v4);
        let v7 = v1 - v6;
        let v8 = if (v1 > v4) {
            v1 - v4
        } else {
            0
        };
        store_rebalance_lp<T0, T1, T2>(arg0, arg1, arg5, arg18);
        let v9 = CetusClmmSupplySplitComputed{
            pool_id                  : 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>>(arg1),
            input_is_base            : arg9,
            vault_amount_a           : arg10,
            vault_amount_b           : arg11,
            sqrt_price               : arg12,
            gross_input              : arg4,
            swap_amount              : arg13,
            post_swap_vault_amount_a : arg14,
            post_swap_vault_amount_b : arg15,
            fixed_pair_amount        : arg16,
            final_asset_leftover     : v0,
        };
        0x2::event::emit<CetusClmmSupplySplitComputed>(v9);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::finish_rebalance_deposit_leg_accounted_with_leftover_and_loss<T0, T2, CetusClmmLegAuth>(arg0, arg1, arg3, arg6, v1, v4, v6, v7, arg18);
        let v10 = CetusClmmRebalanceDepositAccounted{
            pool_id            : 0x2::object::id<0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>>(arg1),
            gross_consumed     : v1,
            physical_value     : v4,
            conservative_value : v5,
            accounted_value    : v6,
            realised_loss      : v8,
            valuation_haircut  : v4 - v5,
            accounted_gap      : v7,
        };
        0x2::event::emit<CetusClmmRebalanceDepositAccounted>(v10);
    }

    fun store_rebalance_lp<T0, T1, T2>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>, arg2: 0x2::balance::Balance<T1>, arg3: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) {
        if (0x2::balance::value<T1>(&arg2) > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::store_rebalance_holding<T0, T2, T1, CetusClmmLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), arg2, arg3);
        } else {
            0x2::balance::destroy_zero<T1>(arg2);
        };
    }

    fun store_recall_lp<T0, T1, T2>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::AdminRecallReceipt<T0>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>, arg2: 0x2::balance::Balance<T1>, arg3: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) {
        if (0x2::balance::value<T1>(&arg2) > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::store_recall_holding<T0, T2, T1, CetusClmmLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), arg2, arg3);
        } else {
            0x2::balance::destroy_zero<T1>(arg2);
        };
    }

    fun store_withdraw_lp<T0, T1, T2>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::WithdrawReceipt<T0, T2>, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>, arg2: 0x2::balance::Balance<T1>, arg3: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusClmmLegAuth>) {
        if (0x2::balance::value<T1>(&arg2) > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::store_withdraw_holding<T0, T2, T1, CetusClmmLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM(), arg2, arg3);
        } else {
            0x2::balance::destroy_zero<T1>(arg2);
        };
    }

    fun validate_full_objects<T0, T1, T2, T3, T4>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T1>, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg4: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg8: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_validation::validate_cetus_clmm_config_for_asset<T0, T2>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg1), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T1>>(arg2), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg4), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg6), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>>(arg7), 0x2::object::id<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking>(arg8));
    }

    fun validated_lp_total<T0, T1, T2, T3, T4>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T1>, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg4: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg8: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : u64 {
        validate_full_objects<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::query_holding_balance<T0, T2, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM())
    }

    fun validated_refresh_lp_total<T0, T1, T2, T3, T4>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T2>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg3: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : u64 {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_validation::validate_cetus_clmm_core_for_asset<T0, T2>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T1>>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>>(arg2), 0x2::object::id<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking>(arg3));
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::query_holding_balance<T0, T2, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS_CLMM())
    }

    public fun withdraw_base<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::WithdrawReceipt<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = risk_params<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0, T1>(arg2);
        let v1 = authorize(arg0);
        let (v2, v3, v4, v5, v6, v7) = begin_withdraw_base_from_cetus<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T0, T1>(arg1, arg2, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &v1);
        complete_withdraw_from_cetus<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>(arg1, arg2, v3, v4, v5, v6, v7, v2, &v1);
    }

    public fun withdraw_lst<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::WithdrawReceipt<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>, arg3: u128, arg4: u64, arg5: u64, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg13: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = risk_params<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T0, T1>(arg2);
        let v1 = authorize(arg0);
        let (v2, v3, v4, v5, v6, v7) = begin_withdraw_lst_from_cetus<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0, T1>(arg1, arg2, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &v1);
        complete_withdraw_from_cetus<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>(arg1, arg2, v3, v4, v5, v6, v7, v2, &v1);
    }

    // decompiled from Move bytecode v7
}

