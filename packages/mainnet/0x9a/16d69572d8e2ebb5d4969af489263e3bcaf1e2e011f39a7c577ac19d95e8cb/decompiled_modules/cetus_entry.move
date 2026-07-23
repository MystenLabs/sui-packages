module 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_entry {
    struct CetusLegAuth has drop {
        dummy_field: bool,
    }

    public fun admin_force_refresh_cetus<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg4: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = authorize(arg0);
        let v1 = view_cetus_underlying<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::assert_admin_force_refresh_deviation<0x2::sui::SUI, T1>(arg1, v1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::force_sync_protocol_balance<0x2::sui::SUI, T1, CetusLegAuth>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), v1, arg5, arg6, &v0);
    }

    public fun admin_recall_cetus_to_idle<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::AdminRecallReceipt<0x2::sui::SUI>, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = authorize(arg0);
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_position::validate_exit_objects<0x2::sui::SUI, T1, T0>(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS();
        let v2 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::instant_unstake_fee_rate<0x2::sui::SUI, T1>(arg1, arg11);
        let v3 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_position::cached_exit_lp<0x2::sui::SUI, T1, T0>(arg1, (arg3 as u128));
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::begin_recall_withdraw_leg<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg2, arg1, v1, v3, &v0);
        let (v6, v7, v8, v9) = withdraw_underlying<T0>(v4, v3, 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::withdraw_slippage_bps<0x2::sui::SUI, T1>(arg1), v2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v10 = v8;
        let v11 = v7;
        let v12 = v6;
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_position::assert_strict_normalization(v9, (0x2::balance::value<0x2::sui::SUI>(&v12) as u128) + 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_sui_oracle::sui_composition_value(arg11, 0, 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v10), v2));
        if (0x2::balance::value<T0>(&v11) > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::store_recall_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg2, arg1, v1, v11, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v11);
        };
        let v13 = &mut v12;
        settle_withdraw_hasui_dust<T1>(arg1, v10, v13, arg11, arg12, &v0, arg14);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin_recall::finish_recall_withdraw_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg2, arg1, v5, v12, &v0);
    }

    public(friend) fun authorize(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal) : 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusLegAuth> {
        let v0 = CetusLegAuth{dummy_field: false};
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::authorize_ext<CetusLegAuth>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), 1, &v0)
    }

    public fun deposit_to_cetus<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::DepositReceipt<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg6: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg8: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg9: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg12: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_validation::validate_cetus_config<T1>(arg1, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg6), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg8), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg9), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg10), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg11), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg12));
        let v1 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::instant_unstake_fee_rate<0x2::sui::SUI, T1>(arg1, arg12);
        let v2 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_sui_oracle::sui_lp_nav<T0>(arg6, arg11, arg12, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS()), v1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::sync_for_deposit<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg2, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), v2, arg14, &v0);
        let v3 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::resolve_requested_deposit_amount<0x2::sui::SUI>(arg2, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), arg3);
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::begin_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg2, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), v3, &v0);
        let v6 = v4;
        let (v7, v8, v9) = deposit_underlying<T0>(v6, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v10 = v9;
        let v11 = v8;
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::store_deposit_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg2, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), v7, &v0);
        let v12 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v10);
        let v13 = if (v12 > 0) {
            (0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::get_net_sui_by_hasui(arg12, v12) as u128)
        } else {
            0
        };
        let v14 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::consumed_input(0x2::balance::value<0x2::sui::SUI>(&v6), 0x2::balance::value<0x2::sui::SUI>(&v11));
        let v15 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::accounted_deposit_value(v14, v2, 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_sui_oracle::sui_lp_nav<T0>(arg6, arg11, arg12, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS()), v1), v13);
        let v16 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::max_accounted_value_gap_for_input<0x2::sui::SUI, T1>(arg1, v14);
        merge_and_flush_hasui_to_idle<T1>(arg1, v10, arg12, arg13, &v0, arg15);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::finish_deposit_leg_accounted_with_leftover<0x2::sui::SUI, T1, CetusLegAuth>(arg2, arg1, v5, v11, v14, v15, v16, &v0);
        if (v13 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::record_deposit_leg_side_deduction<0x2::sui::SUI, T1, CetusLegAuth>(arg2, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), v13, (v15 as u128), &v0);
        };
    }

    public(friend) fun deposit_underlying<T0>(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg3: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg9: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0);
        let v1 = if (arg1 >= v0) {
            v0
        } else {
            arg1
        };
        let v2 = v0 - v1;
        assert!(v1 > 0, 4);
        assert!(v2 >= 1000000000, 1);
        let v3 = 0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg12);
        let v4 = 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::stake_sui_for_hasui(arg10, arg9, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0, v2), arg12), @0x0, arg12)), arg12);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v6 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v4);
        assert!(v6 >= estimate_required_hasui_for_lp<T0>(arg3, arg8, v5), 5);
        let (v7, v8, v9) = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::deposit<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, v4, v3, v6, v5, false, arg11, arg12);
        let v10 = v9;
        let v11 = 0x2::coin::into_balance<0x2::sui::SUI>(v8);
        let v12 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v10);
        let v13 = if (v12 >= 1000000000) {
            0x2::balance::join<0x2::sui::SUI>(&mut v11, 0x2::coin::into_balance<0x2::sui::SUI>(0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::unstake_hasui_instant_coin(arg10, arg9, v10, arg12)));
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        } else if (v12 > 0) {
            0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v10)
        } else {
            0x2::coin::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v10);
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        };
        (0x2::coin::into_balance<T0>(v7), v11, v13)
    }

    fun estimate_required_hasui_for_lp<T0>(arg0: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::total_token_amount<T0>(arg0);
        if (v0 == 0) {
            return 0
        };
        let (v1, v2) = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::get_position_amounts<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI, T0>(arg0, arg1, v0);
        if (v2 == 0 || v1 == 0) {
            return 0
        };
        let v3 = (arg2 as u128) * (v1 as u128);
        let v4 = (v2 as u128);
        let v5 = if (v3 % v4 != 0) {
            v3 / v4 + 1
        } else {
            v3 / v4
        };
        let v6 = 18446744073709551615;
        if (v5 >= v6) {
            (v6 as u64)
        } else {
            (v5 as u64)
        }
    }

    public fun flush_accumulated_hasui<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg4: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_keeper<0x2::sui::SUI, T1>(arg1, 0x2::tx_context::sender(arg6));
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_no_active_operation_for_maintenance<0x2::sui::SUI, T1>(arg1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_validation::validate_cetus_core<T1>(arg1, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg3), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg4));
        let (v1, v2) = take_accumulated_and_flush_to_idle<T1>(arg1, arg4, arg5, &v0, arg6);
        put_back_accumulated_or_destroy<T1>(arg1, v1, v2, &v0);
    }

    fun merge_and_flush_hasui_to_idle<T0>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusLegAuth>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS();
        let (v1, _) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::take_accumulated_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, arg4);
        let v3 = v1;
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v3, arg1);
        let v4 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v3);
        if (v4 >= 1000000000) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::deposit_to_idle<0x2::sui::SUI, T0, CetusLegAuth>(arg0, v0, 0x2::coin::into_balance<0x2::sui::SUI>(0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::unstake_hasui_instant_coin(arg3, arg2, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v3, arg5), arg5)), arg4);
        } else if (v4 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::accumulate_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, v3, (0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::get_net_sui_by_hasui(arg2, v4) as u128), arg4);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v3);
        };
    }

    public(friend) fun migration_witness() : CetusLegAuth {
        CetusLegAuth{dummy_field: false}
    }

    public(friend) fun package_version() : u64 {
        1
    }

    fun put_back_accumulated_or_destroy<T0>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: u128, arg3: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusLegAuth>) {
        if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1) > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::accumulate_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), arg1, arg2, arg3);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1);
        };
    }

    public fun rebalance_deposit_to_cetus<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg6: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg8: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg9: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg12: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_validation::validate_cetus_config<T1>(arg1, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg6), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg8), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg9), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg10), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg11), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg12));
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS();
        let v2 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::resolve_requested_rebalance_deposit_amount<0x2::sui::SUI>(arg2, v1, arg3);
        if (v2 == 0) {
            return
        };
        let v3 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::instant_unstake_fee_rate<0x2::sui::SUI, T1>(arg1, arg12);
        let v4 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_sui_oracle::sui_lp_nav<T0>(arg6, arg11, arg12, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg1, v1), v3);
        let (v5, v6) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::begin_rebalance_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg2, arg1, v1, v2, &v0);
        let v7 = v5;
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        if (v8 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v7);
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::finish_rebalance_deposit_leg_accounted_with_leftover<0x2::sui::SUI, T1, CetusLegAuth>(arg2, arg1, v6, 0x2::balance::zero<0x2::sui::SUI>(), 0, 0, 0, &v0);
            return
        };
        let (v9, v10, v11) = deposit_underlying<T0>(v7, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v12 = v11;
        let v13 = v10;
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::store_rebalance_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg2, arg1, v1, v9, &v0);
        let v14 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v12);
        let v15 = if (v14 > 0) {
            (0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::get_net_sui_by_hasui(arg12, v14) as u128)
        } else {
            0
        };
        let v16 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::consumed_input(v8, 0x2::balance::value<0x2::sui::SUI>(&v13));
        let v17 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::accounted_deposit_value(v16, v4, 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_sui_oracle::sui_lp_nav<T0>(arg6, arg11, arg12, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg1, v1), v3), v15);
        let v18 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::max_accounted_value_gap_for_input<0x2::sui::SUI, T1>(arg1, v16);
        merge_and_flush_hasui_to_idle<T1>(arg1, v12, arg12, arg13, &v0, arg15);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::finish_rebalance_deposit_leg_accounted_with_leftover<0x2::sui::SUI, T1, CetusLegAuth>(arg2, arg1, v6, v13, v16, v17, v18, &v0);
        if (v15 > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::record_leg_side_deduction<0x2::sui::SUI, T1, CetusLegAuth>(arg1, v1, v15, (v17 as u128), &v0);
        };
    }

    public fun rebalance_withdraw_from_cetus<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::RebalanceReceipt<0x2::sui::SUI>, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = authorize(arg0);
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_position::validate_exit_objects<0x2::sui::SUI, T1, T0>(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS();
        let v2 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::instant_unstake_fee_rate<0x2::sui::SUI, T1>(arg1, arg11);
        let v3 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_position::cached_exit_lp<0x2::sui::SUI, T1, T0>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::resolve_requested_rebalance_withdraw_amount<0x2::sui::SUI>(arg2, v1, (arg3 as u128)));
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::begin_rebalance_withdraw_leg<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg2, arg1, v1, v3, &v0);
        let (v6, v7, v8, v9) = withdraw_underlying<T0>(v4, v3, 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::withdraw_slippage_bps<0x2::sui::SUI, T1>(arg1), v2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v10 = v8;
        let v11 = v7;
        let v12 = v6;
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_position::assert_strict_normalization(v9, (0x2::balance::value<0x2::sui::SUI>(&v12) as u128) + 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_sui_oracle::sui_composition_value(arg11, 0, 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v10), v2));
        if (0x2::balance::value<T0>(&v11) > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::store_rebalance_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg2, arg1, v1, v11, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v11);
        };
        let v13 = &mut v12;
        settle_withdraw_hasui_dust<T1>(arg1, v10, v13, arg11, arg12, &v0, arg14);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_rebalance::finish_rebalance_withdraw_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg2, arg1, v5, v12, &v0);
    }

    public fun refresh_cetus<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg4: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::assert_refresh_gate<0x2::sui::SUI, T1>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), arg5, arg6);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::sync_protocol_balance_by_auth<0x2::sui::SUI, T1, CetusLegAuth>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), view_cetus_underlying<T0, T1>(arg0, arg1, arg2, arg3, arg4), arg5, &v0);
    }

    fun settle_withdraw_hasui_dust<T0>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusLegAuth>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS();
        let v1 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1);
        let (v2, _) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::take_accumulated_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, arg5);
        let v4 = v2;
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v4, arg1);
        let v5 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v4);
        if (v5 >= 1000000000) {
            let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::unstake_hasui_instant_coin(arg4, arg3, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v4, arg6), arg6));
            let v7 = if (v5 == 0) {
                0
            } else {
                (((0x2::balance::value<0x2::sui::SUI>(&v6) as u128) * (v1 as u128) / (v5 as u128)) as u64)
            };
            if (v7 > 0) {
                0x2::balance::join<0x2::sui::SUI>(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v7));
            };
            if (0x2::balance::value<0x2::sui::SUI>(&v6) > 0) {
                0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::deposit_to_idle<0x2::sui::SUI, T0, CetusLegAuth>(arg0, v0, v6, arg5);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
            };
        } else if (v5 > 0) {
            if (v1 > 0) {
                0x2::balance::join<0x2::sui::SUI>(arg2, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::compensate_from_idle<0x2::sui::SUI, T0, CetusLegAuth>(arg0, v0, 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::get_net_sui_by_hasui(arg3, v1), arg5));
            };
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::accumulate_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, v4, (0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::get_net_sui_by_hasui(arg3, v5) as u128), arg5);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v4);
        };
    }

    fun take_accumulated_and_flush_to_idle<T0>(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::ExtAuthGuard<CetusLegAuth>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, u128) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS();
        let (v1, v2) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::take_accumulated_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, arg3);
        let v3 = v1;
        if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v3) >= 1000000000) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::deposit_to_idle<0x2::sui::SUI, T0, CetusLegAuth>(arg0, v0, 0x2::coin::into_balance<0x2::sui::SUI>(0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::unstake_hasui_instant_coin(arg2, arg1, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v3, arg4), arg4)), arg3);
            (0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(), 0)
        } else {
            (v3, v2)
        }
    }

    public fun view_cetus_underlying<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg4: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u128 {
        authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_validation::validate_cetus_core<T1>(arg1, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg3), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg4));
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_sui_oracle::sui_lp_nav<T0>(arg2, arg3, arg4, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS()), 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::instant_unstake_fee_rate<0x2::sui::SUI, T1>(arg1, arg4))
    }

    public fun withdraw_from_cetus<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg2: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::WithdrawReceipt<0x2::sui::SUI, T1>, arg3: u128, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = authorize(arg0);
        assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::withdraw_receipt_max_loss_bps<0x2::sui::SUI, T1>(arg2) == 0, 7);
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_position::validate_exit_objects<0x2::sui::SUI, T1, T0>(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::instant_unstake_fee_rate<0x2::sui::SUI, T1>(arg1, arg11);
        let v2 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::resolve_requested_withdraw_assets<0x2::sui::SUI, T1>(arg2, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), arg3);
        if (v2 == 0) {
            return
        };
        let v3 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_position::cached_exit_lp<0x2::sui::SUI, T1, T0>(arg1, v2);
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::begin_withdraw_leg<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg2, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), v3, &v0);
        let (v6, v7, v8, v9) = withdraw_underlying<T0>(v4, v3, 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common::withdraw_slippage_bps<0x2::sui::SUI, T1>(arg1), v1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v10 = v8;
        let v11 = v7;
        let v12 = v6;
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_position::assert_strict_normalization(v9, (0x2::balance::value<0x2::sui::SUI>(&v12) as u128) + 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_sui_oracle::sui_composition_value(arg11, 0, 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v10), v1));
        if (0x2::balance::value<T0>(&v11) > 0) {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::store_withdraw_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg2, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), v11, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v11);
        };
        let v13 = &mut v12;
        settle_withdraw_hasui_dust<T1>(arg1, v10, v13, arg11, arg12, &v0, arg14);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_user_entry::finish_withdraw_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg2, arg1, v5, v12, &v0);
    }

    public(friend) fun withdraw_underlying<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, u128) {
        let v0 = 0x2::coin::from_balance<T0>(arg0, arg14);
        let (v1, v2) = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::get_position_amounts<T0>(arg5, arg10, arg1);
        let (v3, v4) = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::withdraw_min_amounts(v1, v2, arg2);
        let (v5, v6) = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::withdraw<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, &mut v0, arg1, v4, v3, arg13, arg14);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v7);
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(v8);
        let v11 = if (v9 >= 1000000000) {
            0x2::balance::join<0x2::sui::SUI>(&mut v10, 0x2::coin::into_balance<0x2::sui::SUI>(0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::unstake_hasui_instant_coin(arg12, arg11, v7, arg14)));
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        } else if (v9 > 0) {
            0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v7)
        } else {
            0x2::coin::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v7);
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        };
        (v10, 0x2::coin::into_balance<T0>(v0), v11, 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_sui_oracle::sui_composition_value(arg11, 0x2::coin::value<0x2::sui::SUI>(&v8), 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v7), arg3))
    }

    // decompiled from Move bytecode v7
}

