module 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_protocol_ops {
    public(friend) fun build_actual_recall_plan(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : vector<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount> {
        let v0 = 0x1::vector::empty<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>();
        if (arg0 > 0) {
            0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT(), arg0));
        };
        if (arg1 > 0) {
            0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS(), arg1));
        };
        if (arg2 > 0) {
            0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND(), arg2));
        };
        if (arg3 > 0) {
            0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP(), arg3));
        };
        if (arg4 > 0) {
            0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_NAVI(), arg4));
        };
        v0
    }

    public(friend) fun calculate_cetus_lp_to_withdraw(arg0: u64, arg1: u128, arg2: u128) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        if (arg2 >= arg1) {
            return arg0
        };
        let v1 = ((arg0 as u128) * arg2 + arg1 - 1) / arg1;
        if (v1 > (arg0 as u128)) {
            arg0
        } else {
            (v1 as u64)
        }
    }

    fun calculate_cetus_protocol_deducted(arg0: u128, arg1: u64, arg2: u64) : u128 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        if (arg2 >= arg1) {
            return arg0
        };
        let v1 = ((((arg0 as u256) * (arg2 as u256) + (arg1 as u256) - 1) / (arg1 as u256)) as u128);
        if (v1 > arg0) {
            arg0
        } else {
            v1
        }
    }

    public(friend) fun deposit_to_cetus<T0>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<0x2::sui::SUI>, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: u128, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0 && 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::is_protocol_enabled<0x2::sui::SUI>(arg0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS())) {
            let v0 = (0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::cetus_vault_adapter::exchange_rate_precision() as u128);
            let v1 = if (v0 == 0) {
                0
            } else {
                arg2 * 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::cetus_vault_adapter::get_underlying_sui_hasui_ratio<T0>(arg4, arg9, arg10) / v0
            };
            let v2 = (v1 as u64);
            let v3 = v2;
            let v4 = (arg2 as u64) - v2;
            let v5 = v4;
            if (v2 == 0 || v4 == 0) {
                let v6 = ((arg2 / 2) as u64);
                v3 = v6;
                v5 = (arg2 as u64) - v6;
            };
            let v7 = 0x2::coin::take<0x2::sui::SUI>(arg1, v3, arg13);
            let v8 = 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::cetus_vault_adapter::stake_sui_for_hasui(arg11, arg10, 0x2::coin::take<0x2::sui::SUI>(arg1, v5, arg13), @0x0, arg13);
            let v9 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid_mut<0x2::sui::SUI>(arg0);
            if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<T0>>(v9, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS())) {
                0x2::balance::join<T0>(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow_mut<0x2::balance::Balance<T0>>(v9, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS()), 0x2::coin::into_balance<T0>(0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::cetus_vault_adapter::deposit<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, v8, v7, 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v8), 0x2::coin::value<0x2::sui::SUI>(&v7), false, arg12, arg13)));
            } else {
                0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::store<0x2::balance::Balance<T0>>(v9, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS(), 0x2::coin::into_balance<T0>(0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::cetus_vault_adapter::deposit<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, v8, v7, 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v8), 0x2::coin::value<0x2::sui::SUI>(&v7), false, arg12, arg13)));
            };
        };
    }

    public(friend) fun deposit_to_navi<T0>(arg0: &0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &vector<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(arg2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_NAVI());
        if (v0 > 0 && 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::is_protocol_enabled<T0>(arg0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_NAVI())) {
            let v1 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid<T0>(arg0);
            0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::navi_adapter::deposit<T0>(arg8, arg3, arg4, arg5, 0x2::coin::take<T0>(arg1, (v0 as u64), arg9), (v0 as u64), 0x2::object::uid_to_address(v1), arg6, arg7, 0x2::dynamic_field::borrow<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v1, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::navi_account_cap_key()), arg9);
        };
    }

    public(friend) fun deposit_to_pool<T0, T1, T2>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::market::Hearn, arg4: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::Vault<T0, T1>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: u64, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::DepositResult, u64) {
        sync_l1_l3_balances<T0, T1, T2>(arg0, arg4, arg3, arg5, arg8, arg9, arg10, arg11, arg14);
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::accrue_fees<T0>(arg0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::get_total_assets<T0>(arg0), 0x2::clock::timestamp_ms(arg14));
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::calculate_deposit<T0>(arg0, 0x2::coin::value<T0>(&arg1));
        let v1 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::allocation(&v0);
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::verify_min_shares(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::shares_to_mint(&v0), arg2);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = &mut v2;
        deposit_to_vault<T0, T1>(arg0, v3, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v1, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT()), arg3, arg4, arg14, arg15);
        let v4 = &mut v2;
        deposit_to_suilend<T0, T2>(arg0, v4, v1, arg5, arg6, arg14, arg15);
        let v5 = &mut v2;
        deposit_to_scallop<T0>(arg0, v5, v1, arg7, arg8, arg14, arg15);
        let v6 = &mut v2;
        deposit_to_navi<T0>(arg0, v6, v1, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        if (0x2::balance::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg15), 0x2::tx_context::sender(arg15));
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::record_deposit_state<T0>(arg0, &v0, v1);
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::update_last_total_assets<T0>(arg0);
        (v0, (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::total_amount(v1) as u64))
    }

    public(friend) fun deposit_to_pool_sui<T0, T1, T2>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u128, arg3: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::market::Hearn, arg4: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg5: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg6: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg8: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg9: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg12: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg15: u64, arg16: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg17: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg20: u8, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) : (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::DepositResult, u64) {
        sync_all_balances<T0, T1, T2>(arg0, arg4, arg3, arg6, arg11, arg12, arg14, arg17, arg18, arg19, arg20, arg23);
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::accrue_fees<0x2::sui::SUI>(arg0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::get_total_assets<0x2::sui::SUI>(arg0), 0x2::clock::timestamp_ms(arg23));
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::calculate_deposit<0x2::sui::SUI>(arg0, 0x2::coin::value<0x2::sui::SUI>(&arg1));
        let v1 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::allocation(&v0);
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::verify_min_shares(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::shares_to_mint(&v0), arg2);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v3 = &mut v2;
        deposit_to_vault<0x2::sui::SUI, T0>(arg0, v3, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v1, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT()), arg3, arg4, arg23, arg24);
        let v4 = &mut v2;
        deposit_to_cetus<T2>(arg0, v4, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v1, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS()), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg23, arg24);
        let v5 = &mut v2;
        deposit_to_suilend<0x2::sui::SUI, T1>(arg0, v5, v1, arg14, arg15, arg23, arg24);
        let v6 = &mut v2;
        deposit_to_scallop<0x2::sui::SUI>(arg0, v6, v1, arg16, arg17, arg23, arg24);
        let v7 = &mut v2;
        deposit_to_navi<0x2::sui::SUI>(arg0, v7, v1, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        if (0x2::balance::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg24), 0x2::tx_context::sender(arg24));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        };
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_deposit::record_deposit_state<0x2::sui::SUI>(arg0, &v0, v1);
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::update_last_total_assets<0x2::sui::SUI>(arg0);
        (v0, (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::total_amount(v1) as u64))
    }

    public(friend) fun deposit_to_scallop<T0>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &vector<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(arg2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP());
        if (v0 > 0 && 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::is_protocol_enabled<T0>(arg0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP())) {
            let v1 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP())) {
                0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow_mut<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP()), 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::scallop_adapter::deposit<T0>(arg3, arg4, 0x2::coin::take<T0>(arg1, (v0 as u64), arg6), arg5, arg6)));
            } else {
                0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::store<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::scallop_adapter::deposit<T0>(arg3, arg4, 0x2::coin::take<T0>(arg1, (v0 as u64), arg6), arg5, arg6)));
            };
        };
    }

    public(friend) fun deposit_to_suilend<T0, T1>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &vector<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(arg2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND());
        if (v0 > 0 && 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::is_protocol_enabled<T0>(arg0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND())) {
            let v1 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v1, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND())) {
                0x2::balance::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow_mut<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v1, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND()), 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::suilend_adapter::deposit<T1, T0>(arg3, arg4, arg5, 0x2::coin::take<T0>(arg1, (v0 as u64), arg6), arg6)));
            } else {
                0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::store<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v1, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND(), 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::suilend_adapter::deposit<T1, T0>(arg3, arg4, arg5, 0x2::coin::take<T0>(arg1, (v0 as u64), arg6), arg6)));
            };
        };
    }

    public(friend) fun deposit_to_vault<T0, T1>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u128, arg3: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::market::Hearn, arg4: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::Vault<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0 && 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::is_protocol_enabled<T0>(arg0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT())) {
            let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<T1>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT())) {
                0x2::balance::join<T1>(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow_mut<0x2::balance::Balance<T1>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT()), 0x2::coin::into_balance<T1>(0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::deposit<T0, T1>(arg4, arg3, 0x2::coin::take<T0>(arg1, (arg2 as u64), arg6), arg5, arg6)));
            } else {
                0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::store<0x2::balance::Balance<T1>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT(), 0x2::coin::into_balance<T1>(0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::deposit<T0, T1>(arg4, arg3, 0x2::coin::take<T0>(arg1, (arg2 as u64), arg6), arg5, arg6)));
            };
        };
    }

    public(friend) fun query_cetus_underlying<T0>(arg0: &0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<0x2::sui::SUI>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u128 {
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid<0x2::sui::SUI>(arg0);
        if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<T0>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS())) {
            let v2 = 0x2::balance::value<T0>(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow<0x2::balance::Balance<T0>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS()));
            if (v2 == 0) {
                return 0
            };
            0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg1, arg2, arg3, v2)
        } else {
            0
        }
    }

    public(friend) fun query_navi_balance<T0>(arg0: &0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u8) : u128 {
        0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::navi_adapter::get_underlying_balance<T0>(arg1, arg2, arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0x2::dynamic_field::borrow<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid<T0>(arg0), 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::navi_account_cap_key())))
    }

    public(friend) fun query_scallop_balance<T0>(arg0: &0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u128 {
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid<T0>(arg0);
        if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP())) {
            0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::scallop_adapter::get_underlying_balance<T0>(arg1, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP())))
        } else {
            0
        }
    }

    public(friend) fun query_suilend_balance<T0, T1>(arg0: &0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) : u128 {
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid<T0>(arg0);
        if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND())) {
            0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::suilend_adapter::get_underlying_balance<T1, T0>(arg1, 0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND())))
        } else {
            0
        }
    }

    public(friend) fun query_vault_underlying<T0, T1>(arg0: &0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: &0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::Vault<T0, T1>, arg2: &0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::market::Hearn) : u128 {
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid<T0>(arg0);
        if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<T1>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT())) {
            let v2 = 0x2::balance::value<T1>(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow<0x2::balance::Balance<T1>>(v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT()));
            if (v2 == 0) {
                return 0
            };
            0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::preview_redeem<T0, T1>(arg1, arg2, (v2 as u128))
        } else {
            0
        }
    }

    public(friend) fun select_navi_withdraw_amount(arg0: u128, arg1: u128, arg2: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = if (arg0 > arg1) {
            arg1
        } else {
            arg0
        };
        let v2 = if (v1 > (arg2 as u128)) {
            (arg2 as u128)
        } else {
            v1
        };
        (v2 as u64)
    }

    public(friend) fun select_scallop_scoin_withdraw_amount(arg0: u128, arg1: u64, arg2: u128, arg3: u128, arg4: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = ((((arg0 as u256) * (arg3 as u256) + (arg2 as u256) - 1) / (arg2 as u256)) as u128);
        let v2 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_math::mul_div((arg4 as u128), arg3, arg2);
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        let v4 = if (v3 > (arg1 as u128)) {
            (arg1 as u128)
        } else {
            v3
        };
        (v4 as u64)
    }

    public(friend) fun select_suilend_ctoken_withdraw_amount(arg0: u128, arg1: u64, arg2: u128, arg3: u128, arg4: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = ((((arg0 as u256) * (arg3 as u256) + (arg2 as u256) - 1) / (arg2 as u256)) as u128);
        let v2 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_math::mul_div((arg4 as u128), arg3, arg2);
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        let v4 = if (v3 > (arg1 as u128)) {
            (arg1 as u128)
        } else {
            v3
        };
        (v4 as u64)
    }

    public(friend) fun select_vault_withdraw_amount(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : (u64, u128) {
        if (arg2 > (arg1 as u128)) {
            (arg1, arg3)
        } else {
            ((arg2 as u64), arg0)
        }
    }

    public(friend) fun sync_all_balances<T0, T1, T2>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<0x2::sui::SUI>, arg1: &0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg2: &0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::market::Hearn, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg5: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: u8, arg11: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>();
        0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT(), query_vault_underlying<0x2::sui::SUI, T0>(arg0, arg1, arg2)));
        0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS(), query_cetus_underlying<T2>(arg0, arg3, arg4, arg5)));
        0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND(), query_suilend_balance<0x2::sui::SUI, T1>(arg0, arg6)));
        0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP(), query_scallop_balance<0x2::sui::SUI>(arg0, arg7)));
        0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_NAVI(), query_navi_balance<0x2::sui::SUI>(arg0, arg8, arg9, arg10)));
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_sync::sync_balances<0x2::sui::SUI>(arg0, v0, arg11);
    }

    public(friend) fun sync_l1_l3_balances<T0, T1, T2>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: &0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::Vault<T0, T1>, arg2: &0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::market::Hearn, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>();
        0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT(), query_vault_underlying<T0, T1>(arg0, arg1, arg2)));
        0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND(), query_suilend_balance<T0, T2>(arg0, arg3)));
        0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP(), query_scallop_balance<T0>(arg0, arg4)));
        0x1::vector::push_back<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::create(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_NAVI(), query_navi_balance<T0>(arg0, arg5, arg6, arg7)));
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_sync::sync_balances<T0>(arg0, v0, arg8);
    }

    public(friend) fun withdraw_from_cetus<T0>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<0x2::sui::SUI>, arg1: u128, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg3: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg9: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u128, u128) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        if (arg1 > 0) {
            let v5 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid_mut<0x2::sui::SUI>(arg0);
            if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<T0>>(v5, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS())) {
                let v6 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow_mut<0x2::balance::Balance<T0>>(v5, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS());
                let v7 = 0x2::balance::value<T0>(v6);
                if (v7 > 0) {
                    let v8 = 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg3, arg8, arg9, v7);
                    let v9 = calculate_cetus_lp_to_withdraw(v7, v8, arg1);
                    if (v9 == 0) {
                        return (v0, v1, v3)
                    };
                    v4 = calculate_cetus_protocol_deducted(v8, v7, v9);
                    let v10 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v9), arg12);
                    let (v11, v12) = 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::cetus_vault_adapter::withdraw<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, &mut v10, v9, 0, 0, arg11, arg12);
                    let v13 = v12;
                    let v14 = v11;
                    if (0x2::coin::value<T0>(&v10) > 0) {
                        0x2::balance::join<T0>(v6, 0x2::coin::into_balance<T0>(v10));
                    } else {
                        0x2::coin::destroy_zero<T0>(v10);
                    };
                    let v15 = v1 + (0x2::coin::value<0x2::sui::SUI>(&v14) as u128);
                    v2 = v15;
                    0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::coin::into_balance<0x2::sui::SUI>(v14));
                    let v16 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v13);
                    if (v16 > 0) {
                        let v17 = 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::cetus_vault_adapter::unstake_hasui_instant_coin(arg10, arg9, v13, arg12);
                        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_events::emit_instant_unstake_fee(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::id<0x2::sui::SUI>(arg0), 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::cetus_vault_adapter::get_sui_by_hasui(arg9, v16), 0x2::coin::value<0x2::sui::SUI>(&v17), 0x2::clock::timestamp_ms(arg11));
                        v2 = v15 + (0x2::coin::value<0x2::sui::SUI>(&v17) as u128);
                        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::coin::into_balance<0x2::sui::SUI>(v17));
                    } else {
                        0x2::coin::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v13);
                    };
                };
            };
        };
        (v0, v2, v4)
    }

    public(friend) fun withdraw_from_navi<T0>(arg0: &0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: u128, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u128) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = v1;
        if (arg1 > 0) {
            let v3 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid<T0>(arg0);
            let v4 = 0x2::dynamic_field::borrow<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v3, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::navi_account_cap_key());
            let v5 = select_navi_withdraw_amount(arg1, 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::navi_adapter::get_underlying_balance<T0>(arg2, arg3, arg4, 0x2::object::uid_to_address(v3)), 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::navi_adapter::get_available_liquidity<T0>(arg2, arg3, arg4));
            if (v5 == 0) {
                return (v0, v1)
            };
            let v6 = 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::navi_adapter::withdraw<T0>(arg9, arg7, arg2, arg3, arg4, v5, arg5, arg6, v4, arg8, arg10);
            v2 = v1 + (0x2::coin::value<T0>(&v6) as u128);
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v6));
        };
        (v0, v2)
    }

    public(friend) fun withdraw_from_pool<T0, T1, T2>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: &0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_position::LLVPoolPosition<T0>, arg2: u128, arg3: u64, arg4: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::market::Hearn, arg5: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::Vault<T0, T1>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg7: u64, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: u8, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg16: &mut 0x3::sui_system::SuiSystemState, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u128, u128, vector<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>) {
        sync_l1_l3_balances<T0, T1, T2>(arg0, arg5, arg4, arg6, arg9, arg10, arg11, arg12, arg17);
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::get_total_assets<T0>(arg0);
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::accrue_fees<T0>(arg0, v0, 0x2::clock::timestamp_ms(arg17));
        let v1 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_withdraw::calculate_withdraw_by_shares<T0>(arg0, arg1, arg2);
        let v2 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_withdraw::recall_plan(&v1);
        let v3 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_NAVI());
        let v4 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP());
        let v5 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND());
        let v6 = 0x2::balance::zero<T0>();
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        if (v3 > 0) {
            let (v10, v11) = withdraw_from_navi<T0>(arg0, v3, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
            0x2::balance::join<T0>(&mut v6, v10);
            v7 = v11;
        };
        if (v4 > 0) {
            let (v12, v13) = withdraw_from_scallop<T0>(arg0, v4, arg8, arg9, arg17, arg18);
            0x2::balance::join<T0>(&mut v6, v12);
            v8 = v13;
        };
        if (v5 > 0) {
            let (v14, v15) = withdraw_from_suilend<T0, T2>(arg0, v5, arg6, arg7, arg17, arg18);
            0x2::balance::join<T0>(&mut v6, v14);
            v9 = v15;
        };
        let (v16, v17) = withdraw_from_vault<T0, T1>(arg0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT()), arg4, arg5, arg17, arg18);
        0x2::balance::join<T0>(&mut v6, v16);
        let v18 = 0x2::balance::value<T0>(&v6);
        assert!((v18 as u128) >= (arg3 as u128), 4);
        let v19 = build_actual_recall_plan(v17, 0, v9, v8, v7);
        let v20 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_math::calculate_proportional_withdraw_burn(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_withdraw::shares_to_burn(&v1), 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_withdraw::assets_to_receive(&v1), (v18 as u128));
        let v21 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_position::shares<T0>(arg1);
        let v22 = if (v20 > v21) {
            assert!((v18 as u128) <= 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_math::calculate_assets_for_shares(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::total_shares<T0>(arg0), v0, v21) + (0x1::vector::length<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&v19) as u128) + 2, 4);
            v21
        } else {
            v20
        };
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_withdraw::record_withdraw_state<T0>(arg0, v22, &v19);
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::update_last_total_assets<T0>(arg0);
        (v6, v22, (v18 as u128), v19)
    }

    public(friend) fun withdraw_from_pool_sui<T0, T1, T2>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<0x2::sui::SUI>, arg1: &0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_position::LLVPoolPosition<0x2::sui::SUI>, arg2: u128, arg3: u64, arg4: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::market::Hearn, arg5: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg13: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg16: u64, arg17: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg18: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg21: u8, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg24: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u128, u128, vector<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>) {
        sync_all_balances<T0, T1, T2>(arg0, arg5, arg4, arg7, arg12, arg13, arg15, arg18, arg19, arg20, arg21, arg25);
        let v0 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::get_total_assets<0x2::sui::SUI>(arg0);
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::accrue_fees<0x2::sui::SUI>(arg0, v0, 0x2::clock::timestamp_ms(arg25));
        let v1 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_withdraw::calculate_withdraw_by_shares<0x2::sui::SUI>(arg0, arg1, arg2);
        let v2 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_withdraw::recall_plan(&v1);
        let v3 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_NAVI());
        let v4 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP());
        let v5 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND());
        let v6 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_CETUS());
        let v7 = 0x2::balance::zero<0x2::sui::SUI>();
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        if (v3 > 0) {
            let (v12, v13) = withdraw_from_navi<0x2::sui::SUI>(arg0, v3, arg19, arg20, arg21, arg22, arg23, arg24, arg14, arg25, arg26);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v12);
            v8 = v13;
        };
        if (v4 > 0) {
            let (v14, v15) = withdraw_from_scallop<0x2::sui::SUI>(arg0, v4, arg17, arg18, arg25, arg26);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v14);
            v9 = v15;
        };
        if (v5 > 0) {
            let (v16, v17) = withdraw_from_suilend<0x2::sui::SUI, T1>(arg0, v5, arg15, arg16, arg25, arg26);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v16);
            v10 = v17;
        };
        if (v6 > 0) {
            let (v18, _, v20) = withdraw_from_cetus<T2>(arg0, v6, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg25, arg26);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v18);
            v11 = v20;
        };
        let (v21, v22) = withdraw_from_vault<0x2::sui::SUI, T0>(arg0, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::get_amount(v2, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT()), arg4, arg5, arg25, arg26);
        0x2::balance::join<0x2::sui::SUI>(&mut v7, v21);
        let v23 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        assert!((v23 as u128) >= (arg3 as u128), 4);
        let v24 = build_actual_recall_plan(v22, v11, v10, v9, v8);
        let v25 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_math::calculate_proportional_withdraw_burn(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_withdraw::shares_to_burn(&v1), 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_withdraw::assets_to_receive(&v1), (v23 as u128));
        let v26 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_position::shares<0x2::sui::SUI>(arg1);
        let v27 = if (v25 > v26) {
            assert!((v23 as u128) <= 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_math::calculate_assets_for_shares(0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::total_shares<0x2::sui::SUI>(arg0), v0, v26) + (0x1::vector::length<0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::ProtocolAmount>(&v24) as u128) + 2, 4);
            v26
        } else {
            v25
        };
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_withdraw::record_withdraw_state<0x2::sui::SUI>(arg0, v27, &v24);
        0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::update_last_total_assets<0x2::sui::SUI>(arg0);
        (v7, v27, (v23 as u128), v24)
    }

    public(friend) fun withdraw_from_scallop<T0>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: u128, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u128) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = v1;
        if (arg1 > 0) {
            let v3 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v3, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP())) {
                let v4 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow_mut<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v3, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SCALLOP());
                let v5 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v4);
                if (v5 > 0) {
                    let (v6, v7) = 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::scallop_adapter::get_exchange_rate<T0>(arg3);
                    let v8 = select_scallop_scoin_withdraw_amount(arg1, v5, v6, v7, 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::scallop_adapter::get_available_liquidity<T0>(arg3));
                    if (v8 == 0) {
                        return (v0, v1)
                    };
                    let v9 = 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::scallop_adapter::withdraw<T0>(arg2, arg3, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v4, v8, arg5), arg4, arg5);
                    v2 = v1 + (0x2::coin::value<T0>(&v9) as u128);
                    0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v9));
                };
            };
        };
        (v0, v2)
    }

    public(friend) fun withdraw_from_suilend<T0, T1>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: u128, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u128) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = v1;
        if (arg1 > 0) {
            let v3 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v3, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND())) {
                let v4 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow_mut<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v3, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_SUILEND());
                let v5 = 0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(v4);
                if (v5 > 0) {
                    let (v6, v7) = 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::suilend_adapter::get_ctoken_ratio<T1, T0>(arg2);
                    let v8 = select_suilend_ctoken_withdraw_amount(arg1, v5, v6, v7, 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::suilend_adapter::get_available_liquidity<T1, T0>(arg2));
                    if (v8 == 0) {
                        return (v0, v1)
                    };
                    let v9 = 0x61c0738d6aff3ecc1fd714346ff9acea882085d386145a808d78c2c3fd5ee075::suilend_adapter::withdraw<T1, T0>(arg2, arg3, arg4, 0x2::coin::take<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(v4, v8, arg5), arg5);
                    v2 = v1 + (0x2::coin::value<T0>(&v9) as u128);
                    0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v9));
                };
            };
        };
        (v0, v2)
    }

    public(friend) fun withdraw_from_vault<T0, T1>(arg0: &mut 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::LLVPool<T0>, arg1: u128, arg2: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::market::Hearn, arg3: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::Vault<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u128) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = v1;
        if (arg1 > 0) {
            let v3 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::exists_<0x2::balance::Balance<T1>>(v3, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT())) {
                let v4 = 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::protocol_holdings::borrow_mut<0x2::balance::Balance<T1>>(v3, 0x392bd31b89205b2e66b79108c5b209aeff05c7df46cbf13d5129e4fe0ac9148b::llv_allocation_plan::PROTOCOL_VAULT());
                let v5 = 0x2::balance::value<T1>(v4);
                if (v5 > 0) {
                    let (v6, v7) = select_vault_withdraw_amount(arg1, v5, 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::preview_withdraw<T0, T1>(arg3, arg2, arg1), 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::preview_redeem<T0, T1>(arg3, arg2, (v5 as u128)));
                    if (v6 == 0 || v7 == 0) {
                        return (v0, v1)
                    };
                    let (v8, v9) = 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::withdraw<T0, T1>(arg3, arg2, 0x2::coin::take<T1>(v4, v6, arg5), v7, arg4, arg5);
                    let v10 = v9;
                    let v11 = v8;
                    v2 = v1 + (0x2::coin::value<T0>(&v11) as u128);
                    0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v11));
                    if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v10)) {
                        0x2::balance::join<T1>(v4, 0x2::coin::into_balance<T1>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v10)));
                    } else {
                        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v10);
                    };
                };
            };
        };
        (v0, v2)
    }

    // decompiled from Move bytecode v6
}

