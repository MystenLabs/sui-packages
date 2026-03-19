module 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_entry {
    struct SuilendLegAuth has drop {
        dummy_field: bool,
    }

    public fun admin_recall_suilend_to_idle<T0, T1, T2>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin_recall::AdminRecallReceipt<T1>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_suilend_config<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND();
        0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg5);
        let (v1, v2) = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_ctoken_ratio<T0, T1>(arg3);
        let v3 = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_immediate_available_liquidity<T0, T1>(arg3);
        let v4 = if (arg2 > v3) {
            v3
        } else {
            arg2
        };
        let v5 = SuilendLegAuth{dummy_field: false};
        let (v6, v7) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin_recall::begin_recall_withdraw_leg<T1, T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>, SuilendLegAuth>(arg1, arg0, v0, 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::select_ctoken_withdraw_amount((v4 as u128), 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<T1, T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg0, v0), v1, v2, v3), &v5);
        let v8 = SuilendLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin_recall::finish_recall_withdraw_leg<T1, T2, SuilendLegAuth>(arg1, arg0, v7, withdraw_underlying<T0, T1>(v6, arg3, arg4, arg5, arg6), &v8);
    }

    public fun admin_recall_suilend_to_idle_sui<T0, T1>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin_recall::AdminRecallReceipt<0x2::sui::SUI>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_suilend_config<0x2::sui::SUI, T1>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND();
        0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg6);
        let (v1, v2) = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_ctoken_ratio<T0, 0x2::sui::SUI>(arg3);
        let v3 = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_accounting_available_liquidity<T0, 0x2::sui::SUI>(arg3);
        let v4 = if (arg2 > (v3 as u64)) {
            (v3 as u64)
        } else {
            arg2
        };
        let v5 = SuilendLegAuth{dummy_field: false};
        let (v6, v7) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin_recall::begin_recall_withdraw_leg<0x2::sui::SUI, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>, SuilendLegAuth>(arg1, arg0, v0, 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::select_ctoken_withdraw_amount((v4 as u128), 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<0x2::sui::SUI, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(arg0, v0), v1, v2, v3), &v5);
        let v8 = SuilendLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin_recall::finish_recall_withdraw_leg<0x2::sui::SUI, T1, SuilendLegAuth>(arg1, arg0, v7, withdraw_underlying_sui<T0>(v6, arg3, arg4, arg5, arg6, arg7), &v8);
    }

    public fun deposit_to_suilend<T0, T1, T2>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::DepositReceipt<T1>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_suilend_config<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg5);
        let v0 = SuilendLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::sync_for_deposit<T1, T2, SuilendLegAuth>(arg0, arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_underlying_balance<T0, T1>(arg3, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<T1, T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND())), arg5, &v0);
        let (v1, v2) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::begin_deposit_leg<T1, T2, SuilendLegAuth>(arg1, arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::resolve_requested_deposit_amount<T1>(arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), arg2), &v0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::store_deposit_holding<T1, T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>, SuilendLegAuth>(arg1, arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), deposit_underlying<T0, T1>(v1, arg3, arg4, arg5, arg6), &v0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::finish_deposit_leg<T1, T2, SuilendLegAuth>(arg1, arg0, v2, 0x2::balance::zero<T1>(), &v0);
    }

    public(friend) fun deposit_underlying<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::deposit<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T1>(arg0, arg4), arg4))
    }

    public fun rebalance_deposit_to_suilend<T0, T1, T2>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::RebalanceReceipt<T1>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_suilend_config<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND();
        0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg5);
        let v1 = SuilendLegAuth{dummy_field: false};
        let (v2, v3) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::begin_rebalance_deposit_leg<T1, T2, SuilendLegAuth>(arg1, arg0, v0, arg2, &v1);
        let v4 = SuilendLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::store_rebalance_holding<T1, T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>, SuilendLegAuth>(arg1, arg0, v0, deposit_underlying<T0, T1>(v2, arg3, arg4, arg5, arg6), &v4);
        let v5 = SuilendLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::finish_rebalance_deposit_leg<T1, T2, SuilendLegAuth>(arg1, arg0, v3, 0x2::balance::zero<T1>(), &v5);
    }

    public fun rebalance_withdraw_from_suilend<T0, T1, T2>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::RebalanceReceipt<T1>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_suilend_config<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND();
        0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg5);
        let (v1, v2) = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_ctoken_ratio<T0, T1>(arg3);
        let v3 = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_immediate_available_liquidity<T0, T1>(arg3);
        let v4 = if (arg2 > v3) {
            v3
        } else {
            arg2
        };
        let v5 = SuilendLegAuth{dummy_field: false};
        let (v6, v7) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::begin_rebalance_withdraw_leg<T1, T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>, SuilendLegAuth>(arg1, arg0, v0, 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::select_ctoken_withdraw_amount((v4 as u128), 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<T1, T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg0, v0), v1, v2, v3), &v5);
        let v8 = SuilendLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::finish_rebalance_withdraw_leg<T1, T2, SuilendLegAuth>(arg1, arg0, v7, withdraw_underlying<T0, T1>(v6, arg3, arg4, arg5, arg6), &v8);
    }

    public fun rebalance_withdraw_from_suilend_sui<T0, T1>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::RebalanceReceipt<0x2::sui::SUI>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_suilend_config<0x2::sui::SUI, T1>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND();
        0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg6);
        let (v1, v2) = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_ctoken_ratio<T0, 0x2::sui::SUI>(arg3);
        let v3 = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_accounting_available_liquidity<T0, 0x2::sui::SUI>(arg3);
        let v4 = if (arg2 > (v3 as u64)) {
            (v3 as u64)
        } else {
            arg2
        };
        let v5 = SuilendLegAuth{dummy_field: false};
        let (v6, v7) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::begin_rebalance_withdraw_leg<0x2::sui::SUI, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>, SuilendLegAuth>(arg1, arg0, v0, 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::select_ctoken_withdraw_amount((v4 as u128), 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<0x2::sui::SUI, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(arg0, v0), v1, v2, v3), &v5);
        let v8 = SuilendLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_rebalance::finish_rebalance_withdraw_leg<0x2::sui::SUI, T1, SuilendLegAuth>(arg1, arg0, v7, withdraw_underlying_sui<T0>(v6, arg3, arg4, arg5, arg6, arg7), &v8);
    }

    public fun refresh_suilend<T0, T1, T2>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_suilend_config<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1), arg2);
        0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::trigger_accrue<T0>(arg1, arg2, arg3);
        let v0 = SuilendLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::sync_protocol_balance_by_auth<T1, T2, SuilendLegAuth>(arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_underlying_balance<T0, T1>(arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<T1, T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND())), arg3, &v0);
    }

    public fun register_suilend_leg_auth<T0, T1>(arg0: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVGlobal, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg2: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVPoolAdminCap) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::assert_version(arg0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::register_protocol_leg_auth<T0, T1, SuilendLegAuth>(arg1, arg2, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND());
    }

    public fun withdraw_from_suilend<T0, T1, T2>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::WithdrawReceipt<T1, T2>, arg2: u128, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_suilend_config<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg5);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<T1, T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND());
        let v1 = SuilendLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::sync_for_withdraw<T1, T2, SuilendLegAuth>(arg0, arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_underlying_balance<T0, T1>(arg3, v0), arg5, &v1);
        let (v2, v3) = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_ctoken_ratio<T0, T1>(arg3);
        let v4 = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::select_ctoken_withdraw_amount(0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::resolve_requested_withdraw_assets<T1, T2>(arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), arg2), v0, v2, v3, 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_immediate_available_liquidity<T0, T1>(arg3));
        if (v4 == 0) {
            return
        };
        let (v5, v6) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::begin_withdraw_leg<T1, T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>, SuilendLegAuth>(arg1, arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), v4, &v1);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::finish_withdraw_leg<T1, T2, SuilendLegAuth>(arg1, arg0, v6, withdraw_underlying<T0, T1>(v5, arg3, arg4, arg5, arg6), &v1);
    }

    public fun withdraw_from_suilend_sui<T0, T1>(arg0: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::WithdrawReceipt<0x2::sui::SUI, T1>, arg2: u128, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_validation::validate_suilend_config<0x2::sui::SUI, T1>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg6);
        let v0 = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::query_holding_balance<0x2::sui::SUI, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND());
        let v1 = SuilendLegAuth{dummy_field: false};
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::sync_for_withdraw<0x2::sui::SUI, T1, SuilendLegAuth>(arg0, arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_underlying_balance<T0, 0x2::sui::SUI>(arg3, v0), arg6, &v1);
        let (v2, v3) = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_ctoken_ratio<T0, 0x2::sui::SUI>(arg3);
        let v4 = 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::select_ctoken_withdraw_amount(0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::resolve_requested_withdraw_assets<0x2::sui::SUI, T1>(arg1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), arg2), v0, v2, v3, 0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::get_accounting_available_liquidity<T0, 0x2::sui::SUI>(arg3));
        if (v4 == 0) {
            return
        };
        let (v5, v6) = 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::begin_withdraw_leg<0x2::sui::SUI, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>, SuilendLegAuth>(arg1, arg0, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_allocation_plan::PROTOCOL_SUILEND(), v4, &v1);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_user_entry::finish_withdraw_leg<0x2::sui::SUI, T1, SuilendLegAuth>(arg1, arg0, v6, withdraw_underlying_sui<T0>(v5, arg3, arg4, arg5, arg6, arg7), &v1);
    }

    public(friend) fun withdraw_underlying<T0, T1>(arg0: 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::withdraw<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg0, arg4), arg4))
    }

    public(friend) fun withdraw_underlying_sui<T0>(arg0: 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::coin::into_balance<0x2::sui::SUI>(0xc35a45c895e07c60de70a66673e70c2560ce2a185a99679bec8afd8f07d4e252::suilend_adapter::withdraw_sui<T0>(arg1, arg2, arg4, 0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(arg0, arg5), arg3, arg5))
    }

    // decompiled from Move bytecode v6
}

