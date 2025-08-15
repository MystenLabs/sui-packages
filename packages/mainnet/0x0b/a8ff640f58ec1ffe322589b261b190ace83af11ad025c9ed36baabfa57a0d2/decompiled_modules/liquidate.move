module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        collateral_price: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
        debt_price: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
        timestamp: u64,
    }

    public fun liquidate<T0, T1, T2>(arg0: 0x2::object::ID, arg1: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg6),
            market           : 0x1::type_name::get<T0>(),
            obligation       : arg0,
            debt_type        : 0x1::type_name::get<T1>(),
            collateral_type  : 0x1::type_name::get<T2>(),
            collateral_price : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::value::get_price(arg4, 0x1::type_name::get<T2>(), arg5),
            debt_price       : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::value::get_price(arg4, 0x1::type_name::get<T1>(), arg5),
            timestamp        : v0,
        };
        0x2::event::emit<LiquidateEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::handle_liquidation<T0, T1, T2>(arg1, arg0, arg2, arg3, arg4, arg5, v0, arg6), 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

