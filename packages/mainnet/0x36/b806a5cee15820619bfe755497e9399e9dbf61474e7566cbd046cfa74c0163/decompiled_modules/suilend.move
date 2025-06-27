module 0x36b806a5cee15820619bfe755497e9399e9dbf61474e7566cbd046cfa74c0163::suilend {
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

    fun borrow_obligation_cap(arg0: &SuilendMarginAccount, arg1: &SuilendMarginAccountCap) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL> {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.suilend_margin_account_id, 0);
        &arg0.obligation_cap
    }

    public fun deposit_collateral<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &SuilendMarginAccount, arg2: &SuilendMarginAccountCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, v0, borrow_obligation_cap(arg1, arg2), arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, v0, arg4, arg3, arg5), arg5);
    }

    public fun link_suilend_margin_account(arg0: &0x36b806a5cee15820619bfe755497e9399e9dbf61474e7566cbd046cfa74c0163::rfq_account::AccountCap, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x2::tx_context::TxContext) : SuilendMarginAccountCap {
        let v0 = SuilendMarginAccount{
            id             : 0x2::object::new(arg2),
            rfq_account_id : 0x36b806a5cee15820619bfe755497e9399e9dbf61474e7566cbd046cfa74c0163::rfq_account::account_cap_rfq_account_id(arg0),
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

    public fun new_suilend_margin_account(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: vector<u8>, arg2: &0x36b806a5cee15820619bfe755497e9399e9dbf61474e7566cbd046cfa74c0163::risk_params::RiskParams, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x36b806a5cee15820619bfe755497e9399e9dbf61474e7566cbd046cfa74c0163::rfq_account::AccountCap, SuilendMarginAccountCap) {
        let v0 = 0x36b806a5cee15820619bfe755497e9399e9dbf61474e7566cbd046cfa74c0163::rfq_account::create_rfq_account(arg1, arg2, arg3, arg4);
        (v0, link_suilend_margin_account(&v0, arg0, arg4))
    }

    // decompiled from Move bytecode v6
}

