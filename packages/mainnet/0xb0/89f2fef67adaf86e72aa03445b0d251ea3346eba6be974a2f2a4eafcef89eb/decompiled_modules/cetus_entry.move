module 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_entry {
    struct CetusLegAuth has drop {
        dummy_field: bool,
    }

    public fun admin_recall_cetus_to_idle<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::AdminRecallReceipt<0x2::sui::SUI>, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = CetusLegAuth{dummy_field: false};
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS();
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, v1);
        let v3 = 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::calculate_lp_to_withdraw(v2, 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg4, arg9, arg10, v2, instant_unstake_fee_rate<T1>(arg0, arg10)), (arg2 as u128));
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::begin_recall_withdraw_leg<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, v1, v3, &v0);
        let (v6, v7, v8) = withdraw_underlying<T0>(v4, v3, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v9 = v7;
        if (0x2::balance::value<T0>(&v9) > 0) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::store_recall_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, v1, v9, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v9);
        };
        merge_and_flush_hasui_to_idle<T1>(arg0, v8, arg10, arg11, &v0, arg13);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::finish_recall_withdraw_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v5, v6, &v0);
    }

    public fun deposit_to_cetus<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::DepositReceipt<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg5), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg4), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg9), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg10), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg11));
        let v0 = CetusLegAuth{dummy_field: false};
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_for_deposit<0x2::sui::SUI, T1, CetusLegAuth>(arg0, arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg5, arg10, arg11, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS()), instant_unstake_fee_rate<T1>(arg0, arg11)), arg13, &v0);
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::resolve_requested_deposit_amount<0x2::sui::SUI>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
        if (v1 == 0) {
            return
        };
        let (v2, v3) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::begin_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), v1, &v0);
        let (v4, v5, v6) = deposit_underlying<T0>(v2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::store_deposit_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), v4, &v0);
        merge_and_flush_hasui_to_idle<T1>(arg0, v6, arg11, arg12, &v0, arg14);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::finish_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v3, v5, &v0);
    }

    public(friend) fun deposit_underlying<T0>(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg3: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg9: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0);
        let v1 = if (arg1 >= v0) {
            v0
        } else {
            arg1
        };
        let v2 = v0 - v1;
        let v3 = if (v2 > 0) {
            assert!(v2 >= 1000000000, 1);
            0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::stake_sui_for_hasui(arg10, arg9, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0, v2), arg12), @0x0, arg12))
        } else {
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg12);
        let v5 = 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v3, arg12);
        let (v6, v7, v8) = 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::deposit<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, v5, v4, 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v5), 0x2::coin::value<0x2::sui::SUI>(&v4), false, arg11, arg12);
        let v9 = v8;
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(v7);
        let v11 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v9);
        let v12 = if (v11 >= 1000000000) {
            0x2::balance::join<0x2::sui::SUI>(&mut v10, 0x2::coin::into_balance<0x2::sui::SUI>(0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::unstake_hasui_instant_coin(arg10, arg9, v9, arg12)));
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        } else if (v11 > 0) {
            0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v9)
        } else {
            0x2::coin::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v9);
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        };
        (0x2::coin::into_balance<T0>(v6), v10, v12)
    }

    public fun flush_accumulated_hasui<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_cetus_core<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg2), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg3));
        let v0 = CetusLegAuth{dummy_field: false};
        let v1 = take_accumulated_and_flush_to_idle<T1>(arg0, arg3, arg4, &v0, arg5);
        put_back_accumulated_or_destroy<T1>(arg0, v1, &v0);
    }

    fun instant_unstake_fee_rate<T0>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_config<0x2::sui::SUI, T0>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::config_get_value(&v0, 0);
        if (0x1::option::is_some<u64>(&v1)) {
            let v3 = 0x1::option::destroy_some<u64>(v1);
            assert!(v3 < 10000000, 2);
            v3
        } else {
            0x1::option::destroy_none<u64>(v1);
            0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::instant_unstake_fee_rate(arg1)
        }
    }

    fun merge_and_flush_hasui_to_idle<T0>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &CetusLegAuth, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS();
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::take_accumulated_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, arg4);
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v1, arg1);
        let v2 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v1);
        if (v2 >= 1000000000) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::deposit_to_idle<0x2::sui::SUI, T0, CetusLegAuth>(arg0, v0, 0x2::coin::into_balance<0x2::sui::SUI>(0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::unstake_hasui_instant_coin(arg3, arg2, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v1, arg5), arg5)), arg4);
        } else if (v2 > 0) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::accumulate_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, v1, arg4);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v1);
        };
    }

    fun put_back_accumulated_or_destroy<T0>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &CetusLegAuth) {
        if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1) > 0) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::accumulate_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), arg1, arg2);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1);
        };
    }

    public fun rebalance_deposit_to_cetus<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::RebalanceReceipt<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg5), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg4), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg9), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg10), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg11));
        let v0 = CetusLegAuth{dummy_field: false};
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS();
        let (v2, v3) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::begin_rebalance_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v1, arg2, &v0);
        let v4 = v2;
        if (0x2::balance::value<0x2::sui::SUI>(&v4) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::finish_rebalance_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v3, 0x2::balance::zero<0x2::sui::SUI>(), &v0);
            return
        };
        let (v5, v6, v7) = deposit_underlying<T0>(v4, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::store_rebalance_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, v1, v5, &v0);
        merge_and_flush_hasui_to_idle<T1>(arg0, v7, arg11, arg12, &v0, arg14);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::finish_rebalance_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v3, v6, &v0);
    }

    public fun rebalance_withdraw_from_cetus<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::RebalanceReceipt<0x2::sui::SUI>, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = CetusLegAuth{dummy_field: false};
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS();
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, v1);
        let v3 = 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::calculate_lp_to_withdraw(v2, 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg4, arg9, arg10, v2, instant_unstake_fee_rate<T1>(arg0, arg10)), (arg2 as u128));
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::begin_rebalance_withdraw_leg<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, v1, v3, &v0);
        let (v6, v7, v8) = withdraw_underlying<T0>(v4, v3, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        if (0x2::balance::value<T0>(&v10) > 0) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::store_rebalance_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, v1, v10, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
        let v12 = take_accumulated_and_flush_to_idle<T1>(arg0, arg10, arg11, &v0, arg13);
        let v13 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v9);
        if (v13 >= 1000000000) {
            0x2::balance::join<0x2::sui::SUI>(&mut v11, 0x2::coin::into_balance<0x2::sui::SUI>(0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::unstake_hasui_instant_coin(arg11, arg10, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v9, arg13), arg13)));
            put_back_accumulated_or_destroy<T1>(arg0, v12, &v0);
        } else if (v13 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v11, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::compensate_from_idle<0x2::sui::SUI, T1, CetusLegAuth>(arg0, v1, 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::get_net_sui_by_hasui(arg10, v13), &v0));
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v12, v9);
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::accumulate_dust<0x2::sui::SUI, T1, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v1, v12, &v0);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v9);
            put_back_accumulated_or_destroy<T1>(arg0, v12, &v0);
        };
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::finish_rebalance_withdraw_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v5, v11, &v0);
    }

    public fun refresh_cetus<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_cetus_core<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg2), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg3));
        let v0 = CetusLegAuth{dummy_field: false};
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_protocol_balance_by_auth<0x2::sui::SUI, T1, CetusLegAuth>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg1, arg2, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS()), instant_unstake_fee_rate<T1>(arg0, arg3)), arg4, &v0);
    }

    public fun register_cetus_leg_auth<T0>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::register_protocol_leg_auth<0x2::sui::SUI, T0, CetusLegAuth>(arg1, arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS());
    }

    fun take_accumulated_and_flush_to_idle<T0>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &CetusLegAuth, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS();
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::take_accumulated_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, arg3);
        if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v1) >= 1000000000) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::deposit_to_idle<0x2::sui::SUI, T0, CetusLegAuth>(arg0, v0, 0x2::coin::into_balance<0x2::sui::SUI>(0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::unstake_hasui_instant_coin(arg2, arg1, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v1, arg4), arg4)), arg3);
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        } else {
            v1
        }
    }

    public fun withdraw_from_cetus<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::WithdrawReceipt<0x2::sui::SUI, T1>, arg2: u128, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = CetusLegAuth{dummy_field: false};
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS());
        let v2 = 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg4, arg9, arg10, v1, instant_unstake_fee_rate<T1>(arg0, arg10));
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_for_withdraw<0x2::sui::SUI, T1, CetusLegAuth>(arg0, arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), v2, arg12, &v0);
        let v3 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::resolve_requested_withdraw_assets<0x2::sui::SUI, T1>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
        if (v3 == 0) {
            return
        };
        let v4 = 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::calculate_lp_to_withdraw(v1, v2, v3);
        if (v4 == 0) {
            return
        };
        let (v5, v6) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::begin_withdraw_leg<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), v4, &v0);
        let (v7, v8, v9) = withdraw_underlying<T0>(v5, v4, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        if (0x2::balance::value<T0>(&v11) > 0) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::store_withdraw_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), v11, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v11);
        };
        let v13 = take_accumulated_and_flush_to_idle<T1>(arg0, arg10, arg11, &v0, arg13);
        let v14 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v10);
        if (v14 >= 1000000000) {
            0x2::balance::join<0x2::sui::SUI>(&mut v12, 0x2::coin::into_balance<0x2::sui::SUI>(0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::unstake_hasui_instant_coin(arg11, arg10, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v10, arg13), arg13)));
            put_back_accumulated_or_destroy<T1>(arg0, v13, &v0);
        } else if (v14 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v12, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::compensate_from_idle<0x2::sui::SUI, T1, CetusLegAuth>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::get_net_sui_by_hasui(arg10, v14), &v0));
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v13, v10);
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::accumulate_dust<0x2::sui::SUI, T1, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS(), v13, &v0);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v10);
            put_back_accumulated_or_destroy<T1>(arg0, v13, &v0);
        };
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::finish_withdraw_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v6, v12, &v0);
    }

    public(friend) fun withdraw_underlying<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg3: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg9: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        let v0 = 0x2::coin::from_balance<T0>(arg0, arg12);
        let (v1, v2) = 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::get_position_amounts<T0>(arg3, arg8, arg1);
        let (v3, v4) = 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::withdraw_min_amounts(v1, v2, 200);
        let (v5, v6) = 0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::withdraw<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, &mut v0, arg1, v4, v3, arg11, arg12);
        let v7 = v6;
        let v8 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v7);
        let v9 = 0x2::coin::into_balance<0x2::sui::SUI>(v5);
        let v10 = if (v8 >= 1000000000) {
            0x2::balance::join<0x2::sui::SUI>(&mut v9, 0x2::coin::into_balance<0x2::sui::SUI>(0xb089f2fef67adaf86e72aa03445b0d251ea3346eba6be974a2f2a4eafcef89eb::cetus_vault_adapter::unstake_hasui_instant_coin(arg10, arg9, v7, arg12)));
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        } else if (v8 > 0) {
            0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v7)
        } else {
            0x2::coin::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v7);
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        };
        (v9, 0x2::coin::into_balance<T0>(v0), v10)
    }

    // decompiled from Move bytecode v7
}

