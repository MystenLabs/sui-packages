module 0xbd48cc1b10c10ee3b8bef2167d87018aee569581421d77aa7fd6b1419de49b64::suilend {
    struct Deposited has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        in_amount: u64,
        output_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    struct Withdrawed has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        in_amount: u64,
        output_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    public fun deposit<T0, T1>(arg0: &mut 0xbd48cc1b10c10ee3b8bef2167d87018aee569581421d77aa7fd6b1419de49b64::fund::Take_1_Liquidity_For_1_Liquidity_Request<T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg3, arg4, arg1, arg5);
        0xbd48cc1b10c10ee3b8bef2167d87018aee569581421d77aa7fd6b1419de49b64::fund::supported_defi_confirm_1l_for_1l<T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg0, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v0));
        let v1 = Deposited{
            protocol      : 0x1::string::utf8(b"Suilend"),
            fund          : 0xbd48cc1b10c10ee3b8bef2167d87018aee569581421d77aa7fd6b1419de49b64::fund::fund_id_of_1l_for_1l_req<T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg0),
            input_type    : 0x1::type_name::get<T1>(),
            in_amount     : 0x2::coin::value<T1>(&arg1),
            output_type   : 0x1::type_name::get<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(),
            output_amount : 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v0),
        };
        0x2::event::emit<Deposited>(v1);
        v0
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xbd48cc1b10c10ee3b8bef2167d87018aee569581421d77aa7fd6b1419de49b64::fund::Take_1_Liquidity_For_1_Liquidity_Request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>, T1>, arg1: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg3, arg4, arg1, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5);
        0xbd48cc1b10c10ee3b8bef2167d87018aee569581421d77aa7fd6b1419de49b64::fund::supported_defi_confirm_1l_for_1l<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>, T1>(arg0, 0x2::coin::value<T1>(&v0));
        let v1 = Withdrawed{
            protocol      : 0x1::string::utf8(b"Suilend"),
            fund          : 0xbd48cc1b10c10ee3b8bef2167d87018aee569581421d77aa7fd6b1419de49b64::fund::fund_id_of_1l_for_1l_req<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>, T1>(arg0),
            input_type    : 0x1::type_name::get<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(),
            in_amount     : 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg1),
            output_type   : 0x1::type_name::get<T1>(),
            output_amount : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<Withdrawed>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

