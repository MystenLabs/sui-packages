module 0x56ac05546dab0849eab3f80632033ad8be3705b3bf2ebcb563a047a36a6fdd88::wrtest {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Wrapper<phantom T0> has store, key {
        id: 0x2::object::UID,
        ooc: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
    }

    struct WRTEST has drop {
        dummy_field: bool,
    }

    public fun deposit<T0, T1>(arg0: &Wrapper<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg2, &arg0.ooc, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg2, arg4, arg3, arg5), arg5);
    }

    public entry fun extract_ooc<T0>(arg0: Wrapper<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Wrapper {
            id  : v0,
            ooc : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: WRTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::package::claim_and_keep<WRTEST>(arg0, arg1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_wrapper<T0>(arg0: &AdminCap, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Wrapper<T0>{
            id  : 0x2::object::new(arg2),
            ooc : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg1, arg2),
        };
        0x2::transfer::public_transfer<Wrapper<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun withdraw<T0, T1>(arg0: &Wrapper<T0>, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg3, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T1>(arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T1>(arg2, arg3, arg6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg2, arg3, &arg0.ooc, arg6, arg1, arg8), arg4, arg8), arg8), 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

