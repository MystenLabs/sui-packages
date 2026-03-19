module 0xda3ecbcef659dd428a5c7d4a0fac12831170752c6a105e7f2775fcb10398c190::suilend_adapter {
    struct SuilendAccount<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation_cap: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>,
    }

    struct SUILEND_ACCOUNT_FIELD has copy, drop, store {
        dummy_field: bool,
    }

    struct SuilendDepositEvent has copy, drop, store {
        array_index: u64,
        market_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        ctoken_amount: u64,
    }

    struct SuilendWithdrawEvent has copy, drop, store {
        array_index: u64,
        market_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        req_amount: u64,
        req_ctoken_amount: u64,
        actual_amount: u64,
        actual_ctoken_amount: u64,
    }

    struct SuilendClaimRewardsEvent has copy, drop, store {
        pool_reserve_id: u64,
        reward_index: u64,
        market_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SuilendAccountInitEvent has copy, drop, store {
        market_id: 0x2::object::ID,
        obligation_owner_cap_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
    }

    public(friend) fun claim_rewards<T0, T1, T2>(arg0: &SuilendAccount<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::array_index<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T2>(arg1, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligation_cap), arg2, v0, arg3, true, arg4);
        let v2 = SuilendClaimRewardsEvent{
            pool_reserve_id : v0,
            reward_index    : arg3,
            market_id       : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1),
            coin_type       : 0x1::type_name::with_defining_ids<T2>(),
            amount          : 0x2::coin::value<T2>(&v1),
        };
        0x2::event::emit<SuilendClaimRewardsEvent>(v2);
        v1
    }

    fun create_obligation<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg1)
    }

    public(friend) fun create_suilend_account<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : SuilendAccount<T0> {
        let v0 = create_obligation<T0>(arg0, arg1);
        let v1 = SuilendAccountInitEvent{
            market_id               : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg0),
            obligation_owner_cap_id : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&v0),
            obligation_id           : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v0),
        };
        0x2::event::emit<SuilendAccountInitEvent>(v1);
        SuilendAccount<T0>{
            id             : 0x2::object::new(arg1),
            obligation_cap : 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v0),
        }
    }

    public(friend) fun deposit<T0, T1>(arg0: &SuilendAccount<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg1);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, v0, arg3, arg2, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, v0, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligation_cap), arg3, v1, arg4);
        let v2 = SuilendDepositEvent{
            array_index   : v0,
            market_id     : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1),
            coin_type     : 0x1::type_name::with_defining_ids<T1>(),
            amount        : 0x2::coin::value<T1>(&arg2),
            ctoken_amount : 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v1),
        };
        0x2::event::emit<SuilendDepositEvent>(v2);
    }

    public(friend) fun suilend_account_field() : SUILEND_ACCOUNT_FIELD {
        SUILEND_ACCOUNT_FIELD{dummy_field: false}
    }

    public(friend) fun withdraw<T0, T1>(arg0: &SuilendAccount<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::array_index<T0>(v0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(v0)));
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, v1, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.obligation_cap), arg3, v2, arg4);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, v1, arg3, v3, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg4);
        let v5 = SuilendWithdrawEvent{
            array_index          : v1,
            market_id            : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1),
            coin_type            : 0x1::type_name::with_defining_ids<T1>(),
            req_amount           : arg2,
            req_ctoken_amount    : v2,
            actual_amount        : 0x2::coin::value<T1>(&v4),
            actual_ctoken_amount : 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v3),
        };
        0x2::event::emit<SuilendWithdrawEvent>(v5);
        v4
    }

    // decompiled from Move bytecode v6
}

