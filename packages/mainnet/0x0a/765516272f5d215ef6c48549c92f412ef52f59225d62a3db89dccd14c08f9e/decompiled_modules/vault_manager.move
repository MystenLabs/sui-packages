module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_manager {
    fun accrue_interest_and_redistribute<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : (u64, u64, u256, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, _) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_info<T0>(arg0);
        let (v8, v9) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::compute_collateral_debt_rewards<T0>(v2, v3, v4, arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::add_balance_vault_collateral<T0>(arg0, v8);
        let v10 = v0 + 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_interest_debt<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_interest_rate_period<T0>(v6, arg1, arg2), arg0) + v9;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(arg0, v10, arg1);
        let v11 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(arg0)));
        let v12 = recompute_and_apply_vault_stake<T0>(v2, v11, arg0, arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg2, 0x1::option::some<u64>(v1), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(arg0)), 0x1::option::some<u64>(v0), 0x1::option::some<u64>(v10), 0x1::option::some<u64>(v5), 0x1::option::some<u64>(v5));
        (v10, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(arg0), v12, v5)
    }

    public entry fun add_collateral<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_collateral_address<T0>();
        assert_context_basic<T0>(arg4, arg3, arg6, arg5);
        compute_stability_pool_interest<T0>(0, arg5, arg4, arg6, arg2, arg7);
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg3, arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v1, v2, v3, _) = accrue_interest_and_redistribute<T0>(v0, arg2, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::add_balance_vault_collateral<T0>(v0, 0x2::coin::into_balance<T0>(arg0));
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v0);
        let v6 = recompute_and_apply_vault_stake<T0>(v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v5)), v0, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v2), 0x1::option::some<u64>(v5), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_add_collateral_event(arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), 0x2::coin::value<T0>(&arg0), v2, v5, v1, v3, v6);
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
        assert!(is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v5), v1), v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe<T0>(v1, v5, v4, v5, v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v3, v10, arg3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_interest_rate<T0>(v3, arg2, arg3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::reinsert_node<T0>(arg6, v0, arg3, arg2, arg0, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg6, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(v4), 0x1::option::some<u64>(v10), 0x1::option::some<u64>(v7), 0x1::option::some<u64>(arg2));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_interest_update_event(v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg6), v5, v4, v10, v7, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    fun apply_coll_penalty_and_surplus(arg0: u64, arg1: u64, arg2: u64, arg3: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal) : (u64, u64) {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::BASIS_POINTS() + arg2)), arg3));
        if (arg0 > v0) {
            (v0, arg0 - v0)
        } else {
            (arg0, 0)
        }
    }

    fun assert_collateral_address<T0>() {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        assert!(0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1)) == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::SUI_TOKEN_ADDRESS(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EAddressTokenMismatch());
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
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::ge(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_debt_allowed<T0>(arg1))), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EMinDebtTooLow());
    }

    fun assert_not_shutdown<T0>(arg0: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) {
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_shutdown_timestamp<T0>(arg0) == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EShutdownActive());
    }

    fun assert_tcr_is_safe<T0>(arg0: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) {
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe<T0>(arg0, arg1, arg2, arg3, arg4, arg5), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
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
        assert!(is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v7), v3), v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe<T0>(v3, v7, v6, v7, v10, arg6), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg6, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(v6), 0x1::option::some<u64>(v10), 0x1::option::some<u64>(v9), 0x1::option::some<u64>(v9));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_fee_vault(arg7, v1, arg11);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_transfer(arg7, arg0, 0x2::tx_context::sender(arg11), arg11);
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

    fun compute_offset_and_redistribution<T0>(arg0: u64, arg1: u64, arg2: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg3: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg4: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : (u64, u64, u64, u64, u64) {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg0), arg2);
        let v1 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg1), v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg0));
        let (v2, v3) = apply_coll_penalty_and_surplus(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_liquidation_fee_bps<T0>(arg4), arg3);
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg0), v0);
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg1), v1);
        let v6 = 0;
        let v7 = 0;
        if (0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v4) > 0 && 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v5) > 0) {
            let (v8, v9) = apply_coll_penalty_and_surplus(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v5), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_liquidation_fee_redistribution_bps<T0>(arg4), arg3);
            v7 = v9;
            v6 = v8;
        };
        (0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v0), v2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v4), v6, v3 + v7)
    }

    fun compute_stability_pool_interest<T0>(arg0: u64, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        distribute_yield_to_stability_pool<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry_interest_and_return<T0>(arg2, arg4) + arg0, arg1, arg3, arg5);
    }

    public entry fun create_vault<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg8: &0x2::clock::Clock, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg11: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_collateral_address<T0>();
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
        let (v6, v7, v8) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_and_get_new_stake<T0>(0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v0)), arg3);
        let (v9, v10) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::create_new_vault<T0>(0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3), arg1, 0x2::clock::timestamp_ms(arg8), arg0, v5, v6, v7, v8, arg4, arg12);
        let v11 = v10;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::add_node<T0>(arg3, v9, arg8, arg0, arg5, arg6, arg12);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg3, 0x1::option::some<u64>(0), 0x1::option::some<u64>(v0), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v5), 0x1::option::some<u64>(0), 0x1::option::some<u64>(arg0));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_create_vault_event(v9, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3), 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin>(&v11), arg0, v0, arg2, v5, v6, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::transfer::public_transfer<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin>(v11, 0x2::tx_context::sender(arg12));
        v9
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
            return (v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg0), v5))
        };
        let (v6, _, v8) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::oracles::get_switchboard_price_and_identifier(arg3, arg4);
        let v9 = v6;
        assert!(v8 == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_price_feed_id<T0>(arg1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::ORACLE_TYPE_SWITCHBOARD()), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EPriceFeedID());
        assert!(0x1::option::is_some<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal>(&v9), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EOracleIssue());
        let v10 = *0x1::option::borrow<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal>(&v9);
        (v10, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg0), v10))
    }

    fun get_protocol_borrow_fee_amount<T0>(arg0: u64, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : u64 {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_protocol_borrow_fee_bps<T0>(arg1))))
    }

    fun intern_close_vault_by_liquidation<T0>(arg0: 0x2::object::ID, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : 0x2::balance::Balance<T0> {
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault_active_counter<T0>(arg1) > 1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EOnlyOneVaultLeft());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::remove_node<T0>(arg2, arg0);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::delete_vault<T0>(arg0, arg1)
    }

    fun is_vault_above_icr(arg0: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg1: u64) : bool {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::BASIS_POINTS());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::ge(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(arg0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg1)), v0), v0)
    }

    fun is_vault_above_mcr<T0>(arg0: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg1: u64, arg2: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>) : bool {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::ge(arg0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_collateral_threshold_bps<T0>(arg2))))
    }

    fun liquidate_single_vault<T0>(arg0: 0x2::object::ID, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::VaultStore<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool::SurplusPool<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::StabilityPool<T0>, arg6: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg7: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault<T0>(arg1, arg0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4));
        let (v1, v2, v3, v4) = accrue_interest_and_redistribute<T0>(v0, arg8, arg4);
        if (is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v2), arg7), v1, arg4)) {
            return 0
        };
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::get_vault_active_counter<T0>(arg1) > 1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EOnlyOneVaultLeft());
        let (_, _, _) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_and_get_new_stake<T0>(v3, 0, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v2), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v1), 0x1::option::some<u64>(0), 0x1::option::some<u64>(v4), 0x1::option::some<u64>(0));
        let (v8, v9, v10, v11, _) = compute_offset_and_redistribution<T0>(v1, v2, *arg6, arg7, arg4);
        if (v8 > 0) {
            *arg6 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(*arg6, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v8));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::offset<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v8)), 0x2::coin::from_balance<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v0, v9), arg9), arg5, arg3, arg9);
        };
        if (v10 > 0) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::redistribute_debt_and_collateral<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v10)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v0, v11), arg4);
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
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v3), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::MIN_TO_LEAVE_IN_SP()), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v3)));
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
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v1);
        let v6 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0)));
        let v7 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v5, v6));
        assert_min_debt_allowed<T0>(v7, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v0, v7, arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(v1), 0x1::option::some<u64>(v7), 0x1::option::some<u64>(v4), 0x1::option::some<u64>(v4));
        let v8 = 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg0);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg5, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v8, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v6)), arg7));
        if (0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v8, arg7), 0x2::tx_context::sender(arg7));
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
            let v12 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v9), v1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v8)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v4))));
            let v13 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v12), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::one(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_premium_redemption_bps<T0>(arg4)))), v1);
            if (0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v13) < v8) {
                v5 = v5 + 1;
                continue
            };
            0x2::balance::join<T0>(&mut v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v7, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v13)));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg3, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v4, v12), arg9));
            let v14 = v8 - v12;
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v7, v14, arg8);
            let v15 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v7)));
            let v16 = recompute_and_apply_vault_stake<T0>(v10, v15, v7, arg4);
            let v17 = v11;
            if (v14 < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_debt_allowed<T0>(arg4)) {
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::remove_node<T0>(arg4, v6);
                let (_, v19) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_max_interest_rate_bps<T0>(arg4);
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_interest_rate<T0>(v7, v19, arg8);
                v17 = v19;
            };
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v9), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v7)), 0x1::option::some<u64>(v8), 0x1::option::some<u64>(v14), 0x1::option::some<u64>(v11), 0x1::option::some<u64>(v17));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_urgent_redemption_event(v6, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v13), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v9), v13)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v7), v12, v8, v14, v10, v16, v11, v17);
            v5 = v5 + 1;
        };
        let v20 = v0 - 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v4);
        assert!(v20 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENoRedemptionHappened());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_redemption_rate_bps<T0>(v20, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::get_total_dori_total_supply(arg3), arg8, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v4, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg9), 0x2::tx_context::sender(arg9));
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
            let v18 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v15), v1);
            if (!is_vault_above_icr(v18, v14)) {
                if (0x1::option::is_some<0x2::object::ID>(&v8)) {
                    continue
                } else {
                    break
                };
            };
            let v19 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(v18, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v14)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v7))));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg2, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v7, v19), arg9));
            let v20 = v14 - v19;
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_debt<T0>(v13, v20, arg7);
            let v21 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v19), v1);
            let v22 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(v21, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(v4));
            let v23 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v21, v22);
            0x2::balance::join<T0>(&mut v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v13, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v23)));
            0x2::balance::join<T0>(&mut v6, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v13, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v22)));
            let v24 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v13)));
            let v25 = recompute_and_apply_vault_stake<T0>(v16, v24, v13, arg3);
            let v26 = v17;
            if (v20 < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_debt_allowed<T0>(arg3)) {
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::remove_node<T0>(arg3, v12);
                let (_, v28) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_min_max_interest_rate_bps<T0>(arg3);
                0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::update_vault_interest_rate<T0>(v13, v28, arg7);
                v26 = v28;
            };
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg3, 0x1::option::some<u64>(v15), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v13)), 0x1::option::some<u64>(v14), 0x1::option::some<u64>(v20), 0x1::option::some<u64>(v17), 0x1::option::some<u64>(v26));
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_redemption_event(v12, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(v22, v23)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v15), v22), v23)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_value<T0>(v13), v19, v14, v20, v16, v25, v17, v26);
            if (0x1::option::is_some<0x2::object::ID>(&v8)) {
            } else {
                break
            };
        };
        let v29 = v0 - 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v7);
        assert!(v29 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENoRedemptionHappened());
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_redemption_rate_bps<T0>(v29, v3, arg7, arg3);
        if (0x2::balance::value<T0>(&v6) > 0) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::add_fee_vault_balance<T0>(v6, arg3);
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v7, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg9), 0x2::tx_context::sender(arg9));
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
        let v8 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v5), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg0));
        let v9 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v5), v8);
        assert!(is_vault_above_mcr<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(v9, v1), v4, arg4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ECollateralTooLow());
        assert!(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::is_tcr_safe<T0>(v1, v5, v4, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v9), v4, arg4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ETotalCollateralRatioCritic());
        let v10 = recompute_and_apply_vault_stake<T0>(v6, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v9), v3, arg4);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry<T0>(arg4, 0x1::option::some<u64>(v5), 0x1::option::some<u64>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v9)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::get_vault_collateral_balance<T0>(v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v8)), arg9), 0x2::tx_context::sender(arg9));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_withdraw_collateral_event(v0, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg4), arg0, v5, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v9), v4, v6, v10);
    }

    // decompiled from Move bytecode v6
}

