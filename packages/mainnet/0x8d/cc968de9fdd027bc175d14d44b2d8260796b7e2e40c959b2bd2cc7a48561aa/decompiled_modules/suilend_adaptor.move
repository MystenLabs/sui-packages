module 0x8dcc968de9fdd027bc175d14d44b2d8260796b7e2e40c959b2bd2cc7a48561aa::suilend_adaptor {
    struct ObligationRegistry has store, key {
        id: 0x2::object::UID,
        obligations: 0x2::bag::Bag,
    }

    struct SuilendDeposit has drop {
        dummy_field: bool,
    }

    struct SuilendWithdraw has drop {
        dummy_field: bool,
    }

    struct SuilendBorrow has drop {
        dummy_field: bool,
    }

    struct SuilendRepay has drop {
        dummy_field: bool,
    }

    struct SuilendClaimRewards has drop {
        dummy_field: bool,
    }

    public fun borrow<T0, T1, T2>(arg0: &mut ObligationRegistry, arg1: &mut 0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::boring_vault::Vault<T2>, arg2: &0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::GuardManager<T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = 0x1::option::some<vector<u8>>(v0);
        let v4 = SuilendBorrow{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg4, arg5, arg6);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::bag::borrow<address, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligations, v1), arg5, arg7);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg3, arg4, &v5, arg8, arg9);
            0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::return_asset<0x2::sui::SUI, T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg3, arg4, v5, arg9), arg9);
        } else {
            0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::return_asset<T1, T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T1>(arg3, arg4, 0x2::bag::borrow<address, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligations, v1), arg5, arg7, arg9), arg9);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::authorize_and_withdraw_if_needed<T1, SuilendBorrow, T2>(arg1, arg2, v4, 0, &v3, arg9));
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut ObligationRegistry, arg1: &mut 0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::boring_vault::Vault<T2>, arg2: &0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::GuardManager<T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = 0x1::option::some<vector<u8>>(v0);
        let v4 = SuilendClaimRewards{dummy_field: false};
        0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::return_asset<T1, T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg3, 0x2::bag::borrow<address, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligations, v1), arg6, arg4, arg5, arg7, arg8), arg8);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::authorize_and_withdraw_if_needed<T1, SuilendClaimRewards, T2>(arg1, arg2, v4, 0, &v3, arg8));
    }

    public fun deposit<T0, T1, T2>(arg0: &mut ObligationRegistry, arg1: &mut 0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::boring_vault::Vault<T2>, arg2: &0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::GuardManager<T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 0);
        if (!0x2::bag::contains<address>(&arg0.obligations, 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3))) {
            0x2::bag::add<address, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&mut arg0.obligations, 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg3, arg8));
        };
        let v0 = b"";
        let v1 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = 0x1::option::some<vector<u8>>(v0);
        let v4 = SuilendDeposit{dummy_field: false};
        let v5 = 0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::authorize_and_withdraw_if_needed<T1, SuilendDeposit, T2>(arg1, arg2, v4, arg6, &v3, arg8);
        0x1::option::destroy_some<vector<u8>>(v3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg3, arg4, 0x2::bag::borrow<address, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligations, v1), arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg3, arg4, arg5, 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v5), arg8), arg8);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::rebalance_staker<T0>(arg3, arg4, arg7, arg8);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v5);
    }

    public fun get_obligation<T0>(arg0: &ObligationRegistry, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        let v0 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1);
        assert!(0x2::bag::contains<address>(&arg0.obligations, v0), 1);
        0x2::bag::borrow<address, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligations, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObligationRegistry{
            id          : 0x2::object::new(arg0),
            obligations : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<ObligationRegistry>(v0);
    }

    public fun repay<T0, T1, T2>(arg0: &mut ObligationRegistry, arg1: &mut 0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::boring_vault::Vault<T2>, arg2: &0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::GuardManager<T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = 0x1::option::some<vector<u8>>(v0);
        let v4 = SuilendRepay{dummy_field: false};
        let v5 = 0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::authorize_and_withdraw_if_needed<T1, SuilendRepay, T2>(arg1, arg2, v4, arg6, &v3, arg7);
        let v6 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg3, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(0x2::bag::borrow<address, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligations, v1)), arg5, &mut v6, arg7);
        0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::return_asset<T1, T2>(arg1, v6, arg7);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v5);
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut ObligationRegistry, arg1: &mut 0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::boring_vault::Vault<T2>, arg2: &0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::GuardManager<T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = 0x1::option::some<vector<u8>>(v0);
        let v4 = SuilendWithdraw{dummy_field: false};
        0x1::option::destroy_some<vector<u8>>(v3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg4, arg5, arg6);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg3, arg4, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::bag::borrow<address, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligations, v1), arg5, arg7, arg9), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg9);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg3, arg4, &v5, arg8, arg9);
            0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::return_asset<0x2::sui::SUI, T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg3, arg4, v5, arg9), arg9);
        } else {
            0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::return_asset<T1, T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg3, arg4, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg3, arg4, 0x2::bag::borrow<address, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligations, v1), arg5, arg7, arg9), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg9), arg9);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::authorize_and_withdraw_if_needed<T1, SuilendWithdraw, T2>(arg1, arg2, v4, 0, &v3, arg9));
    }

    // decompiled from Move bytecode v6
}

