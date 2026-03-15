module 0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_entry {
    struct CetusLegAuth has drop {
        dummy_field: bool,
    }

    public fun deposit_to_cetus<T0, T1>(arg0: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::DepositReceipt<0x2::sui::SUI>, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = CetusLegAuth{dummy_field: false};
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::sync_for_deposit<0x2::sui::SUI, T1, CetusLegAuth>(arg0, arg1, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS(), 0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg4, arg9, arg10, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS())), arg12, &v0);
        let (v1, v2) = 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::begin_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS(), arg2, &v0);
        let v3 = v1;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = v4 - (((v4 as u128) * 0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_vault_adapter::get_underlying_sui_hasui_ratio<T0>(arg4, arg9, arg10) / (0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_vault_adapter::exchange_rate_precision() as u128)) as u64);
        let v6 = if (v5 > 0) {
            0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_vault_adapter::stake_sui_for_hasui(arg11, arg10, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v5), arg13), @0x0, arg13))
        } else {
            0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        };
        let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg13);
        let v8 = 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v6, arg13);
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::store_deposit_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS(), 0x2::coin::into_balance<T0>(0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_vault_adapter::deposit<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, v8, v7, 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v8), 0x2::coin::value<0x2::sui::SUI>(&v7), false, arg12, arg13)), &v0);
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::finish_deposit_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v2, 0x2::balance::zero<0x2::sui::SUI>(), &v0);
    }

    public fun register_cetus_leg_auth<T0>(arg0: &0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_admin::LLVGlobal, arg1: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg2: &0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_admin::LLVPoolAdminCap) {
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_admin::assert_version(arg0);
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::register_protocol_leg_auth<0x2::sui::SUI, T0, CetusLegAuth>(arg1, arg2, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS());
    }

    public fun sync_cetus<T0, T1>(arg0: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_validation::validate_cetus_core<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg2), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg3));
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::keeper_sync_protocol_balance<0x2::sui::SUI, T1>(arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS(), 0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg1, arg2, arg3, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS())), arg4, arg5);
    }

    public fun withdraw_from_cetus<T0, T1>(arg0: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::LLVPool<0x2::sui::SUI, T1>, arg1: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::WithdrawReceipt<0x2::sui::SUI, T1>, arg2: u128, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_validation::validate_cetus_config<T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg5), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg7), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg8), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg9), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg10));
        let v0 = CetusLegAuth{dummy_field: false};
        let v1 = 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::query_holding_balance<0x2::sui::SUI, T1, T0>(arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS());
        let v2 = 0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg4, arg9, arg10, v1);
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::sync_for_withdraw<0x2::sui::SUI, T1, CetusLegAuth>(arg0, arg1, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS(), v2, arg12, &v0);
        let v3 = 0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_vault_adapter::calculate_lp_to_withdraw(v1, v2, arg2);
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::begin_withdraw_leg<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS(), v3, &v0);
        let v6 = 0x2::coin::from_balance<T0>(v4, arg13);
        let (v7, v8) = 0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_vault_adapter::withdraw<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, &mut v6, v3, 0, 0, arg12, arg13);
        let v9 = v8;
        let v10 = 0x2::coin::into_balance<T0>(v6);
        if (0x2::balance::value<T0>(&v10) > 0) {
            0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::store_withdraw_holding<0x2::sui::SUI, T1, T0, CetusLegAuth>(arg1, arg0, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_allocation_plan::PROTOCOL_CETUS(), v10, &v0);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
        let v11 = 0x2::coin::into_balance<0x2::sui::SUI>(v7);
        if (0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v9) > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v11, 0x2::coin::into_balance<0x2::sui::SUI>(0x39f2b1f5714ee60173ea3a960467c3d334f122446f945c58a3f736520ac8427a::cetus_vault_adapter::unstake_hasui_instant_coin(arg11, arg10, v9, arg13)));
        } else {
            0x2::coin::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v9);
        };
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_user_entry::finish_withdraw_leg<0x2::sui::SUI, T1, CetusLegAuth>(arg1, arg0, v5, v11, &v0);
    }

    // decompiled from Move bytecode v6
}

