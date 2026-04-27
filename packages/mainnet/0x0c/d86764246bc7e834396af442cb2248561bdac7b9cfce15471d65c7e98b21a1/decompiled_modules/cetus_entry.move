module 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_entry {
    struct CetusLegAuth has drop {
        dummy_field: bool,
    }

    public fun admin_recall_cetus_to_idle<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin_recall::AdminRecallReceipt<0x2::sui::SUI>, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = CetusLegAuth{dummy_field: false};
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS();
        let v2 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, v1);
        let v3 = 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::calculate_lp_to_withdraw(v2, 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg4, arg9, arg10, v2, instant_unstake_fee_rate<T1>(arg0, arg10)), (arg2 as u128));
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin_recall::begin_recall_withdraw_leg<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, v1, v3, &v0);
        let (v6, v7, v8) = withdraw_underlying<T0>(v4, v3, withdraw_slippage_bps<T1>(arg0), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v9 = v7;
        if (0x2::balance::value<T0>(&v9) > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin_recall::store_recall_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, v1, v9, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v9);
        };
        merge_and_flush_hasui_to_idle<T1>(arg0, v8, arg10, arg11, &v0, arg13);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin_recall::finish_recall_withdraw_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v5, v6, &v0);
    }

    public fun deposit_to_cetus<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::DepositReceipt<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg5), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg4), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg9), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg10), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg11));
        let v0 = CetusLegAuth{dummy_field: false};
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::sync_for_deposit<0x2::sui::SUI, T1, CetusLegAuth>(arg0, arg1, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg5, arg10, arg11, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS()), instant_unstake_fee_rate<T1>(arg0, arg11)), arg13, &v0);
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::resolve_requested_deposit_amount<0x2::sui::SUI>(arg1, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
        if (v1 == 0) {
            return
        };
        let (v2, v3) = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::begin_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), v1, &v0);
        let (v4, v5, v6) = deposit_underlying<T0>(v2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v7 = v6;
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::store_deposit_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), v4, &v0);
        let v8 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v7);
        let v9 = if (v8 > 0) {
            (0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_net_sui_by_hasui(arg11, v8) as u128)
        } else {
            0
        };
        merge_and_flush_hasui_to_idle<T1>(arg0, v7, arg11, arg12, &v0, arg14);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::finish_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v3, v5, &v0);
        if (v9 > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_leg_side_deduction<0x2::sui::SUI, T1, CetusLegAuth>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), v9, &v0);
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
        let v4 = 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::stake_sui_for_hasui(arg10, arg9, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0, v2), arg12), @0x0, arg12)), arg12);
        let (v5, v6, v7) = 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::deposit<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, v4, v3, 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v4), 0x2::coin::value<0x2::sui::SUI>(&v3), false, arg11, arg12);
        let v8 = v7;
        let v9 = 0x2::coin::into_balance<0x2::sui::SUI>(v6);
        let v10 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v8);
        let v11 = if (v10 >= 1000000000) {
            0x2::balance::join<0x2::sui::SUI>(&mut v9, 0x2::coin::into_balance<0x2::sui::SUI>(0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::unstake_hasui_instant_coin(arg10, arg9, v8, arg12)));
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        } else if (v10 > 0) {
            0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v8)
        } else {
            0x2::coin::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v8);
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        };
        (0x2::coin::into_balance<T0>(v5), v9, v11)
    }

    public fun flush_accumulated_hasui<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_validation::validate_cetus_core<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg2), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg3));
        let v0 = CetusLegAuth{dummy_field: false};
        let (v1, v2) = take_accumulated_and_flush_to_idle<T1>(arg0, arg3, arg4, &v0, arg5);
        put_back_accumulated_or_destroy<T1>(arg0, v1, v2, &v0);
    }

    fun instant_unstake_fee_rate<T0>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_protocol_config<0x2::sui::SUI, T0>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::config_get_value(&v0, 0);
        if (0x1::option::is_some<u64>(&v1)) {
            let v3 = 0x1::option::destroy_some<u64>(v1);
            assert!(v3 < 10000000, 2);
            v3
        } else {
            0x1::option::destroy_none<u64>(v1);
            0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::instant_unstake_fee_rate(arg1)
        }
    }

    fun merge_and_flush_hasui_to_idle<T0>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &CetusLegAuth, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS();
        let (v1, _) = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::take_accumulated_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, arg4);
        let v3 = v1;
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v3, arg1);
        let v4 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v3);
        if (v4 >= 1000000000) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::deposit_to_idle<0x2::sui::SUI, T0, CetusLegAuth>(arg0, v0, 0x2::coin::into_balance<0x2::sui::SUI>(0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::unstake_hasui_instant_coin(arg3, arg2, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v3, arg5), arg5)), arg4);
        } else if (v4 > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::accumulate_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, v3, (0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_net_sui_by_hasui(arg2, v4) as u128), arg4);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v3);
        };
    }

    fun put_back_accumulated_or_destroy<T0>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: u128, arg3: &CetusLegAuth) {
        if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1) > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::accumulate_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), arg1, arg2, arg3);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1);
        };
    }

    public fun rebalance_deposit_to_cetus<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_rebalance::RebalanceReceipt<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg5), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg4), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg9), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg10), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg11));
        let v0 = CetusLegAuth{dummy_field: false};
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS();
        let (v2, v3) = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_rebalance::begin_rebalance_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v1, arg2, &v0);
        let v4 = v2;
        if (0x2::balance::value<0x2::sui::SUI>(&v4) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_rebalance::finish_rebalance_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v3, 0x2::balance::zero<0x2::sui::SUI>(), &v0);
            return
        };
        let (v5, v6, v7) = deposit_underlying<T0>(v4, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v8 = v7;
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_rebalance::store_rebalance_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, v1, v5, &v0);
        let v9 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v8);
        let v10 = if (v9 > 0) {
            (0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_net_sui_by_hasui(arg11, v9) as u128)
        } else {
            0
        };
        merge_and_flush_hasui_to_idle<T1>(arg0, v8, arg11, arg12, &v0, arg14);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_rebalance::finish_rebalance_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v3, v6, &v0);
        if (v10 > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::record_leg_side_deduction<0x2::sui::SUI, T1, CetusLegAuth>(arg0, v1, v10, &v0);
        };
    }

    public fun rebalance_withdraw_from_cetus<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_rebalance::RebalanceReceipt<0x2::sui::SUI>, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = CetusLegAuth{dummy_field: false};
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS();
        let v2 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, v1);
        let v3 = 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::calculate_lp_to_withdraw(v2, 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg4, arg9, arg10, v2, instant_unstake_fee_rate<T1>(arg0, arg10)), (arg2 as u128));
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_rebalance::begin_rebalance_withdraw_leg<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, v1, v3, &v0);
        let (v6, v7, v8) = withdraw_underlying<T0>(v4, v3, withdraw_slippage_bps<T1>(arg0), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v9 = v7;
        let v10 = v6;
        if (0x2::balance::value<T0>(&v9) > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_rebalance::store_rebalance_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, v1, v9, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v9);
        };
        let v11 = &mut v10;
        settle_withdraw_hasui_dust<T1>(arg0, v8, v11, arg10, arg11, &v0, arg13);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_rebalance::finish_rebalance_withdraw_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v5, v10, &v0);
    }

    public fun refresh_cetus<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::assert_refresh_gate<0x2::sui::SUI, T1>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), arg4, arg5);
        let v0 = CetusLegAuth{dummy_field: false};
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::sync_protocol_balance_by_auth<0x2::sui::SUI, T1, CetusLegAuth>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), view_cetus_underlying<T0, T1>(arg0, arg1, arg2, arg3), arg4, &v0);
    }

    public fun register_cetus_leg_auth<T0>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::LLVGlobal, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg2: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::LLVPoolAdminCap) {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::assert_version(arg0);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::register_protocol_leg_auth<0x2::sui::SUI, T0, CetusLegAuth>(arg1, arg2, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS());
    }

    fun settle_withdraw_hasui_dust<T0>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &CetusLegAuth, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS();
        let v1 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1);
        let (v2, _) = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::take_accumulated_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, arg5);
        let v4 = v2;
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v4, arg1);
        let v5 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v4);
        if (v5 >= 1000000000) {
            let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::unstake_hasui_instant_coin(arg4, arg3, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v4, arg6), arg6));
            let v7 = if (v5 == 0) {
                0
            } else {
                (((0x2::balance::value<0x2::sui::SUI>(&v6) as u128) * (v1 as u128) / (v5 as u128)) as u64)
            };
            if (v7 > 0) {
                0x2::balance::join<0x2::sui::SUI>(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v7));
            };
            if (0x2::balance::value<0x2::sui::SUI>(&v6) > 0) {
                0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::deposit_to_idle<0x2::sui::SUI, T0, CetusLegAuth>(arg0, v0, v6, arg5);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
            };
        } else if (v5 > 0) {
            if (v1 > 0) {
                0x2::balance::join<0x2::sui::SUI>(arg2, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::compensate_from_idle<0x2::sui::SUI, T0, CetusLegAuth>(arg0, v0, 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_net_sui_by_hasui(arg3, v1), arg5));
            };
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::accumulate_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, v4, (0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_net_sui_by_hasui(arg3, v5) as u128), arg5);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v4);
        };
    }

    fun take_accumulated_and_flush_to_idle<T0>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &CetusLegAuth, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, u128) {
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS();
        let (v1, v2) = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::take_accumulated_dust<0x2::sui::SUI, T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, CetusLegAuth>(arg0, v0, arg3);
        let v3 = v1;
        if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v3) >= 1000000000) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::deposit_to_idle<0x2::sui::SUI, T0, CetusLegAuth>(arg0, v0, 0x2::coin::into_balance<0x2::sui::SUI>(0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::unstake_hasui_instant_coin(arg2, arg1, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v3, arg4), arg4)), arg3);
            (0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(), 0)
        } else {
            (v3, v2)
        }
    }

    public fun view_cetus_underlying<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u128 {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_validation::validate_cetus_core<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg2), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg3));
        0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg1, arg2, arg3, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS()), instant_unstake_fee_rate<T1>(arg0, arg3))
    }

    public fun withdraw_from_cetus<T0, T1>(arg0: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::WithdrawReceipt<0x2::sui::SUI, T1>, arg2: u128, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = CetusLegAuth{dummy_field: false};
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS());
        let v2 = 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg4, arg9, arg10, v1, instant_unstake_fee_rate<T1>(arg0, arg10));
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::sync_for_withdraw<0x2::sui::SUI, T1, CetusLegAuth>(arg0, arg1, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), v2, arg12, &v0);
        let v3 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::resolve_requested_withdraw_assets<0x2::sui::SUI, T1>(arg1, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
        if (v3 == 0) {
            return
        };
        let v4 = 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::calculate_lp_to_withdraw(v1, v2, v3);
        if (v4 == 0) {
            return
        };
        let (v5, v6) = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::begin_withdraw_leg<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), v4, &v0);
        let (v7, v8, v9) = withdraw_underlying<T0>(v5, v4, withdraw_slippage_bps<T1>(arg0), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v10 = v8;
        let v11 = v7;
        if (0x2::balance::value<T0>(&v10) > 0) {
            0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::store_withdraw_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS(), v10, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
        let v12 = &mut v11;
        settle_withdraw_hasui_dust<T1>(arg0, v9, v12, arg10, arg11, &v0, arg13);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_user_entry::finish_withdraw_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v6, v11, &v0);
    }

    fun withdraw_slippage_bps<T0>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<0x2::sui::SUI, T0>) : u64 {
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::get_protocol_config<0x2::sui::SUI, T0>(arg0, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::config_get_value(&v0, 1);
        if (0x1::option::is_some<u64>(&v1)) {
            let v3 = 0x1::option::destroy_some<u64>(v1);
            assert!(v3 <= 10000, 3);
            v3
        } else {
            0x1::option::destroy_none<u64>(v1);
            200
        }
    }

    public(friend) fun withdraw_underlying<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        let v0 = 0x2::coin::from_balance<T0>(arg0, arg13);
        let (v1, v2) = 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::get_position_amounts<T0>(arg4, arg9, arg1);
        let (v3, v4) = 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::withdraw_min_amounts(v1, v2, arg2);
        let (v5, v6) = 0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::withdraw<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, &mut v0, arg1, v4, v3, arg12, arg13);
        let v7 = v6;
        let v8 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v7);
        let v9 = 0x2::coin::into_balance<0x2::sui::SUI>(v5);
        let v10 = if (v8 >= 1000000000) {
            0x2::balance::join<0x2::sui::SUI>(&mut v9, 0x2::coin::into_balance<0x2::sui::SUI>(0x49245a063580c5d43c3cede7853332018143104bc31d7a297e1daa45e320d525::cetus_vault_adapter::unstake_hasui_instant_coin(arg11, arg10, v7, arg13)));
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

