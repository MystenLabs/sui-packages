module 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::lend_adapter {
    struct LendSupplied has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct LendWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct LendEmergencyWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun emergency_withdraw_lend<T0>(arg0: &mut 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::PortfolioVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::owner_address(arg0), 4);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v0, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v0, 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::borrow_obligation_cap(arg0), arg2, 18446744073709551615, arg3), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::owner_address(arg0));
        let v2 = LendEmergencyWithdrawn{
            vault_id  : 0x2::object::id<0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::PortfolioVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<LendEmergencyWithdrawn>(v2);
    }

    public fun supply<T0>(arg0: &mut 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::RebalanceProof, arg1: &mut 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::PortfolioVault, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::version::assert_is_current(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::version_of(arg1));
        assert!(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_vault_id(arg0) == 0x2::object::id<0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::PortfolioVault>(arg1), 1);
        assert!(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_allowed_actions(arg0) & 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::action_lend() != 0, 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_assert_token_allowed(arg0, v0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, v1, arg4, arg2, arg5);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::assert_price_is_fresh<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v3, arg4);
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_add_settled(arg0, 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::math::from_suilend_decimal_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_market_value_lower_bound<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v3, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&v2))));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, v1, 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::borrow_obligation_cap(arg1), arg4, v2, arg5);
        let v4 = LendSupplied{
            vault_id  : 0x2::object::id<0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::PortfolioVault>(arg1),
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<LendSupplied>(v4);
    }

    public fun withdraw<T0>(arg0: &mut 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::RebalanceProof, arg1: &mut 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::PortfolioVault, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::version::assert_is_current(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::version_of(arg1));
        assert!(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_vault_id(arg0) == 0x2::object::id<0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::PortfolioVault>(arg1), 1);
        assert!(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_allowed_actions(arg0) & 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::action_lend() != 0, 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_assert_token_allowed(arg0, v0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, v1, 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::borrow_obligation_cap(arg1), arg4, arg3, arg5);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::assert_price_is_fresh<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v3, arg4);
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_add_debt(arg0, 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::math::from_suilend_decimal_ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_market_value_upper_bound<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v3, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&v2))));
        assert!(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_debt_value(arg0) <= 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_notional_ceiling(arg0), 3);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, v1, arg4, v2, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg5);
        let v5 = LendWithdrawn{
            vault_id  : 0x2::object::id<0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault::PortfolioVault>(arg1),
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&v4),
        };
        0x2::event::emit<LendWithdrawn>(v5);
        v4
    }

    // decompiled from Move bytecode v7
}

