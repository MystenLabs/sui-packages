module 0x60415d196ed4f17dbee24a200b4f8be7ea79ca008f3e6f50d0df10e8eed2861d::suilend_adaptor {
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

    struct VaultKey<phantom T0> has copy, drop, store {
        market_id: address,
    }

    public fun borrow<T0, T1, T2>(arg0: &mut ObligationRegistry, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg2: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::GuardManager<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = 0x1::option::some<vector<u8>>(v0);
        let v4 = SuilendBorrow{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T1>(arg3, arg4, arg5, arg6);
        if (0x1::type_name::get<T2>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            let v5 = VaultKey<T0>{market_id: v1};
            let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T1, 0x2::sui::SUI>(arg3, arg4, 0x2::bag::borrow<VaultKey<T0>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1>>(&arg0.obligations, v5), arg5, arg7);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T1>(arg3, arg4, &v6, arg8, arg9);
            0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::return_asset<T0, 0x2::sui::SUI>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T1, 0x2::sui::SUI>(arg3, arg4, v6, arg9), arg9);
        } else {
            let v7 = VaultKey<T0>{market_id: v1};
            0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::return_asset<T0, T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T1, T2>(arg3, arg4, 0x2::bag::borrow<VaultKey<T0>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1>>(&arg0.obligations, v7), arg5, arg7, arg9), arg9);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::authorize_and_withdraw_if_needed<T0, T2, SuilendBorrow>(arg1, arg2, v4, 0, &v3, arg9));
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut ObligationRegistry, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg2: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::GuardManager<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = 0x1::option::some<vector<u8>>(v0);
        let v4 = SuilendClaimRewards{dummy_field: false};
        let v5 = VaultKey<T0>{market_id: v1};
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::return_asset<T0, T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T1, T2>(arg3, 0x2::bag::borrow<VaultKey<T0>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1>>(&arg0.obligations, v5), arg6, arg4, arg5, arg7, arg8), arg8);
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::authorize_and_withdraw_if_needed<T0, T2, SuilendClaimRewards>(arg1, arg2, v4, 0, &v3, arg8));
    }

    public fun deposit<T0, T1, T2>(arg0: &mut ObligationRegistry, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg2: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::GuardManager<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 0);
        let v0 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg3);
        let v1 = VaultKey<T0>{market_id: v0};
        if (!0x2::bag::contains<VaultKey<T0>>(&arg0.obligations, v1)) {
            let v2 = VaultKey<T0>{market_id: v0};
            0x2::bag::add<VaultKey<T0>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1>>(&mut arg0.obligations, v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T1>(arg3, arg8));
        };
        let v3 = b"";
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::ascii::String>(&v4));
        let v5 = 0x1::option::some<vector<u8>>(v3);
        let v6 = SuilendDeposit{dummy_field: false};
        let v7 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::authorize_and_withdraw_if_needed<T0, T2, SuilendDeposit>(arg1, arg2, v6, arg6, &v5, arg8);
        0x1::option::destroy_some<vector<u8>>(v5);
        let v8 = VaultKey<T0>{market_id: v0};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T1, T2>(arg3, arg4, 0x2::bag::borrow<VaultKey<T0>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1>>(&arg0.obligations, v8), arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T1, T2>(arg3, arg4, arg5, 0x1::option::extract<0x2::coin::Coin<T2>>(&mut v7), arg8), arg8);
        if (0x1::type_name::get<T2>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::rebalance_staker<T1>(arg3, arg4, arg7, arg8);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(v7);
    }

    public fun get_obligation<T0, T1>(arg0: &ObligationRegistry, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1> {
        let v0 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg1);
        let v1 = VaultKey<T0>{market_id: v0};
        assert!(0x2::bag::contains<VaultKey<T0>>(&arg0.obligations, v1), 1);
        let v2 = VaultKey<T0>{market_id: v0};
        0x2::bag::borrow<VaultKey<T0>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1>>(&arg0.obligations, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObligationRegistry{
            id          : 0x2::object::new(arg0),
            obligations : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<ObligationRegistry>(v0);
    }

    public fun repay<T0, T1, T2>(arg0: &mut ObligationRegistry, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg2: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::GuardManager<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = 0x1::option::some<vector<u8>>(v0);
        let v4 = SuilendRepay{dummy_field: false};
        let v5 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::authorize_and_withdraw_if_needed<T0, T2, SuilendRepay>(arg1, arg2, v4, arg6, &v3, arg7);
        let v6 = 0x1::option::extract<0x2::coin::Coin<T2>>(&mut v5);
        let v7 = VaultKey<T0>{market_id: v1};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T1, T2>(arg3, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T1>(0x2::bag::borrow<VaultKey<T0>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1>>(&arg0.obligations, v7)), arg5, &mut v6, arg7);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::return_asset<T0, T2>(arg1, v6, arg7);
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(v5);
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut ObligationRegistry, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg2: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::GuardManager<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = 0x1::option::some<vector<u8>>(v0);
        let v4 = SuilendWithdraw{dummy_field: false};
        0x1::option::destroy_some<vector<u8>>(v3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T1>(arg3, arg4, arg5, arg6);
        if (0x1::type_name::get<T2>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            let v5 = VaultKey<T0>{market_id: v1};
            let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T1, 0x2::sui::SUI>(arg3, arg4, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T1, 0x2::sui::SUI>(arg3, arg4, 0x2::bag::borrow<VaultKey<T0>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1>>(&arg0.obligations, v5), arg5, arg7, arg9), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg9);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T1>(arg3, arg4, &v6, arg8, arg9);
            0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::return_asset<T0, 0x2::sui::SUI>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T1, 0x2::sui::SUI>(arg3, arg4, v6, arg9), arg9);
        } else {
            let v7 = VaultKey<T0>{market_id: v1};
            0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::return_asset<T0, T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T1, T2>(arg3, arg4, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T1, T2>(arg3, arg4, 0x2::bag::borrow<VaultKey<T0>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1>>(&arg0.obligations, v7), arg5, arg7, arg9), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, T2>>(), arg9), arg9);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::authorize_and_withdraw_if_needed<T0, T2, SuilendWithdraw>(arg1, arg2, v4, 0, &v3, arg9));
    }

    // decompiled from Move bytecode v6
}

