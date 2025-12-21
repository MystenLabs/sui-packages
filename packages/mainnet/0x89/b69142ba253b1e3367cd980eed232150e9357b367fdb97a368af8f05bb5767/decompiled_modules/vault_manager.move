module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_manager {
    fun accrue_interest_and_redistribute<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : (u64, u64, u256, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, _) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_info<T0>(arg0);
        let (v8, v9) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::compute_collateral_debt_rewards<T0>(v2, v3, v4, arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::add_balance_vault_collateral<T0>(arg0, v8);
        let v10 = v0 + 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_interest_debt<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_interest_rate_period<T0>(v6, arg1, arg2), arg0) + v9;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(arg0, v10, arg1);
        let v11 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg2)));
        let v12 = recompute_and_apply_vault_stake<T0>(v2, v11, arg0, arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg2, 0x1::option::some<u64>(v1), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(arg0)), 0x1::option::some<u64>(v0), 0x1::option::some<u64>(v10), 0x1::option::some<u64>(v5), 0x1::option::some<u64>(v5));
        (v10, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(arg0), v12, v5)
    }

    public entry fun add_collateral<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg4, arg3, arg6, arg5);
        compute_stability_pool_interest<T0>(0, arg5, arg4, arg6, arg2, arg7);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg3, arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v1, v2, v3, _) = accrue_interest_and_redistribute<T0>(v0, arg2, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::add_balance_vault_collateral<T0>(v0, 0x2::coin::into_balance<T0>(arg0));
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v0);
        let v6 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg4)));
        let v7 = recompute_and_apply_vault_stake<T0>(v3, v6, v0, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v2), 0x1::option::some<u64>(v5), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_add_collateral_event(arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), 0x2::coin::value<T0>(&arg0), v2, v5, v1, v3, v7);
    }

    public entry fun add_collateral_v2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg7: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg8: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun add_collateral_v3<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg8: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg4, arg3, arg6, arg5);
        compute_stability_pool_interest_v3<T0>(0, arg5, arg4, arg6, arg7, arg2, arg8);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg3, arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v1, v2, v3, _) = accrue_interest_and_redistribute<T0>(v0, arg2, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::add_balance_vault_collateral<T0>(v0, 0x2::coin::into_balance<T0>(arg0));
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v0);
        let v6 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg4)));
        let v7 = recompute_and_apply_vault_stake<T0>(v3, v6, v0, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v2), 0x1::option::some<u64>(v5), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_add_collateral_event(arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), 0x2::coin::value<T0>(&arg0), v2, v5, v1, v3, v7);
    }

    public entry fun adjust_interest_rate<T0>(arg0: 0x1::option::Option<0x2::object::ID>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg6, arg5, arg8, arg7);
        compute_stability_pool_interest<T0>(0, arg7, arg6, arg8, arg3, arg11);
        assert_not_shutdown<T0>(arg6);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::get_vault_id_from_admin(arg4);
        check_min_max_rate_allowed<T0>(arg2, arg6);
        let (v1, _) = get_oracle_price<T0>(0, arg6, arg9, arg10, arg3);
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg5, v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg6));
        let (v4, v5, _, v7) = accrue_interest_and_redistribute<T0>(v3, arg3, arg6);
        let v8 = get_protocol_borrow_fee_amount<T0>(v4, arg6);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_fee_vault(arg7, v8, arg11);
        let v9 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_protocol_average_interest_rate<T0>(v4, arg6);
        distribute_yield_to_stability_pool<T0>(v9, arg7, arg8, arg11);
        let v10 = v4 + v8 + v9;
        assert_min_debt_allowed<T0>(v10, arg6);
        assert!(is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg6)), v1), v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe_v2<T0>(v1, v5, v4, v5, v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v3, v10, arg3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_interest_rate<T0>(v3, arg2, arg3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::reinsert_node<T0>(arg6, v0, arg3, arg2, arg0, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg6, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(v4), 0x1::option::some<u64>(v10), 0x1::option::some<u64>(v7), 0x1::option::some<u64>(arg2));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_interest_update_event(v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg6), v5, v4, v10, v7, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun adjust_interest_rate_v2<T0>(arg0: 0x1::option::Option<0x2::object::ID>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg12: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg13: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun adjust_interest_rate_v3<T0>(arg0: 0x1::option::Option<0x2::object::ID>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg12: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg6, arg5, arg8, arg7);
        compute_stability_pool_interest_v3<T0>(0, arg7, arg6, arg8, arg11, arg3, arg12);
        assert_not_shutdown<T0>(arg6);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::get_vault_id_from_admin(arg4);
        check_min_max_rate_allowed<T0>(arg2, arg6);
        let (v1, _) = get_oracle_price<T0>(0, arg6, arg9, arg10, arg3);
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg5, v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg6));
        let (v4, v5, _, v7) = accrue_interest_and_redistribute<T0>(v3, arg3, arg6);
        let v8 = get_protocol_borrow_fee_amount<T0>(v4, arg6);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_fee_vault(arg7, v8, arg12);
        let v9 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_protocol_average_interest_rate<T0>(v4, arg6);
        distribute_yield_to_stability_pool<T0>(v9, arg7, arg8, arg12);
        let v10 = v4 + v8 + v9;
        assert_min_debt_allowed<T0>(v10, arg6);
        assert!(is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg6)), v1), v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe_v2<T0>(v1, v5, v4, v5, v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v3, v10, arg3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_interest_rate<T0>(v3, arg2, arg3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::reinsert_node<T0>(arg6, v0, arg3, arg2, arg0, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg6, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(v4), 0x1::option::some<u64>(v10), 0x1::option::some<u64>(v7), 0x1::option::some<u64>(arg2));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_interest_update_event(v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg6), v5, v4, v10, v7, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    fun apply_coll_penalty_and_surplus(arg0: u64, arg1: u64, arg2: u64, arg3: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg4: u256) : (u64, u64) {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(arg1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::BASIS_POINTS() + arg2)), arg3), arg4);
        if (arg0 > v0) {
            (v0, arg0 - v0)
        } else {
            (arg0, 0)
        }
    }

    fun assert_context_basic<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg3: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global) {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::assert_version<T0>(arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::assert_version(arg3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::assert_version<T0>(arg0);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::assert_version<T0>(arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::assert_vault_registry_id<T0>(arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg0));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::assert_vault_registry_id<T0>(arg2, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg0));
    }

    fun assert_context_with_surplus<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg3: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool::SurplusPool<T0>, arg4: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global) {
        assert_context_basic<T0>(arg0, arg1, arg2, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool::assert_version<T0>(arg3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool::assert_vault_registry_id<T0>(arg3, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg0));
    }

    fun assert_min_debt_allowed<T0>(arg0: u64, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) {
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::ge(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_debt_allowed<T0>(arg1))), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EMinDebtTooLow());
    }

    fun assert_not_shutdown<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) {
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_shutdown_timestamp<T0>(arg0) == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EShutdownActive());
    }

    fun assert_tcr_is_safe<T0>(arg0: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) {
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
    }

    public entry fun borrow_more<T0>(arg0: u64, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg6, arg5, arg8, arg7);
        assert_not_shutdown<T0>(arg6);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::get_vault_id_from_admin(arg4);
        let v1 = get_protocol_borrow_fee_amount<T0>(arg0, arg6);
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_protocol_average_interest_rate<T0>(arg0, arg6);
        compute_stability_pool_interest<T0>(v2, arg7, arg6, arg8, arg3, arg11);
        let (v3, _) = get_oracle_price<T0>(0, arg6, arg9, arg10, arg3);
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg5, v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg6));
        let (v6, v7, _, v9) = accrue_interest_and_redistribute<T0>(v5, arg3, arg6);
        let v10 = v6 + arg0 + v1 + v2;
        assert_min_debt_allowed<T0>(v10, arg6);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v5, v10, arg3);
        let (v11, _) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_redemption_node<T0>(arg6, 0x1::option::some<0x2::object::ID>(v0));
        let v13 = v11;
        if (!0x1::option::is_some<0x2::object::ID>(&v13)) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::add_node<T0>(arg6, v0, arg3, v9, arg1, arg2, arg11);
        };
        assert!(is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v7, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg6)), v3), v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe_v2<T0>(v3, v7, v6, v7, v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg6, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(v6), 0x1::option::some<u64>(v10), 0x1::option::some<u64>(v9), 0x1::option::some<u64>(v9));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_fee_vault(arg7, v1, arg11);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_transfer(arg7, arg0, 0x2::tx_context::sender(arg11), arg11);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_borrow_more_event(v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg6), arg0, v7, v6, v10);
    }

    public entry fun borrow_more_v2<T0>(arg0: u64, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg12: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg13: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun borrow_more_v3<T0>(arg0: u64, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg12: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg6, arg5, arg8, arg7);
        assert_not_shutdown<T0>(arg6);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::get_vault_id_from_admin(arg4);
        let v1 = get_protocol_borrow_fee_amount<T0>(arg0, arg6);
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_protocol_average_interest_rate<T0>(arg0, arg6);
        compute_stability_pool_interest_v3<T0>(v2, arg7, arg6, arg8, arg11, arg3, arg12);
        let (v3, _) = get_oracle_price<T0>(0, arg6, arg9, arg10, arg3);
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg5, v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg6));
        let (v6, v7, _, v9) = accrue_interest_and_redistribute<T0>(v5, arg3, arg6);
        let v10 = v6 + arg0 + v1 + v2;
        assert_min_debt_allowed<T0>(v10, arg6);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v5, v10, arg3);
        let (v11, _) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_redemption_node<T0>(arg6, 0x1::option::some<0x2::object::ID>(v0));
        let v13 = v11;
        if (!0x1::option::is_some<0x2::object::ID>(&v13)) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::add_node<T0>(arg6, v0, arg3, v9, arg1, arg2, arg12);
        };
        assert!(is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v7, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg6)), v3), v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe_v2<T0>(v3, v7, v6, v7, v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg6, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(v6), 0x1::option::some<u64>(v10), 0x1::option::some<u64>(v9), 0x1::option::some<u64>(v9));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_fee_vault(arg7, v1, arg12);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_transfer(arg7, arg0, 0x2::tx_context::sender(arg12), arg12);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_borrow_more_event(v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg6), arg0, v7, v6, v10);
    }

    fun check_min_max_rate_allowed<T0>(arg0: u64, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) {
        let (v0, v1) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_max_interest_rate_bps<T0>(arg1);
        assert!(arg0 >= v0 && arg0 <= v1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EInterestRateOutsideRange());
    }

    public entry fun close_vault<T0>(arg0: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg4, arg1, arg5, arg3);
        compute_stability_pool_interest<T0>(0, arg3, arg4, arg5, arg6, arg7);
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault_active_counter<T0>(arg1) > 1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EOnlyOneVaultLeft());
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::get_vault_id_from_admin(&arg0);
        let v1 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg1, v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v2, v3, v4, v5) = accrue_interest_and_redistribute<T0>(v1, arg6, arg4);
        let (_, _, _) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_and_get_new_stake<T0>(v4, 0, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v3), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v2), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v5), 0x1::option::some<u64>(0));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::remove_node<T0>(arg4, v0);
        assert!(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg2) >= v2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ERepayShouldBeEqualDebt());
        let v9 = 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg3, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v9, v2), arg7));
        let v10 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::delete_vault<T0>(v0, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::delete_vault_admin(arg0);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_close_vault_event(v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), true, 0x2::balance::value<T0>(&v10), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v9, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg7), 0x2::tx_context::sender(arg7));
    }

    public entry fun close_vault_v2<T0>(arg0: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg6: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg7: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun close_vault_v3<T0>(arg0: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg4, arg1, arg5, arg3);
        compute_stability_pool_interest_v3<T0>(0, arg3, arg4, arg5, arg6, arg7, arg8);
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault_active_counter<T0>(arg1) > 1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EOnlyOneVaultLeft());
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::get_vault_id_from_admin(&arg0);
        let v1 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg1, v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v2, v3, v4, v5) = accrue_interest_and_redistribute<T0>(v1, arg7, arg4);
        let (_, _, _) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_and_get_new_stake<T0>(v4, 0, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v3), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v2), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v5), 0x1::option::some<u64>(0));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::remove_node<T0>(arg4, v0);
        assert!(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg2) >= v2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ERepayShouldBeEqualDebt());
        let v9 = 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg3, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v9, v2), arg8));
        let v10 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::delete_vault<T0>(v0, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::delete_vault_admin(arg0);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_close_vault_event(v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), true, 0x2::balance::value<T0>(&v10), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v9, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg8), 0x2::tx_context::sender(arg8));
    }

    fun compute_offset_and_redistribution<T0>(arg0: u64, arg1: u64, arg2: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg3: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg4: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : (u64, u64, u64, u64, u64) {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg4);
        let v1 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(arg0), arg2);
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(arg1, v0), v1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(arg0));
        let (v3, v4) = apply_coll_penalty_and_surplus(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v2, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(v1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_liquidation_fee_bps<T0>(arg4), arg3, v0);
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(arg0), v1);
        let v6 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(arg1, v0), v2);
        let v7 = 0;
        let v8 = 0;
        if (0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v5) > 0 && 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v6) > 0) {
            let (v9, v10) = apply_coll_penalty_and_surplus(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v6, v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(v5), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_liquidation_fee_redistribution_bps<T0>(arg4), arg3, v0);
            v8 = v10;
            v7 = v9;
        };
        (0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(v1), v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(v5), v7, v4 + v8)
    }

    fun compute_stability_pool_interest<T0>(arg0: u64, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        distribute_yield_to_stability_pool<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry_interest_and_return<T0>(arg2, arg4) + arg0, arg1, arg3, arg5);
    }

    fun compute_stability_pool_interest_v3<T0>(arg0: u64, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry_interest_and_return<T0>(arg2, arg5) + arg0;
        let v1 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_savings_fee_bps<T0>(arg2)));
        distribute_yield_savings(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(v1), arg1, arg4, arg5, arg6);
        distribute_yield_to_stability_pool<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v0), v1)), arg1, arg3, arg6);
    }

    public entry fun create_vault<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &0x2::clock::Clock, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_context_basic<T0>(arg3, arg4, arg11, arg7);
        assert_not_shutdown<T0>(arg3);
        check_min_max_rate_allowed<T0>(arg0, arg3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        let (v1, v2) = get_oracle_price<T0>(v0, arg3, arg9, arg10, arg8);
        let v3 = get_protocol_borrow_fee_amount<T0>(arg2, arg3);
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_protocol_average_interest_rate<T0>(arg2, arg3);
        let v5 = arg2 + v3 + v4;
        assert_tcr_is_safe<T0>(v1, 0, 0, v0, v5, arg3);
        assert_min_debt_allowed<T0>(v5, arg3);
        assert!(is_vault_above_mcr<T0>(v2, v5, arg3), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        compute_stability_pool_interest<T0>(v4, arg7, arg3, arg11, arg8, arg12);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_fee_vault(arg7, v3, arg12);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_transfer(arg7, arg2, 0x2::tx_context::sender(arg12), arg12);
        let (v6, v7, v8) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_and_get_new_stake<T0>(0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg3))), arg3);
        let (v9, v10) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::create_new_vault<T0>(0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3), arg1, 0x2::clock::timestamp_ms(arg8), arg0, v5, v6, v7, v8, arg4, arg12);
        let v11 = v10;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::add_node<T0>(arg3, v9, arg8, arg0, arg5, arg6, arg12);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg3, 0x1::option::some<u64>(0), 0x1::option::some<u64>(v0), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v5), 0x1::option::some<u64>(0), 0x1::option::some<u64>(arg0));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_create_vault_event(v9, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3), 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin>(&v11), arg0, v0, arg2, v5, v6, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        0x2::transfer::public_transfer<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin>(v11, 0x2::tx_context::sender(arg12));
        v9
    }

    public entry fun create_vault_v2<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &0x2::clock::Clock, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg12: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg13: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg14: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        abort 0
    }

    public entry fun create_vault_v3<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &0x2::clock::Clock, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg12: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        abort 0
    }

    public fun create_vault_v4<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &0x2::clock::Clock, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg12: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg13: &mut 0x2::tx_context::TxContext) : (0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, 0x2::object::ID) {
        assert_context_basic<T0>(arg3, arg4, arg11, arg7);
        assert_not_shutdown<T0>(arg3);
        check_min_max_rate_allowed<T0>(arg0, arg3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        let (v1, v2) = get_oracle_price<T0>(v0, arg3, arg9, arg10, arg8);
        let v3 = get_protocol_borrow_fee_amount<T0>(arg2, arg3);
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_protocol_average_interest_rate<T0>(arg2, arg3);
        let v5 = arg2 + v3 + v4;
        assert_tcr_is_safe<T0>(v1, 0, 0, v0, v5, arg3);
        assert_min_debt_allowed<T0>(v5, arg3);
        assert!(is_vault_above_mcr<T0>(v2, v5, arg3), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        compute_stability_pool_interest_v3<T0>(v4, arg7, arg3, arg11, arg12, arg8, arg13);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_fee_vault(arg7, v3, arg13);
        let (v6, v7, v8) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_and_get_new_stake<T0>(0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg3))), arg3);
        let (v9, v10) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::create_new_vault<T0>(0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3), arg1, 0x2::clock::timestamp_ms(arg8), arg0, v5, v6, v7, v8, arg4, arg13);
        let v11 = v10;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::add_node<T0>(arg3, v9, arg8, arg0, arg5, arg6, arg13);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg3, 0x1::option::some<u64>(0), 0x1::option::some<u64>(v0), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v5), 0x1::option::some<u64>(0), 0x1::option::some<u64>(arg0));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_create_vault_event(v9, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3), 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin>(&v11), arg0, v0, arg2, v5, v6, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        (v11, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_return_coin(arg7, arg2, arg13), v9)
    }

    fun distribute_yield_savings(arg0: u64, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg0 > 0) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::distribute_yield(arg2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_return_coin(arg1, arg0, arg4), arg3);
        };
    }

    fun distribute_yield_to_stability_pool<T0>(arg0: u64, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0 > 0) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::trigger_dori_yield_distribution<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_return_coin(arg1, arg0, arg3), arg2);
        };
    }

    fun get_oracle_price<T0>(arg0: u64, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg4: &0x2::clock::Clock) : (0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal) {
        let (v0, _, _, v3) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::oracles::get_pyth_price_and_identifier(arg2, arg4);
        let v4 = v0;
        assert!(v3 == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_price_feed_id<T0>(arg1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::ORACLE_TYPE_PYTH()), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EPriceFeedID());
        if (0x1::option::is_some<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal>(&v4)) {
            let v5 = *0x1::option::borrow<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal>(&v4);
            return (v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(arg0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg1)), v5))
        };
        let (v6, _, v8) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::oracles::get_switchboard_price_and_identifier(arg3, arg4);
        let v9 = v6;
        assert!(v8 == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_price_feed_id<T0>(arg1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::ORACLE_TYPE_SWITCHBOARD()), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EPriceFeedID());
        assert!(0x1::option::is_some<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal>(&v9), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EOracleIssue());
        let v10 = *0x1::option::borrow<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal>(&v9);
        (v10, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(arg0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg1)), v10))
    }

    fun get_protocol_borrow_fee_amount<T0>(arg0: u64, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : u64 {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_protocol_borrow_fee_bps<T0>(arg1))))
    }

    fun intern_close_vault_by_liquidation<T0>(arg0: 0x2::object::ID, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : 0x2::balance::Balance<T0> {
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault_active_counter<T0>(arg1) > 1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EOnlyOneVaultLeft());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::remove_node<T0>(arg2, arg0);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::delete_vault<T0>(arg0, arg1)
    }

    fun is_vault_above_icr(arg0: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg1: u64) : bool {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::BASIS_POINTS());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::ge(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(arg0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(arg1)), v0), v0)
    }

    fun is_vault_above_mcr<T0>(arg0: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg1: u64, arg2: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : bool {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::ge(arg0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(arg1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_collateral_threshold_bps<T0>(arg2))))
    }

    fun liquidate_single_vault<T0>(arg0: 0x2::object::ID, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool::SurplusPool<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg7: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg1, arg0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v1, v2, v3, v4) = accrue_interest_and_redistribute<T0>(v0, arg8, arg4);
        if (is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg4)), arg7), v1, arg4)) {
            return 0
        };
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault_active_counter<T0>(arg1) > 1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EOnlyOneVaultLeft());
        let (_, _, _) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_and_get_new_stake<T0>(v3, 0, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v2), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v1), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v4), 0x1::option::some<u64>(0));
        let (v8, v9, v10, v11, _) = compute_offset_and_redistribution<T0>(v1, v2, *arg6, arg7, arg4);
        if (v8 > 0) {
            *arg6 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(*arg6, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v8));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::offset_v2<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v8)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg4), 0x2::coin::from_balance<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v0, v9), arg9), arg5, arg3, arg9);
        };
        if (v10 > 0) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::redistribute_debt_and_collateral<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v10)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v0, v11), arg4);
        };
        let v13 = intern_close_vault_by_liquidation<T0>(arg0, arg1, arg4);
        if (0x2::balance::value<T0>(&v13) > 0) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool::update_surplus<T0>(0x1::option::destroy_some<0x2::object::ID>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_admin_owner_id<T0>(v0)), v13, arg2, arg8);
        } else {
            0x2::balance::destroy_zero<T0>(v13);
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_liquidation_event(arg0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), v2, 0, v1, 0, v3, 0, v4, 0);
        v8 + v10
    }

    public entry fun liquidate_vault<T0>(arg0: vector<0x2::object::ID>, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool::SurplusPool<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_context_with_surplus<T0>(arg3, arg1, arg4, arg7, arg2);
        compute_stability_pool_interest<T0>(0, arg2, arg3, arg4, arg8, arg9);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg0);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EEmptyVaultList());
        let (v1, _) = get_oracle_price<T0>(0, arg3, arg5, arg6, arg8);
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::get_total_dori_balance<T0>(arg4);
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v3), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::MIN_TO_LEAVE_IN_SP()), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v3)));
        let v5 = 0;
        let v6 = 0;
        while (v6 < v0) {
            let v7 = &mut v4;
            let v8 = liquidate_single_vault<T0>(*0x1::vector::borrow<0x2::object::ID>(&arg0, v6), arg1, arg7, arg2, arg3, arg4, v7, v1, arg8, arg9);
            v5 = v5 + v8;
            v6 = v6 + 1;
        };
        if (v5 == 0) {
            abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENoVaultsLiquidated()
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::after_liquidation_update_system_snapshots<T0>(arg3);
    }

    public entry fun liquidate_vault_v2<T0>(arg0: vector<0x2::object::ID>, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool::SurplusPool<T0>, arg8: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg9: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun liquidate_vault_v3<T0>(arg0: vector<0x2::object::ID>, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool::SurplusPool<T0>, arg8: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_context_with_surplus<T0>(arg3, arg1, arg4, arg7, arg2);
        compute_stability_pool_interest_v3<T0>(0, arg2, arg3, arg4, arg8, arg9, arg10);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg0);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EEmptyVaultList());
        let (v1, _) = get_oracle_price<T0>(0, arg3, arg5, arg6, arg9);
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::get_total_dori_balance<T0>(arg4);
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v3), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::MIN_TO_LEAVE_IN_SP()), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v3)));
        let v5 = 0;
        let v6 = 0;
        while (v6 < v0) {
            let v7 = &mut v4;
            let v8 = liquidate_single_vault<T0>(*0x1::vector::borrow<0x2::object::ID>(&arg0, v6), arg1, arg7, arg2, arg3, arg4, v7, v1, arg9, arg10);
            v5 = v5 + v8;
            v6 = v6 + 1;
        };
        if (v5 == 0) {
            abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENoVaultsLiquidated()
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::after_liquidation_update_system_snapshots<T0>(arg3);
    }

    fun recompute_and_apply_vault_stake<T0>(arg0: u256, arg1: u256, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : u256 {
        let (v0, v1, v2) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_and_get_new_stake<T0>(arg0, arg1, arg3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_stake<T0>(arg2, v1, v2, v0);
        v0
    }

    public entry fun repay_debt<T0>(arg0: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg4, arg3, arg6, arg5);
        compute_stability_pool_interest<T0>(0, arg5, arg4, arg6, arg2, arg7);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg3, arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v1, v2, _, v4) = accrue_interest_and_redistribute<T0>(v0, arg2, arg4);
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v1);
        let v6 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0)));
        let v7 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v5, v6));
        assert_min_debt_allowed<T0>(v7, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v0, v7, arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(v1), 0x1::option::some<u64>(v7), 0x1::option::some<u64>(v4), 0x1::option::some<u64>(v4));
        let v8 = 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg0);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg5, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v8, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(v6)), arg7));
        if (0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v8, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::balance::destroy_zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v8);
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_repay_debt_event(arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), v2, 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0), v1, v7);
    }

    public entry fun repay_debt_v2<T0>(arg0: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg7: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg8: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun repay_debt_v3<T0>(arg0: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg8: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg4, arg3, arg6, arg5);
        compute_stability_pool_interest_v3<T0>(0, arg5, arg4, arg6, arg7, arg2, arg8);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg3, arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v1, v2, _, v4) = accrue_interest_and_redistribute<T0>(v0, arg2, arg4);
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v1);
        let v6 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0)));
        let v7 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v5, v6));
        assert_min_debt_allowed<T0>(v7, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v0, v7, arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(v1), 0x1::option::some<u64>(v7), 0x1::option::some<u64>(v4), 0x1::option::some<u64>(v4));
        let v8 = 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg0);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg5, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v8, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(v6)), arg8));
        if (0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v8, arg8), 0x2::tx_context::sender(arg8));
        } else {
            0x2::balance::destroy_zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v8);
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_repay_debt_event(arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), v2, 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0), v1, v7);
    }

    public entry fun shutdown<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::assert_vault_registry_id<T0>(arg3, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg2));
        compute_stability_pool_interest<T0>(0, arg1, arg2, arg3, arg4, arg5);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::set_shutdown_timestamp<T0>(arg0, arg4, arg2);
    }

    public entry fun shutdown_v2<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg4: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg5: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun shutdown_v3<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::assert_vault_registry_id<T0>(arg3, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg2));
        compute_stability_pool_interest_v3<T0>(0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::set_shutdown_timestamp<T0>(arg0, arg5, arg2);
    }

    public entry fun urgent_vault_redemption<T0>(arg0: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: vector<0x2::object::ID>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg4, arg2, arg5, arg3);
        compute_stability_pool_interest<T0>(0, arg3, arg4, arg5, arg8, arg9);
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0);
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_shutdown_timestamp<T0>(arg4) > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EShutdownActive());
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        assert!(0x1::vector::length<0x2::object::ID>(&arg1) > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EEmptyVaultList());
        let (v1, _) = get_oracle_price<T0>(0, arg4, arg6, arg7, arg8);
        let v3 = 0x2::balance::zero<T0>();
        let v4 = 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            if (0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v4) == 0) {
                break
            };
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v5);
            let v7 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg2, v6, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
            let (v8, v9, v10, v11) = accrue_interest_and_redistribute<T0>(v7, arg8, arg4);
            let v12 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg4);
            let v13 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::one(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_premium_redemption_bps<T0>(arg4)));
            let v14 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v9, v12), v1), v13), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v8)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v4)));
            let v15 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(v14);
            if (v15 == 0) {
                v5 = v5 + 1;
                continue
            };
            let v16 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(v14, v13), v1);
            0x2::balance::join<T0>(&mut v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v7, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v16, v12)));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg3, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v4, v15), arg9));
            let v17 = v8 - v15;
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v7, v17, arg8);
            let v18 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v7), v12));
            let v19 = recompute_and_apply_vault_stake<T0>(v10, v18, v7, arg4);
            let v20 = v11;
            if (v17 < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_debt_allowed<T0>(arg4)) {
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::remove_node<T0>(arg4, v6);
                let (_, v22) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_max_interest_rate_bps<T0>(arg4);
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_interest_rate<T0>(v7, v22, arg8);
                v20 = v22;
            };
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v9), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v7)), 0x1::option::some<u64>(v8), 0x1::option::some<u64>(v17), 0x1::option::some<u64>(v11), 0x1::option::some<u64>(v20));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_urgent_redemption_event(v6, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v16, v12), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v9, v12), v16), v12), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v7), v15, v8, v17, v10, v19, v11, v20);
            v5 = v5 + 1;
        };
        let v23 = v0 - 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v4);
        assert!(v23 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENoRedemptionHappened());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_redemption_rate_bps<T0>(v23, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::get_total_dori_total_supply(arg3), arg8, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v4, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun urgent_vault_redemption_v2<T0>(arg0: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: vector<0x2::object::ID>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg8: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg9: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun urgent_vault_redemption_v3<T0>(arg0: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: vector<0x2::object::ID>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg8: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg4, arg2, arg5, arg3);
        compute_stability_pool_interest_v3<T0>(0, arg3, arg4, arg5, arg8, arg9, arg10);
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0);
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_shutdown_timestamp<T0>(arg4) > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EShutdownActive());
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        assert!(0x1::vector::length<0x2::object::ID>(&arg1) > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EEmptyVaultList());
        let (v1, _) = get_oracle_price<T0>(0, arg4, arg6, arg7, arg9);
        let v3 = 0x2::balance::zero<T0>();
        let v4 = 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            if (0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v4) == 0) {
                break
            };
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v5);
            let v7 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg2, v6, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
            let (v8, v9, v10, v11) = accrue_interest_and_redistribute<T0>(v7, arg9, arg4);
            let v12 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg4);
            let v13 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::one(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_premium_redemption_bps<T0>(arg4)));
            let v14 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v9, v12), v1), v13), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v8)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v4)));
            let v15 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(v14);
            if (v15 == 0) {
                v5 = v5 + 1;
                continue
            };
            let v16 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(v14, v13), v1);
            0x2::balance::join<T0>(&mut v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v7, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v16, v12)));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg3, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v4, v15), arg10));
            let v17 = v8 - v15;
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v7, v17, arg9);
            let v18 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v7), v12));
            let v19 = recompute_and_apply_vault_stake<T0>(v10, v18, v7, arg4);
            let v20 = v11;
            if (v17 < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_debt_allowed<T0>(arg4)) {
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::remove_node<T0>(arg4, v6);
                let (_, v22) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_max_interest_rate_bps<T0>(arg4);
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_interest_rate<T0>(v7, v22, arg9);
                v20 = v22;
            };
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v9), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v7)), 0x1::option::some<u64>(v8), 0x1::option::some<u64>(v17), 0x1::option::some<u64>(v11), 0x1::option::some<u64>(v20));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_urgent_redemption_event(v6, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v16, v12), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v9, v12), v16), v12), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v7), v15, v8, v17, v10, v19, v11, v20);
            v5 = v5 + 1;
        };
        let v23 = v0 - 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v4);
        assert!(v23 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENoRedemptionHappened());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_redemption_rate_bps<T0>(v23, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::get_total_dori_total_supply(arg3), arg9, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v4, arg10), 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg10), 0x2::tx_context::sender(arg10));
    }

    public entry fun vault_redemption<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg3, arg0, arg4, arg2);
        compute_stability_pool_interest<T0>(0, arg2, arg3, arg4, arg7, arg9);
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        assert_not_shutdown<T0>(arg3);
        assert!(arg8 > 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::REDEMPTION_FEE_FLOOR_BPS() && arg8 < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::BASIS_POINTS(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ERedemptionSlippageOutOfRange());
        let (v1, _) = get_oracle_price<T0>(0, arg3, arg5, arg6, arg7);
        assert_tcr_is_safe<T0>(v1, 0, 0, 0, 0, arg3);
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::get_total_dori_total_supply(arg2);
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_redemption_rate_bps<T0>(v0, v3, arg7, arg3);
        let v5 = 0x2::balance::zero<T0>();
        let v6 = 0x2::balance::zero<T0>();
        let v7 = 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1);
        let v8 = 0x1::option::none<0x2::object::ID>();
        assert!(v4 <= arg8, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ERedemptionSlippageExceed());
        loop {
            if (0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v7) == 0) {
                break
            };
            let (v9, v10) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_redemption_node<T0>(arg3, v8);
            v8 = v10;
            let v11 = v9;
            if (!0x1::option::is_some<0x2::object::ID>(&v11)) {
                break
            };
            let v12 = *0x1::option::borrow<0x2::object::ID>(&v11);
            let v13 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg0, v12, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3));
            let (v14, v15, v16, v17) = accrue_interest_and_redistribute<T0>(v13, arg7, arg3);
            let v18 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg3);
            let v19 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v15, v18), v1);
            if (!is_vault_above_icr(v19, v14)) {
                if (0x1::option::is_some<0x2::object::ID>(&v8)) {
                    continue
                } else {
                    break
                };
            };
            let v20 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(v19, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v14)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v7))));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg2, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v7, v20), arg9));
            let v21 = v14 - v20;
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v13, v21, arg7);
            let v22 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v20), v1);
            let v23 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(v22, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(v4));
            let v24 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v22, v23);
            0x2::balance::join<T0>(&mut v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v13, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v24, v18)));
            0x2::balance::join<T0>(&mut v6, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v13, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v23, v18)));
            let v25 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v13), v18));
            let v26 = recompute_and_apply_vault_stake<T0>(v16, v25, v13, arg3);
            let v27 = v17;
            if (v21 < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_debt_allowed<T0>(arg3)) {
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::remove_node<T0>(arg3, v12);
                let (_, v29) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_max_interest_rate_bps<T0>(arg3);
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_interest_rate<T0>(v13, v29, arg7);
                v27 = v29;
            };
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg3, 0x1::option::some<u64>(v15), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v13)), 0x1::option::some<u64>(v14), 0x1::option::some<u64>(v21), 0x1::option::some<u64>(v17), 0x1::option::some<u64>(v27));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_redemption_event(v12, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(v23, v24), v18), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v15, v18), v23), v24), v18), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v13), v20, v14, v21, v16, v26, v17, v27);
            if (0x1::option::is_some<0x2::object::ID>(&v8)) {
            } else {
                break
            };
        };
        let v30 = v0 - 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v7);
        assert!(v30 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENoRedemptionHappened());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_redemption_rate_bps<T0>(v30, v3, arg7, arg3);
        if (0x2::balance::value<T0>(&v6) > 0) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::add_fee_vault_balance<T0>(v6, arg3);
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v7, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun vault_redemption_v2<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg7: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg8: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun vault_redemption_v3<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg3, arg0, arg4, arg2);
        compute_stability_pool_interest_v3<T0>(0, arg2, arg3, arg4, arg7, arg8, arg10);
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        assert_not_shutdown<T0>(arg3);
        assert!(arg9 > 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::REDEMPTION_FEE_FLOOR_BPS() && arg9 < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::BASIS_POINTS(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ERedemptionSlippageOutOfRange());
        let (v1, _) = get_oracle_price<T0>(0, arg3, arg5, arg6, arg8);
        assert_tcr_is_safe<T0>(v1, 0, 0, 0, 0, arg3);
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::get_total_dori_total_supply(arg2);
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_redemption_rate_bps<T0>(v0, v3, arg8, arg3);
        let v5 = 0x2::balance::zero<T0>();
        let v6 = 0x2::balance::zero<T0>();
        let v7 = 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1);
        let v8 = 0x1::option::none<0x2::object::ID>();
        assert!(v4 <= arg9, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ERedemptionSlippageExceed());
        loop {
            if (0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v7) == 0) {
                break
            };
            let (v9, v10) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_redemption_node<T0>(arg3, v8);
            v8 = v10;
            let v11 = v9;
            if (!0x1::option::is_some<0x2::object::ID>(&v11)) {
                break
            };
            let v12 = *0x1::option::borrow<0x2::object::ID>(&v11);
            let v13 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg0, v12, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3));
            let (v14, v15, v16, v17) = accrue_interest_and_redistribute<T0>(v13, arg8, arg3);
            let v18 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg3);
            let v19 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v15, v18), v1);
            if (!is_vault_above_icr(v19, v14)) {
                if (0x1::option::is_some<0x2::object::ID>(&v8)) {
                    continue
                } else {
                    break
                };
            };
            let v20 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(v19, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v14)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v7))));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg2, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v7, v20), arg10));
            let v21 = v14 - v20;
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v13, v21, arg8);
            let v22 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v20), v1);
            let v23 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(v22, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(v4));
            let v24 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v22, v23);
            0x2::balance::join<T0>(&mut v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v13, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v24, v18)));
            0x2::balance::join<T0>(&mut v6, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v13, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v23, v18)));
            let v25 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v13), v18));
            let v26 = recompute_and_apply_vault_stake<T0>(v16, v25, v13, arg3);
            let v27 = v17;
            if (v21 < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_debt_allowed<T0>(arg3)) {
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::remove_node<T0>(arg3, v12);
                let (_, v29) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_max_interest_rate_bps<T0>(arg3);
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_interest_rate<T0>(v13, v29, arg8);
                v27 = v29;
            };
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg3, 0x1::option::some<u64>(v15), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v13)), 0x1::option::some<u64>(v14), 0x1::option::some<u64>(v21), 0x1::option::some<u64>(v17), 0x1::option::some<u64>(v27));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_redemption_event(v12, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(v23, v24), v18), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v15, v18), v23), v24), v18), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v13), v20, v14, v21, v16, v26, v17, v27);
            if (0x1::option::is_some<0x2::object::ID>(&v8)) {
            } else {
                break
            };
        };
        let v30 = v0 - 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v7);
        assert!(v30 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENoRedemptionHappened());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_redemption_rate_bps<T0>(v30, v3, arg8, arg3);
        if (0x2::balance::value<T0>(&v6) > 0) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::add_fee_vault_balance<T0>(v6, arg3);
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v7, arg10), 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg10), 0x2::tx_context::sender(arg10));
    }

    public entry fun withdraw_collateral<T0>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg9: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg4, arg3, arg6, arg5);
        compute_stability_pool_interest<T0>(0, arg5, arg4, arg6, arg1, arg9);
        assert_not_shutdown<T0>(arg4);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::get_vault_id_from_admin(arg2);
        let (v1, _) = get_oracle_price<T0>(0, arg4, arg7, arg8, arg1);
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg3, v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v4, v5, v6, _) = accrue_interest_and_redistribute<T0>(v3, arg1, arg4);
        assert_min_debt_allowed<T0>(v4, arg4);
        let v8 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg4);
        let v9 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v5, v8), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(arg0, v8));
        let v10 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v5, v8), v9);
        assert!(is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(v10, v1), v4, arg4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe_v2<T0>(v1, v5, v4, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v10, v8), v4, arg4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
        let v11 = recompute_and_apply_vault_stake<T0>(v6, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v10), v3, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v5), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v10, v8)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v9, v8)), arg9), 0x2::tx_context::sender(arg9));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_withdraw_collateral_event(v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), arg0, v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v10, v8), v4, v6, v11);
    }

    public entry fun withdraw_collateral_v2<T0>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg9: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg10: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdraw_collateral_v3<T0>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg9: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg10: &mut 0x2::tx_context::TxContext) {
        assert_context_basic<T0>(arg4, arg3, arg6, arg5);
        compute_stability_pool_interest_v3<T0>(0, arg5, arg4, arg6, arg9, arg1, arg10);
        assert_not_shutdown<T0>(arg4);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::get_vault_id_from_admin(arg2);
        let (v1, _) = get_oracle_price<T0>(0, arg4, arg7, arg8, arg1);
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg3, v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v4, v5, v6, _) = accrue_interest_and_redistribute<T0>(v3, arg1, arg4);
        assert_min_debt_allowed<T0>(v4, arg4);
        let v8 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_token_decimal_v2<T0>(arg4);
        let v9 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v5, v8), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(arg0, v8));
        let v10 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v5, v8), v9);
        assert!(is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(v10, v1), v4, arg4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe_v2<T0>(v1, v5, v4, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v10, v8), v4, arg4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
        let v11 = recompute_and_apply_vault_stake<T0>(v6, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v10), v3, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v5), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v10, v8)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v9, v8)), arg10), 0x2::tx_context::sender(arg10));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_withdraw_collateral_event(v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), arg0, v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(v10, v8), v4, v6, v11);
    }

    // decompiled from Move bytecode v6
}

