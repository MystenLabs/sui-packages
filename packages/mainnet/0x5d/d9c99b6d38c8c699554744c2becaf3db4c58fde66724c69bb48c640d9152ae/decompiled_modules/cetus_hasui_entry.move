module 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_hasui_entry {
    public fun admin_force_refresh_hasui_cetus<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = view_hasui_cetus_underlying<T0, T1>(arg0, arg1, arg2, arg3);
        0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_common::assert_admin_force_refresh_deviation<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, v0);
        let v1 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::new_cetus_leg_auth();
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::force_sync_protocol_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), v0, arg4, arg5, &v1);
    }

    public fun admin_recall_hasui_cetus_to_idle<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin_recall::AdminRecallReceipt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_cetus_config_for_asset<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::new_cetus_leg_auth();
        let v1 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS();
        let v2 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::query_holding_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0>(arg0, v1);
        let v3 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::calculate_lp_to_withdraw(v2, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_underlying_balance_in_hasui<T0>(arg4, arg9, arg10, v2), (arg2 as u128));
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin_recall::begin_recall_withdraw_leg<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v1, v3, &v0);
        let (v6, v7, v8) = withdraw_hasui_underlying<T0>(v4, v3, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_common::withdraw_slippage_bps<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v9);
        let v12 = if (v11 > 0) {
            (0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_hasui_by_sui(arg10, v11) as u128)
        } else {
            0
        };
        if (0x2::balance::value<T0>(&v10) > 0) {
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin_recall::store_recall_holding<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v1, v10, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
        merge_and_flush_sui_to_idle<T1>(arg0, v9, arg10, arg11, &v0, arg13);
        if (v12 > 0) {
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::record_leg_side_deduction<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v1, v12, &v0);
        };
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin_recall::finish_recall_withdraw_leg<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v5, v6, &v0);
    }

    public fun deposit_hasui_to_cetus<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::DepositReceipt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: u64, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_cetus_config_for_asset<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg5), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg4), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg9), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg10), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg11));
        let v0 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::new_cetus_leg_auth();
        let v1 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_underlying_balance_in_hasui<T0>(arg5, arg10, arg11, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::query_holding_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS()));
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::sync_for_deposit<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), v1, arg13, &v0);
        let v2 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::resolve_requested_deposit_amount<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
        if (v2 == 0) {
            return
        };
        let (v3, v4) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::begin_deposit_leg<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), v2, &v0);
        let v5 = v3;
        let (v6, v7, v8) = deposit_hasui_underlying<T0>(v5, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v9 = v8;
        let v10 = v7;
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::store_deposit_holding<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), v6, &v0);
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v9);
        let v12 = if (v11 > 0) {
            (0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_hasui_by_sui(arg11, v11) as u128)
        } else {
            0
        };
        let v13 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_common::consumed_input(0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v5), 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v10));
        let v14 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_common::accounted_deposit_value(v13, v1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_underlying_balance_in_hasui<T0>(arg5, arg10, arg11, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::query_holding_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS())), v12);
        let v15 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::max_accounted_value_gap_for_input<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, v13);
        merge_and_flush_sui_to_idle<T1>(arg0, v9, arg11, arg12, &v0, arg14);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::finish_deposit_leg_accounted_with_leftover<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v4, v10, v13, v14, v15, &v0);
        if (v12 > 0) {
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::record_leg_side_deduction<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), v12, &v0);
        };
    }

    public(friend) fun deposit_hasui_underlying<T0>(arg0: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: u64, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg3: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg9: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0);
        let v1 = if (arg1 >= v0) {
            v0
        } else {
            arg1
        };
        let v2 = v0 - v1;
        assert!(v1 > 0, 4);
        assert!(v2 > 0, 4);
        assert!(v2 >= 1000000000, 1);
        let v3 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::unstake_hasui_instant_coin(arg10, arg9, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0, v2), arg12), arg12);
        let v4 = 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg12);
        let v5 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v4);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v6 >= estimate_required_sui_for_lp<T0>(arg3, arg8, v5), 7);
        let (v7, v8, v9) = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::deposit<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, v4, v3, v5, v6, true, arg11, arg12);
        let v10 = v8;
        let v11 = 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v9);
        let v12 = 0x2::coin::value<0x2::sui::SUI>(&v10);
        let v13 = if (v12 >= 1000000000) {
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v11, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::stake_sui_for_hasui(arg10, arg9, v10, @0x0, arg12)));
            0x2::balance::zero<0x2::sui::SUI>()
        } else if (v12 > 0) {
            0x2::coin::into_balance<0x2::sui::SUI>(v10)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v10);
            0x2::balance::zero<0x2::sui::SUI>()
        };
        (0x2::coin::into_balance<T0>(v7), v11, v13)
    }

    fun estimate_required_sui_for_lp<T0>(arg0: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::total_token_amount<T0>(arg0);
        if (v0 == 0) {
            return 0
        };
        let (v1, v2) = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::get_position_amounts<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI, T0>(arg0, arg1, v0);
        if (v1 == 0 || v2 == 0) {
            return 0
        };
        let v3 = (arg2 as u128) * (v2 as u128);
        let v4 = (v1 as u128);
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

    public fun flush_accumulated_sui<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::assert_keeper<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, 0x2::tx_context::sender(arg5));
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::assert_no_active_operation_for_maintenance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_cetus_core_for_asset<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg2), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg3));
        let v0 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::new_cetus_leg_auth();
        let (v1, v2) = take_accumulated_sui_and_flush_to_idle<T1>(arg0, arg3, arg4, &v0, arg5);
        put_back_accumulated_sui_or_destroy<T1>(arg0, v1, v2, &v0);
    }

    fun merge_and_flush_sui_to_idle<T0>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS();
        let (v1, _) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::take_accumulated_dust<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0x2::sui::SUI, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v0, arg4);
        let v3 = v1;
        0x2::balance::join<0x2::sui::SUI>(&mut v3, arg1);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        if (v4 >= 1000000000) {
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::deposit_to_idle<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v0, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::stake_sui_for_hasui(arg3, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg5), @0x0, arg5)), arg4);
        } else if (v4 > 0) {
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::accumulate_dust<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0x2::sui::SUI, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v0, v3, (0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_hasui_by_sui(arg2, v4) as u128), arg4);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        };
    }

    fun put_back_accumulated_sui_or_destroy<T0>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u128, arg3: &0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg1) > 0) {
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::accumulate_dust<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0x2::sui::SUI, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), arg1, arg2, arg3);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public fun rebalance_deposit_hasui_to_cetus<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::RebalanceReceipt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: u64, arg3: u64, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg5: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg7: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_cetus_config_for_asset<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg5), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg4), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg9), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg10), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg11));
        let v0 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::new_cetus_leg_auth();
        let v1 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS();
        let v2 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_underlying_balance_in_hasui<T0>(arg5, arg10, arg11, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::query_holding_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0>(arg0, v1));
        let v3 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::resolve_requested_rebalance_deposit_amount<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, v1, arg2);
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::begin_rebalance_deposit_leg<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v1, v3, &v0);
        let v6 = v4;
        let v7 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v6);
        if (v7 == 0) {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v6);
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::finish_rebalance_deposit_leg_accounted_with_leftover<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v5, 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(), 0, 0, 0, &v0);
            return
        };
        let (v8, v9, v10) = deposit_hasui_underlying<T0>(v6, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v11 = v10;
        let v12 = v9;
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::store_rebalance_holding<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v1, v8, &v0);
        let v13 = 0x2::balance::value<0x2::sui::SUI>(&v11);
        let v14 = if (v13 > 0) {
            (0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_hasui_by_sui(arg11, v13) as u128)
        } else {
            0
        };
        let v15 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_common::consumed_input(v7, 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v12));
        let v16 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_common::accounted_deposit_value(v15, v2, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_underlying_balance_in_hasui<T0>(arg5, arg10, arg11, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::query_holding_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0>(arg0, v1)), v14);
        let v17 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::max_accounted_value_gap_for_input<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, v15);
        merge_and_flush_sui_to_idle<T1>(arg0, v11, arg11, arg12, &v0, arg14);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::finish_rebalance_deposit_leg_accounted_with_leftover<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v5, v12, v15, v16, v17, &v0);
        if (v14 > 0) {
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::record_leg_side_deduction<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v1, v14, &v0);
        };
    }

    public fun rebalance_withdraw_hasui_from_cetus<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::RebalanceReceipt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_cetus_config_for_asset<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::new_cetus_leg_auth();
        let v1 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS();
        let v2 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::query_holding_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0>(arg0, v1);
        let v3 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::calculate_lp_to_withdraw(v2, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_underlying_balance_in_hasui<T0>(arg4, arg9, arg10, v2), (arg2 as u128));
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::begin_rebalance_withdraw_leg<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v1, v3, &v0);
        let (v6, v7, v8) = withdraw_hasui_underlying<T0>(v4, v3, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_common::withdraw_slippage_bps<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v9 = v7;
        let v10 = v6;
        if (0x2::balance::value<T0>(&v9) > 0) {
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::store_rebalance_holding<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v1, v9, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v9);
        };
        let v11 = &mut v10;
        settle_withdraw_sui_dust<T1>(arg0, v8, v11, arg10, arg11, &v0, arg13);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::finish_rebalance_withdraw_leg<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v5, v10, &v0);
    }

    public fun refresh_hasui_cetus<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::assert_refresh_gate<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), arg4, arg5);
        let v0 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::new_cetus_leg_auth();
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::sync_protocol_balance_by_auth<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), view_hasui_cetus_underlying<T0, T1>(arg0, arg1, arg2, arg3), arg4, &v0);
    }

    fun settle_withdraw_sui_dust<T0>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS();
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        let (v2, _) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::take_accumulated_dust<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0x2::sui::SUI, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v0, arg5);
        let v4 = v2;
        0x2::balance::join<0x2::sui::SUI>(&mut v4, arg1);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        if (v5 >= 1000000000) {
            let v6 = 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::stake_sui_for_hasui(arg4, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg6), @0x0, arg6));
            let v7 = if (v5 == 0) {
                0
            } else {
                (((0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v6) as u128) * (v1 as u128) / (v5 as u128)) as u64)
            };
            if (v7 > 0) {
                0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2, 0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v6, v7));
            };
            if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v6) > 0) {
                0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::deposit_to_idle<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v0, v6, arg5);
            } else {
                0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v6);
            };
        } else if (v5 > 0) {
            if (v1 > 0) {
                0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::compensate_from_idle<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_hasui_by_sui(arg3, v1), arg5));
            };
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::accumulate_dust<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0x2::sui::SUI, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v0, v4, (0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_hasui_by_sui(arg3, v5) as u128), arg5);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
        };
    }

    fun take_accumulated_sui_and_flush_to_idle<T0>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u128) {
        let v0 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS();
        let (v1, v2) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::take_accumulated_dust<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0x2::sui::SUI, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v0, arg3);
        let v3 = v1;
        if (0x2::balance::value<0x2::sui::SUI>(&v3) >= 1000000000) {
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::deposit_to_idle<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, v0, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::stake_sui_for_hasui(arg2, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4), @0x0, arg4)), arg3);
            (0x2::balance::zero<0x2::sui::SUI>(), 0)
        } else {
            (v3, v2)
        }
    }

    public fun view_hasui_cetus_underlying<T0, T1>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u128 {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_cetus_core_for_asset<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg2), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg3));
        0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_underlying_balance_in_hasui<T0>(arg1, arg2, arg3, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::query_holding_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS()))
    }

    public fun withdraw_hasui_from_cetus<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::WithdrawReceipt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>, arg2: u128, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_cetus_config_for_asset<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::new_cetus_leg_auth();
        let v1 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::query_holding_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS());
        let v2 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_underlying_balance_in_hasui<T0>(arg4, arg9, arg10, v1);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::sync_for_withdraw<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg0, arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), v2, arg12, &v0);
        let v3 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::resolve_requested_withdraw_assets<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
        if (v3 == 0) {
            return
        };
        let v4 = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::calculate_lp_to_withdraw(v1, v2, v3);
        if (v4 == 0) {
            return
        };
        let (v5, v6) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::begin_withdraw_leg<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), v4, &v0);
        let (v7, v8, v9) = withdraw_hasui_underlying<T0>(v5, v4, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_common::withdraw_slippage_bps<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1>(arg0), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v10 = v8;
        let v11 = v7;
        if (0x2::balance::value<T0>(&v10) > 0) {
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::store_withdraw_holding<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), v10, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
        let v12 = &mut v11;
        settle_withdraw_sui_dust<T1>(arg0, v9, v12, arg10, arg11, &v0, arg13);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::finish_withdraw_leg<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T1, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, arg0, v6, v11, &v0);
    }

    public(friend) fun withdraw_hasui_underlying<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::coin::from_balance<T0>(arg0, arg13);
        let (v1, v2) = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::get_position_amounts<T0>(arg4, arg9, arg1);
        let (v3, v4) = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::withdraw_min_amounts(v1, v2, arg2);
        let (v5, v6) = 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::withdraw<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, &mut v0, arg1, v4, v3, arg12, arg13);
        let v7 = v5;
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&v7);
        let v9 = 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v6);
        let v10 = if (v8 >= 1000000000) {
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v9, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_vault_adapter::stake_sui_for_hasui(arg11, arg10, v7, @0x0, arg13)));
            0x2::balance::zero<0x2::sui::SUI>()
        } else if (v8 > 0) {
            0x2::coin::into_balance<0x2::sui::SUI>(v7)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
            0x2::balance::zero<0x2::sui::SUI>()
        };
        (v9, 0x2::coin::into_balance<T0>(v0), v10)
    }

    // decompiled from Move bytecode v7
}

