module 0x238cb6a24b7a2e3ffb3bbba0f245b8ce806e1025bedcab9321f3dddeed2f6f1a::suilend {
    struct Deposited has copy, drop {
        protocol: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdrawed has copy, drop {
        protocol: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun deposit<T0, T1>(arg0: &mut 0x238cb6a24b7a2e3ffb3bbba0f245b8ce806e1025bedcab9321f3dddeed2f6f1a::fund::Take_1_Liquidity_For_1_Liquidity_Request<T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        let v0 = Deposited{
            protocol  : 0x1::string::utf8(b"Suilend"),
            coin_type : 0x1::type_name::get<T1>(),
            amount    : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<Deposited>(v0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg3, arg4, arg1, arg5);
        0x238cb6a24b7a2e3ffb3bbba0f245b8ce806e1025bedcab9321f3dddeed2f6f1a::fund::supported_defi_confirm_1l_for_1l<T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg0, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v1));
        v1
    }

    public fun withdraw<T0, T1>(arg0: &mut 0x238cb6a24b7a2e3ffb3bbba0f245b8ce806e1025bedcab9321f3dddeed2f6f1a::fund::Take_1_Liquidity_For_1_Liquidity_Request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>, T1>, arg1: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg3, arg4, arg1, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5);
        0x238cb6a24b7a2e3ffb3bbba0f245b8ce806e1025bedcab9321f3dddeed2f6f1a::fund::supported_defi_confirm_1l_for_1l<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>, T1>(arg0, 0x2::coin::value<T1>(&v0));
        let v1 = Withdrawed{
            protocol  : 0x1::string::utf8(b"Suilend"),
            coin_type : 0x1::type_name::get<T1>(),
            amount    : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<Withdrawed>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

