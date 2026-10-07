module 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::lend_adapter {
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

    fun assert_market_matches<T0>(arg0: &0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        assert!(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::lending_market_id(arg0) == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1), 5);
    }

    fun assert_not_sui<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 7);
    }

    public fun claim_lend_rewards<T0>(arg0: &0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::owner_address(arg0), 4);
        assert_market_matches<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::borrow_obligation_cap(arg0), arg2, arg3, arg4, arg5, arg6), 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::owner_address(arg0));
    }

    fun credit_vault<T0>(arg0: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg1: 0x2::coin::Coin<T0>) {
        0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::put_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        let v0 = LendWithdrawn{
            vault_id  : 0x2::object::id<0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<LendWithdrawn>(v0);
    }

    public fun emergency_withdraw_lend<T0>(arg0: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_sui<T0>();
        let v0 = withdraw_all_ctokens_for_owner<T0>(arg0, arg1, arg2, arg3);
        send_to_owner<T0>(arg0, redeem<T0>(arg1, arg2, v0, arg3));
    }

    public fun emergency_withdraw_lend_sui(arg0: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_all_ctokens_for_owner<0x2::sui::SUI>(arg0, arg1, arg2, arg4);
        send_to_owner<0x2::sui::SUI>(arg0, redeem_sui(arg1, arg2, v0, arg3, arg4));
    }

    fun redeem<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0), arg1, arg2, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg3)
    }

    fun redeem_sui(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg0, v0, arg1, arg2, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(), arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, v0, &v1, arg3, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg0, v0, v1, arg4)
    }

    fun send_to_owner<T0>(arg0: &0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg1: 0x2::coin::Coin<T0>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::owner_address(arg0));
        let v0 = LendEmergencyWithdrawn{
            vault_id  : 0x2::object::id<0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<LendEmergencyWithdrawn>(v0);
    }

    public fun supply<T0>(arg0: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::RebalanceProof, arg1: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::version::assert_is_current(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::version_of(arg1));
        assert!(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_vault_id(arg0) == 0x2::object::id<0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault>(arg1), 1);
        assert_market_matches<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, arg3);
        0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::assert_holds_obligation_cap(arg1);
        assert!(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_allowed_actions(arg0) & 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::action_lend() != 0, 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_assert_token_allowed(arg0, v0);
        let v1 = 0x2::coin::value<T0>(&arg2);
        if (0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_allowed_actions(arg0) & 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::action_swap() == 0) {
            assert!(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_spend_extracted(arg0, v0, v1), 6);
        };
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, v2, arg4, arg2, arg5);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::assert_price_is_fresh<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v4, arg4);
        0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_add_settled(arg0, 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::math::from_suilend_decimal_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_market_value_lower_bound<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v4, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&v3))));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, v2, 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::borrow_obligation_cap(arg1), arg4, v3, arg5);
        let v5 = LendSupplied{
            vault_id  : 0x2::object::id<0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault>(arg1),
            coin_type : v0,
            amount    : v1,
        };
        0x2::event::emit<LendSupplied>(v5);
    }

    public fun withdraw<T0>(arg0: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::RebalanceProof, arg1: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_not_sui<T0>();
        let v0 = withdraw_ctokens_as_debt<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = redeem<T0>(arg2, arg4, v0, arg5);
        let v2 = LendWithdrawn{
            vault_id  : 0x2::object::id<0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault>(arg1),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<LendWithdrawn>(v2);
        v1
    }

    fun withdraw_all_ctokens_for_owner<T0>(arg0: &0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>> {
        assert!(0x2::tx_context::sender(arg3) == 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::owner_address(arg0), 4);
        assert_market_matches<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1), 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::borrow_obligation_cap(arg0), arg2, 18446744073709551615, arg3)
    }

    fun withdraw_ctokens_as_debt<T0>(arg0: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::RebalanceProof, arg1: &0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>> {
        0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::version::assert_is_current(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::version_of(arg1));
        assert!(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_vault_id(arg0) == 0x2::object::id<0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault>(arg1), 1);
        assert_market_matches<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, arg2);
        let v0 = 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::action_lend() | 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::action_swap();
        assert!(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_allowed_actions(arg0) & v0 == v0, 2);
        0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_assert_token_allowed(arg0, 0x1::type_name::with_defining_ids<T0>());
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2), 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::borrow_obligation_cap(arg1), arg4, arg3, arg5);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::assert_price_is_fresh<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v2, arg4);
        0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_add_debt(arg0, 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::math::from_suilend_decimal_ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_market_value_upper_bound<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v2, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&v1))));
        assert!(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_debt_value(arg0) <= 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_notional_ceiling(arg0), 3);
        v1
    }

    fun withdraw_ctokens_to_unwind<T0>(arg0: &0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::RebalanceProof, arg1: &0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>> {
        0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::version::assert_is_current(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::version_of(arg1));
        assert!(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_vault_id(arg0) == 0x2::object::id<0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault>(arg1), 1);
        assert_market_matches<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, arg2);
        assert!(0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_allowed_actions(arg0) & 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::action_lend() != 0, 2);
        0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::proof_assert_token_allowed(arg0, 0x1::type_name::with_defining_ids<T0>());
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2), 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::borrow_obligation_cap(arg1), arg4, arg3, arg5)
    }

    public fun withdraw_sui(arg0: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::RebalanceProof, arg1: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = withdraw_ctokens_as_debt<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg6);
        let v1 = redeem_sui(arg2, arg4, v0, arg5, arg6);
        let v2 = LendWithdrawn{
            vault_id  : 0x2::object::id<0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault>(arg1),
            coin_type : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            amount    : 0x2::coin::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<LendWithdrawn>(v2);
        v1
    }

    public fun withdraw_to_vault<T0>(arg0: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::RebalanceProof, arg1: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_sui<T0>();
        let v0 = withdraw_ctokens_to_unwind<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        credit_vault<T0>(arg1, redeem<T0>(arg2, arg4, v0, arg5));
    }

    public fun withdraw_to_vault_sui(arg0: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::session::RebalanceProof, arg1: &mut 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::vault::PortfolioVault, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_ctokens_to_unwind<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg6);
        credit_vault<0x2::sui::SUI>(arg1, redeem_sui(arg2, arg4, v0, arg5, arg6));
    }

    // decompiled from Move bytecode v7
}

