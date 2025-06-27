module 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::suilend {
    struct EventNewSuilendMarginAccount has copy, drop {
        suilend_margin_account_id: 0x2::object::ID,
        suilend_margin_account_cap_id: 0x2::object::ID,
    }

    struct SuilendMarginAccount has key {
        id: 0x2::object::UID,
        rfq_account_id: 0x2::object::ID,
        obligation_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>,
    }

    struct SuilendMarginAccountCap has store, key {
        id: 0x2::object::UID,
        suilend_margin_account_id: 0x2::object::ID,
    }

    public fun swap<T0, T1>(arg0: &SuilendMarginAccount, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::rfq_account::Account, arg3: &mut 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::rfq_account::NonceLane, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(rfq_account_id(arg0) == 0x2::object::id<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::rfq_account::Account>(arg2), 0);
        0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::rfq_account::validate<T1, T0>(arg2, arg3, arg6, 0x2::coin::value<T0>(&arg7), arg4, arg5, arg8);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.obligation_cap);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v1, v0, arg8, &mut arg7, arg9);
        if (0x2::coin::value<T0>(&arg7) != 0) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v1, &arg0.obligation_cap, arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v1, arg8, arg7, arg9), arg9);
        } else {
            0x2::coin::destroy_zero<T0>(arg7);
        };
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg1);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, v0));
        let v4 = tokens_to_ctokens<T1>(arg1, v2, arg6, arg8);
        let v5 = 0x2::coin::zero<T1>(arg9);
        if (v3 != 0) {
            0x2::coin::join<T1>(&mut v5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg1, v2, arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg1, v2, &arg0.obligation_cap, arg8, 0x1::u64::min(v4, v3), arg9), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(), arg9));
        };
        let v6 = arg6 - 0x2::coin::value<T1>(&v5);
        if (v6 != 0) {
            0x2::coin::join<T1>(&mut v5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg1, v2, &arg0.obligation_cap, arg8, v6, arg9));
        };
        v5
    }

    fun assert_obligation_cap(arg0: &SuilendMarginAccount, arg1: &SuilendMarginAccountCap) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.suilend_margin_account_id, 0);
    }

    fun borrow_obligation_cap(arg0: &SuilendMarginAccount, arg1: &SuilendMarginAccountCap) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL> {
        assert_obligation_cap(arg0, arg1);
        &arg0.obligation_cap
    }

    public fun deposit_collateral<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &SuilendMarginAccount, arg2: &SuilendMarginAccountCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, v0, borrow_obligation_cap(arg1, arg2), arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, v0, arg4, arg3, arg5), arg5);
    }

    public fun destroy_suilend_margin_account(arg0: SuilendMarginAccount, arg1: SuilendMarginAccountCap) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL> {
        assert_obligation_cap(&arg0, &arg1);
        let SuilendMarginAccountCap {
            id                        : v0,
            suilend_margin_account_id : _,
        } = arg1;
        0x2::object::delete(v0);
        let SuilendMarginAccount {
            id             : v2,
            rfq_account_id : _,
            obligation_cap : v4,
        } = arg0;
        0x2::object::delete(v2);
        v4
    }

    public fun link_suilend_margin_account(arg0: &0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::rfq_account::AccountCap, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x2::tx_context::TxContext) : SuilendMarginAccountCap {
        let v0 = SuilendMarginAccount{
            id             : 0x2::object::new(arg2),
            rfq_account_id : 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::rfq_account::account_cap_rfq_account_id(arg0),
            obligation_cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, arg2),
        };
        let v1 = SuilendMarginAccountCap{
            id                        : 0x2::object::new(arg2),
            suilend_margin_account_id : 0x2::object::uid_to_inner(&v0.id),
        };
        let v2 = EventNewSuilendMarginAccount{
            suilend_margin_account_id     : 0x2::object::uid_to_inner(&v0.id),
            suilend_margin_account_cap_id : 0x2::object::uid_to_inner(&v1.id),
        };
        0x2::event::emit<EventNewSuilendMarginAccount>(v2);
        0x2::transfer::share_object<SuilendMarginAccount>(v0);
        v1
    }

    public fun new_suilend_margin_account(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: vector<u8>, arg2: &0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::risk_params::RiskParams, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::rfq_account::AccountCap, SuilendMarginAccountCap) {
        let v0 = 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::rfq_account::create_rfq_account(arg1, arg2, arg3, arg4);
        (v0, link_suilend_margin_account(&v0, arg0, arg4))
    }

    fun rfq_account_id(arg0: &SuilendMarginAccount) : 0x2::object::ID {
        arg0.rfq_account_id
    }

    fun tokens_to_ctokens<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::compound_interest<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg1, arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0))))
    }

    // decompiled from Move bytecode v6
}

