module 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_protocol_ops {
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

    public(friend) fun deposit_to_navi<T0>(arg0: &0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &vector<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::get_amount(arg2, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_NAVI());
        if (v0 > 0 && 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::is_protocol_enabled<T0>(arg0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_NAVI())) {
            let v1 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid<T0>(arg0);
            0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::navi_adapter::deposit<T0>(arg8, arg3, arg4, arg5, 0x2::coin::take<T0>(arg1, (v0 as u64), arg9), (v0 as u64), 0x2::object::uid_to_address(v1), arg6, arg7, 0x2::dynamic_field::borrow<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v1, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::navi_account_cap_key()), arg9);
        };
    }

    public(friend) fun deposit_to_scallop<T0>(arg0: &mut 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &vector<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::get_amount(arg2, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP());
        if (v0 > 0 && 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::is_protocol_enabled<T0>(arg0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP())) {
            let v1 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::exists_<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP())) {
                0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::borrow_mut<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP()), 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::scallop_adapter::deposit<T0>(arg3, arg4, 0x2::coin::take<T0>(arg1, (v0 as u64), arg6), arg5, arg6)));
            } else {
                0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::store<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::scallop_adapter::deposit<T0>(arg3, arg4, 0x2::coin::take<T0>(arg1, (v0 as u64), arg6), arg5, arg6)));
            };
        };
    }

    public(friend) fun deposit_to_suilend<T0, T1>(arg0: &mut 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &vector<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::get_amount(arg2, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND());
        if (v0 > 0 && 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::is_protocol_enabled<T0>(arg0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND())) {
            let v1 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::exists_<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v1, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND())) {
                0x2::balance::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::borrow_mut<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v1, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND()), 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::suilend_adapter::deposit<T1, T0>(arg3, arg4, arg5, 0x2::coin::take<T0>(arg1, (v0 as u64), arg6), arg6)));
            } else {
                0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::store<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v1, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND(), 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::suilend_adapter::deposit<T1, T0>(arg3, arg4, arg5, 0x2::coin::take<T0>(arg1, (v0 as u64), arg6), arg6)));
            };
        };
    }

    public(friend) fun query_cetus_underlying<T0>(arg0: &0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<0x2::sui::SUI>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u128 {
        let v0 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid<0x2::sui::SUI>(arg0);
        if (0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::exists_<0x2::balance::Balance<T0>>(v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_CETUS())) {
            let v2 = 0x2::balance::value<T0>(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::borrow<0x2::balance::Balance<T0>>(v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_CETUS()));
            if (v2 == 0) {
                return 0
            };
            0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg1, arg2, arg3, v2)
        } else {
            0
        }
    }

    public(friend) fun query_navi_balance<T0>(arg0: &0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) : u128 {
        0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::navi_adapter::get_underlying_balance(arg1, arg2, 0x2::object::uid_to_address(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid<T0>(arg0)))
    }

    public(friend) fun query_scallop_balance<T0>(arg0: &0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u128 {
        let v0 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid<T0>(arg0);
        if (0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::exists_<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP())) {
            0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::scallop_adapter::get_underlying_balance<T0>(arg1, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::borrow<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP())))
        } else {
            0
        }
    }

    public(friend) fun query_suilend_balance<T0, T1>(arg0: &0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) : u128 {
        let v0 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid<T0>(arg0);
        if (0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::exists_<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND())) {
            0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::suilend_adapter::get_underlying_balance<T1, T0>(arg1, 0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::borrow<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND())))
        } else {
            0
        }
    }

    public(friend) fun query_vault_underlying<T0, T1>(arg0: &0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: &0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::meta_vault_core::Vault<T0, T1>, arg2: &0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::Hearn) : u128 {
        let v0 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid<T0>(arg0);
        if (0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::exists_<0x2::balance::Balance<T1>>(v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_VAULT())) {
            let v2 = 0x2::balance::value<T1>(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::borrow<0x2::balance::Balance<T1>>(v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_VAULT()));
            if (v2 == 0) {
                return 0
            };
            0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::meta_vault_core::preview_redeem<T0, T1>(arg1, arg2, (v2 as u128))
        } else {
            0
        }
    }

    public(friend) fun sync_all_balances<T0, T1, T2>(arg0: &mut 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<0x2::sui::SUI>, arg1: &0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg2: &0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::Hearn, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>();
        0x1::vector::push_back<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::create(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_VAULT(), query_vault_underlying<0x2::sui::SUI, T0>(arg0, arg1, arg2)));
        0x1::vector::push_back<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::create(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_CETUS(), query_cetus_underlying<T2>(arg0, arg3, arg4, arg5)));
        0x1::vector::push_back<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::create(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND(), query_suilend_balance<0x2::sui::SUI, T1>(arg0, arg6)));
        0x1::vector::push_back<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::create(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP(), query_scallop_balance<0x2::sui::SUI>(arg0, arg7)));
        0x1::vector::push_back<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::create(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_NAVI(), query_navi_balance<0x2::sui::SUI>(arg0, arg8, arg9)));
        0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_sync::sync_balances<0x2::sui::SUI>(arg0, v0, arg10);
    }

    public(friend) fun sync_l1_l3_balances<T0, T1, T2>(arg0: &mut 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: &0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::meta_vault_core::Vault<T0, T1>, arg2: &0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::Hearn, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>();
        0x1::vector::push_back<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::create(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_VAULT(), query_vault_underlying<T0, T1>(arg0, arg1, arg2)));
        0x1::vector::push_back<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::create(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND(), query_suilend_balance<T0, T2>(arg0, arg3)));
        0x1::vector::push_back<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::create(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP(), query_scallop_balance<T0>(arg0, arg4)));
        0x1::vector::push_back<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::create(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_NAVI(), query_navi_balance<T0>(arg0, arg5, arg6)));
        0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_sync::sync_balances<T0>(arg0, v0, arg7);
    }

    public(friend) fun withdraw_from_cetus<T0>(arg0: &mut 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<0x2::sui::SUI>, arg1: u128, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg3: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg9: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u128) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        let v2 = v1;
        if (arg1 > 0) {
            let v3 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid_mut<0x2::sui::SUI>(arg0);
            if (0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::exists_<0x2::balance::Balance<T0>>(v3, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_CETUS())) {
                let v4 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::borrow_mut<0x2::balance::Balance<T0>>(v3, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_CETUS());
                let v5 = 0x2::balance::value<T0>(v4);
                if (v5 > 0) {
                    let v6 = calculate_cetus_lp_to_withdraw(v5, 0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg3, arg8, arg9, v5), arg1);
                    if (v6 == 0) {
                        return (v0, v1)
                    };
                    let v7 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v4, v6), arg12);
                    let (v8, v9) = 0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::cetus_vault_adapter::withdraw<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, &mut v7, v6, 0, 0, arg11, arg12);
                    let v10 = v9;
                    let v11 = v8;
                    if (0x2::coin::value<T0>(&v7) > 0) {
                        0x2::balance::join<T0>(v4, 0x2::coin::into_balance<T0>(v7));
                    } else {
                        0x2::coin::destroy_zero<T0>(v7);
                    };
                    let v12 = v1 + (0x2::coin::value<0x2::sui::SUI>(&v11) as u128);
                    v2 = v12;
                    0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::coin::into_balance<0x2::sui::SUI>(v11));
                    let v13 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v10);
                    if (v13 > 0) {
                        let v14 = 0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::cetus_vault_adapter::unstake_hasui_instant_coin(arg10, arg9, v10, arg12);
                        0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_events::emit_instant_unstake_fee(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::id<0x2::sui::SUI>(arg0), 0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::cetus_vault_adapter::get_sui_by_hasui(arg9, v13), 0x2::coin::value<0x2::sui::SUI>(&v14), 0x2::clock::timestamp_ms(arg11));
                        v2 = v12 + (0x2::coin::value<0x2::sui::SUI>(&v14) as u128);
                        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::coin::into_balance<0x2::sui::SUI>(v14));
                    } else {
                        0x2::coin::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v10);
                    };
                };
            };
        };
        (v0, v2)
    }

    public(friend) fun withdraw_from_navi<T0>(arg0: &0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: u128, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u128) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = v1;
        if (arg1 > 0) {
            let v3 = 0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::navi_adapter::withdraw<T0>(arg9, arg7, arg2, arg3, arg4, (arg1 as u64), arg5, arg6, 0x2::dynamic_field::borrow<0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid<T0>(arg0), 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::navi_account_cap_key()), arg8, arg10);
            v2 = v1 + (0x2::coin::value<T0>(&v3) as u128);
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v3));
        };
        (v0, v2)
    }

    public(friend) fun withdraw_from_scallop<T0>(arg0: &mut 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: u128, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u128) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = v1;
        if (arg1 > 0) {
            let v3 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::exists_<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v3, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP())) {
                let v4 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::borrow_mut<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v3, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SCALLOP());
                let v5 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v4);
                if (v5 > 0) {
                    let v6 = 0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::scallop_adapter::calculate_scoin_for_underlying<T0>(arg3, arg1);
                    let v7 = if (v6 > v5) {
                        v5
                    } else {
                        v6
                    };
                    let v8 = 0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::scallop_adapter::withdraw<T0>(arg2, arg3, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v4, v7, arg5), arg4, arg5);
                    v2 = v1 + (0x2::coin::value<T0>(&v8) as u128);
                    0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v8));
                };
            };
        };
        (v0, v2)
    }

    public(friend) fun withdraw_from_suilend<T0, T1>(arg0: &mut 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::LLVPool<T0>, arg1: u128, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u128) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = v1;
        if (arg1 > 0) {
            let v3 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::exists_<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v3, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND())) {
                let v4 = 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::protocol_holdings::borrow_mut<0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>>(v3, 0x648fcd8aeb6eed94124d6418ccf74f029cef832d62209a2414643638e31331f1::llv_allocation_plan::PROTOCOL_SUILEND());
                let v5 = 0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(v4);
                if (v5 > 0) {
                    let v6 = 0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::suilend_adapter::calculate_ctoken_for_underlying<T1, T0>(arg2, arg1);
                    let v7 = if (v6 > v5) {
                        v5
                    } else {
                        v6
                    };
                    let v8 = 0x8f2060505ea6c22bd15f3c5b3b016b18af64f04c38839678e5fe1625736fb2f8::suilend_adapter::withdraw<T1, T0>(arg2, arg3, arg4, 0x2::coin::take<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T1, T0>>(v4, v7, arg5), arg5);
                    v2 = v1 + (0x2::coin::value<T0>(&v8) as u128);
                    0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v8));
                };
            };
        };
        (v0, v2)
    }

    // decompiled from Move bytecode v6
}

