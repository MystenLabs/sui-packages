module 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_entry {
    struct ScallopLegAuth has drop {
        dummy_field: bool,
    }

    public fun admin_recall_scallop_to_idle<T0, T1>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin_recall::AdminRecallReceipt<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_scallop_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg2));
        0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::trigger_accrue(arg2, arg3, arg4);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP();
        let (v1, v2) = 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::get_exchange_rate<T0>(arg3);
        let v3 = 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::select_scoin_withdraw_amount(0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin_recall::receipt_requested_amount<T0>(arg1), 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, v0), v1, v2, 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::get_available_liquidity<T0>(arg3));
        if (v3 == 0) {
            return
        };
        let v4 = ScallopLegAuth{dummy_field: false};
        let (v5, v6) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin_recall::begin_recall_withdraw_leg<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopLegAuth>(arg1, arg0, v0, v3, &v4);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin_recall::finish_recall_withdraw_leg<T0, T1, ScallopLegAuth>(arg1, arg0, v6, withdraw_underlying<T0>(v5, arg2, arg3, arg4, arg5), &v4);
    }

    public fun deposit_to_scallop<T0, T1>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::DepositReceipt<T0>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_scallop_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg3));
        0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::trigger_accrue(arg3, arg4, arg5);
        let v0 = ScallopLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::sync_for_deposit<T0, T1, ScallopLegAuth>(arg0, arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::get_underlying_balance<T0>(arg4, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP())), arg5, &v0);
        let (v1, v2) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::begin_deposit_leg<T0, T1, ScallopLegAuth>(arg1, arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::resolve_requested_deposit_amount<T0>(arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP(), arg2), &v0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::store_deposit_holding<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopLegAuth>(arg1, arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP(), deposit_underlying<T0>(v1, arg3, arg4, arg5, arg6), &v0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::finish_deposit_leg<T0, T1, ScallopLegAuth>(arg1, arg0, v2, 0x2::balance::zero<T0>(), &v0);
    }

    public(friend) fun deposit_underlying<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::deposit<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(arg0, arg4), arg3, arg4))
    }

    public fun rebalance_deposit_to_scallop<T0, T1>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::RebalanceReceipt<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_scallop_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg2));
        0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::trigger_accrue(arg2, arg3, arg4);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP();
        let v1 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::get_amount(0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::expected_deposit_plan<T0>(arg1), v0);
        if (v1 == 0) {
            return
        };
        let v2 = (0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::rebalance_balance_value<T0>(arg1) as u128);
        let v3 = if (v1 < v2) {
            (v1 as u64)
        } else {
            (v2 as u64)
        };
        if (v3 == 0) {
            return
        };
        let v4 = ScallopLegAuth{dummy_field: false};
        let (v5, v6) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::begin_rebalance_deposit_leg<T0, T1, ScallopLegAuth>(arg1, arg0, v0, v3, &v4);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::store_rebalance_holding<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopLegAuth>(arg1, arg0, v0, deposit_underlying<T0>(v5, arg2, arg3, arg4, arg5), &v4);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::finish_rebalance_deposit_leg<T0, T1, ScallopLegAuth>(arg1, arg0, v6, 0x2::balance::zero<T0>(), &v4);
    }

    public fun rebalance_withdraw_from_scallop<T0, T1>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::RebalanceReceipt<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_scallop_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg2));
        0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::trigger_accrue(arg2, arg3, arg4);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP();
        let (v1, v2) = 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::get_exchange_rate<T0>(arg3);
        let v3 = 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::select_scoin_withdraw_amount(0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::get_amount(0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::expected_withdraw_plan<T0>(arg1), v0), 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP()), v1, v2, 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::get_available_liquidity<T0>(arg3));
        if (v3 == 0) {
            return
        };
        let v4 = ScallopLegAuth{dummy_field: false};
        let (v5, v6) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::begin_rebalance_withdraw_leg<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopLegAuth>(arg1, arg0, v0, v3, &v4);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::finish_rebalance_withdraw_leg<T0, T1, ScallopLegAuth>(arg1, arg0, v6, withdraw_underlying<T0>(v5, arg2, arg3, arg4, arg5), &v4);
    }

    public fun refresh_scallop<T0, T1>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_scallop_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg2), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg1));
        0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::trigger_accrue(arg1, arg2, arg3);
        let v0 = ScallopLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::sync_protocol_balance_by_auth<T0, T1, ScallopLegAuth>(arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::get_underlying_balance<T0>(arg2, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP())), arg3, &v0);
    }

    public fun register_scallop_leg_auth<T0, T1>(arg0: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVGlobal, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg2: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVPoolAdminCap) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::assert_version(arg0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::register_protocol_leg_auth<T0, T1, ScallopLegAuth>(arg1, arg2, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP());
    }

    public fun withdraw_from_scallop<T0, T1>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::WithdrawReceipt<T0, T1>, arg2: u128, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_scallop_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg3));
        0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::trigger_accrue(arg3, arg4, arg5);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP());
        let v1 = ScallopLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::sync_for_withdraw<T0, T1, ScallopLegAuth>(arg0, arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::get_underlying_balance<T0>(arg4, v0), arg5, &v1);
        let (v2, v3) = 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::get_exchange_rate<T0>(arg4);
        let v4 = 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::select_scoin_withdraw_amount(0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::resolve_requested_withdraw_assets<T0, T1>(arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP(), arg2), v0, v2, v3, 0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::get_available_liquidity<T0>(arg4));
        if (v4 == 0) {
            return
        };
        let (v5, v6) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::begin_withdraw_leg<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopLegAuth>(arg1, arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SCALLOP(), v4, &v1);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::finish_withdraw_leg<T0, T1, ScallopLegAuth>(arg1, arg0, v6, withdraw_underlying<T0>(v5, arg3, arg4, arg5, arg6), &v1);
    }

    public(friend) fun withdraw_underlying<T0>(arg0: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0x879271e2278f5925d42186ab50a2617f8c31ed374c2bb72c6e5daab2218de824::scallop_adapter::withdraw<T0>(arg1, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, arg4), arg3, arg4))
    }

    // decompiled from Move bytecode v6
}

