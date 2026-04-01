module 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_entry {
    struct SuilendLegAuth has drop {
        dummy_field: bool,
    }

    struct SuilendClaimableReward has copy, drop {
        reward_index: u64,
        coin_type: 0x1::type_name::TypeName,
        end_time_ms: u64,
    }

    public fun admin_recall_suilend_to_idle<T0, T1, T2>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::AdminRecallReceipt<T1>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config_with_pyth<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg5));
        let v0 = SuilendLegAuth{dummy_field: false};
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg6);
        let (v1, v2) = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_ctoken_ratio<T0, T1>(arg3);
        let v3 = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_immediate_available_liquidity<T0, T1>(arg3);
        let v4 = if (arg2 > v3) {
            v3
        } else {
            arg2
        };
        let v5 = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::select_ctoken_withdraw_amount((v4 as u128), 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_obligation_ctoken_amount<T0, T1>(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::borrow_cap_for_recall<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0)), v1, v2, v3);
        if (v5 == 0) {
            return
        };
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::refresh_price<T0>(arg3, arg4, arg6, arg5);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::add_recall_withdraw_leg<T1, T2, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), withdraw_underlying<T0, T1>(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::borrow_cap_for_recall<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0), arg4, v5, arg6, arg7), &v0);
    }

    public fun admin_recall_suilend_to_idle_sui<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::AdminRecallReceipt<0x2::sui::SUI>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config_with_pyth<0x2::sui::SUI, T1>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg5));
        let v0 = SuilendLegAuth{dummy_field: false};
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg7);
        let (v1, v2) = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_ctoken_ratio<T0, 0x2::sui::SUI>(arg3);
        let v3 = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_accounting_available_liquidity<T0, 0x2::sui::SUI>(arg3);
        let v4 = if (arg2 > (v3 as u64)) {
            (v3 as u64)
        } else {
            arg2
        };
        let v5 = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::select_ctoken_withdraw_amount((v4 as u128), 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_obligation_ctoken_amount<T0, 0x2::sui::SUI>(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::borrow_cap_for_recall<0x2::sui::SUI, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0)), v1, v2, v3);
        if (v5 == 0) {
            return
        };
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::refresh_price<T0>(arg3, arg4, arg7, arg5);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::add_recall_withdraw_leg<0x2::sui::SUI, T1, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), withdraw_underlying_sui<T0>(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::borrow_cap_for_recall<0x2::sui::SUI, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0), arg4, v5, arg6, arg7, arg8), &v0);
    }

    public fun claim_suilend_rewards<T0, T1, T2, T3>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T2, T3>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_keeper<T2, T3>(arg1, 0x2::tx_context::sender(arg6));
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_fee_recipient_set<T2, T3>(arg1);
        let v0 = SuilendLegAuth{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::claim_rewards<T0, T1>(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_by_auth<T2, T3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0), arg5, arg3, arg4, true, arg6), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_fee_recipient<T2, T3>(arg1));
    }

    public fun deposit_to_suilend<T0, T1, T2>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::DepositReceipt<T1>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        let v0 = SuilendLegAuth{dummy_field: false};
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg5);
        let v1 = query_suilend_underlying<T0, T1, T2>(arg0, arg3, &v0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_for_deposit<T1, T2, SuilendLegAuth>(arg0, arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), v1, arg5, &v0);
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::resolve_requested_deposit_amount<T1>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), arg2);
        if (v2 == 0) {
            return
        };
        let (v3, v4) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::begin_deposit_leg<T1, T2, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), v2, &v0);
        let v5 = v3;
        let v6 = 0x2::balance::value<T1>(&v5);
        deposit_underlying<T0, T1>(v5, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_for_deposit<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0), arg4, arg5, arg6);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::finish_deposit_leg_accounted<T1, T2, SuilendLegAuth>(arg1, arg0, v4, v6, 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::calculate_accounted_value_delta(v1, query_suilend_underlying<T0, T1, T2>(arg0, arg3, &v0)), 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::calculate_max_accounted_gap(v6), &v0);
    }

    public(friend) fun deposit_underlying<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::deposit_ctokens_to_obligation<T0, T1>(arg1, arg3, arg2, arg4, 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::deposit<T0, T1>(arg1, arg3, arg4, 0x2::coin::from_balance<T1>(arg0, arg5), arg5), arg5);
    }

    public fun get_pool_claimable_rewards<T0, T1, T2>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T1, T2>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64) : vector<SuilendClaimableReward> {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config<T1, T2>(arg1, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), arg3);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::pool_rewards(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::deposits_pool_reward_manager<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg2), arg3)));
        let v1 = 0x1::vector::empty<SuilendClaimableReward>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v0)) {
            let v3 = 0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v0, v2);
            if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(v3)) {
                let v4 = 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(v3);
                let v5 = SuilendClaimableReward{
                    reward_index : v2,
                    coin_type    : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::coin_type(v4),
                    end_time_ms  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::end_time_ms(v4),
                };
                0x1::vector::push_back<SuilendClaimableReward>(&mut v1, v5);
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun query_suilend_underlying<T0, T1, T2>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &SuilendLegAuth) : u128 {
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_underlying_balance<T0, T1>(arg1, 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_obligation_ctoken_amount<T0, T1>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_by_auth<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), arg2)))
    }

    public fun rebalance_deposit_to_suilend<T0, T1, T2>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::RebalanceReceipt<T1>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        let v0 = SuilendLegAuth{dummy_field: false};
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg5);
        let v1 = query_suilend_underlying<T0, T1, T2>(arg0, arg3, &v0);
        let (v2, v3) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::begin_rebalance_deposit_leg<T1, T2, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), arg2, &v0);
        let v4 = v2;
        let v5 = 0x2::balance::value<T1>(&v4);
        if (v5 == 0) {
            0x2::balance::destroy_zero<T1>(v4);
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::finish_rebalance_deposit_leg_accounted<T1, T2, SuilendLegAuth>(arg1, arg0, v3, 0, 0, 0, &v0);
            return
        };
        deposit_underlying<T0, T1>(v4, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0), arg4, arg5, arg6);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::finish_rebalance_deposit_leg_accounted<T1, T2, SuilendLegAuth>(arg1, arg0, v3, v5, 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::calculate_accounted_value_delta(v1, query_suilend_underlying<T0, T1, T2>(arg0, arg3, &v0)), 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::calculate_max_accounted_gap(v5), &v0);
    }

    public fun rebalance_withdraw_from_suilend<T0, T1, T2>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::RebalanceReceipt<T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config_with_pyth<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), arg3, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4));
        let v0 = SuilendLegAuth{dummy_field: false};
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::trigger_accrue<T0>(arg2, arg3, arg5);
        let (v1, v2) = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_ctoken_ratio<T0, T1>(arg2);
        let v3 = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::select_ctoken_withdraw_amount(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::get_amount(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::expected_withdraw_plan<T1>(arg1), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND()), 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_obligation_ctoken_amount<T0, T1>(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0)), v1, v2, 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_immediate_available_liquidity<T0, T1>(arg2));
        if (v3 == 0) {
            return
        };
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::refresh_price<T0>(arg2, arg3, arg5, arg4);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::add_rebalance_withdraw_leg<T1, T2, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), withdraw_underlying<T0, T1>(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0), arg3, v3, arg5, arg6), &v0);
    }

    public fun rebalance_withdraw_from_suilend_sui<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::RebalanceReceipt<0x2::sui::SUI>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config_with_pyth<0x2::sui::SUI, T1>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), arg3, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4));
        let v0 = SuilendLegAuth{dummy_field: false};
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::trigger_accrue<T0>(arg2, arg3, arg6);
        let (v1, v2) = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_ctoken_ratio<T0, 0x2::sui::SUI>(arg2);
        let v3 = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::select_ctoken_withdraw_amount(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::get_amount(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::expected_withdraw_plan<0x2::sui::SUI>(arg1), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND()), 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_obligation_ctoken_amount<T0, 0x2::sui::SUI>(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<0x2::sui::SUI, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0)), v1, v2, 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_accounting_available_liquidity<T0, 0x2::sui::SUI>(arg2));
        if (v3 == 0) {
            return
        };
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::refresh_price<T0>(arg2, arg3, arg6, arg4);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::add_rebalance_withdraw_leg<0x2::sui::SUI, T1, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), withdraw_underlying_sui<T0>(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<0x2::sui::SUI, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0), arg3, v3, arg5, arg6, arg7), &v0);
    }

    public fun refresh_suilend<T0, T1, T2>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1), arg2);
        let v0 = SuilendLegAuth{dummy_field: false};
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::trigger_accrue<T0>(arg1, arg2, arg3);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_protocol_balance_by_auth<T1, T2, SuilendLegAuth>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), query_suilend_underlying<T0, T1, T2>(arg0, arg1, &v0), arg3, &v0);
    }

    public fun register_suilend_leg_auth<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::register_protocol_leg_auth<T0, T1, SuilendLegAuth>(arg1, arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND());
    }

    public fun withdraw_from_suilend<T0, T1, T2>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::WithdrawReceipt<T1, T2>, arg2: u128, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config_with_pyth<T1, T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg5));
        let v0 = SuilendLegAuth{dummy_field: false};
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg6);
        let v1 = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_obligation_ctoken_amount<T0, T1>(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_for_withdraw<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0));
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_for_withdraw<T1, T2, SuilendLegAuth>(arg0, arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_underlying_balance<T0, T1>(arg3, v1), arg6, &v0);
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::resolve_requested_withdraw_assets<T1, T2>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), arg2);
        if (v2 == 0) {
            return
        };
        let (v3, v4) = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_ctoken_ratio<T0, T1>(arg3);
        let v5 = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::select_ctoken_withdraw_amount(v2, v1, v3, v4, 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_immediate_available_liquidity<T0, T1>(arg3));
        if (v5 == 0) {
            return
        };
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::refresh_price<T0>(arg3, arg4, arg6, arg5);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::add_withdraw_leg<T1, T2, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), withdraw_underlying<T0, T1>(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_for_withdraw<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0), arg4, v5, arg6, arg7), &v0);
    }

    public fun withdraw_from_suilend_sui<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::WithdrawReceipt<0x2::sui::SUI, T1>, arg2: u128, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config_with_pyth<0x2::sui::SUI, T1>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg5));
        let v0 = SuilendLegAuth{dummy_field: false};
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::trigger_accrue<T0>(arg3, arg4, arg7);
        let v1 = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_obligation_ctoken_amount<T0, 0x2::sui::SUI>(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_for_withdraw<0x2::sui::SUI, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0));
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_for_withdraw<0x2::sui::SUI, T1, SuilendLegAuth>(arg0, arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_underlying_balance<T0, 0x2::sui::SUI>(arg3, v1), arg7, &v0);
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::resolve_requested_withdraw_assets<0x2::sui::SUI, T1>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), arg2);
        if (v2 == 0) {
            return
        };
        let (v3, v4) = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_ctoken_ratio<T0, 0x2::sui::SUI>(arg3);
        let v5 = 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::select_ctoken_withdraw_amount(v2, v1, v3, v4, 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::get_accounting_available_liquidity<T0, 0x2::sui::SUI>(arg3));
        if (v5 == 0) {
            return
        };
        0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::refresh_price<T0>(arg3, arg4, arg7, arg5);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::add_withdraw_leg<0x2::sui::SUI, T1, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), withdraw_underlying_sui<T0>(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_for_withdraw<0x2::sui::SUI, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), &v0), arg4, v5, arg6, arg7, arg8), &v0);
    }

    public(friend) fun withdraw_underlying<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::withdraw<T0, T1>(arg0, arg2, arg4, 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::withdraw_ctokens_from_obligation<T0, T1>(arg0, arg2, arg1, arg4, arg3, arg5), arg5))
    }

    public(friend) fun withdraw_underlying_sui<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg2: u64, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::coin::into_balance<0x2::sui::SUI>(0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::withdraw_sui<T0>(arg0, arg2, arg5, 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::withdraw_ctokens_from_obligation<T0, 0x2::sui::SUI>(arg0, arg2, arg1, arg5, arg3, arg6), arg4, arg6))
    }

    // decompiled from Move bytecode v7
}

