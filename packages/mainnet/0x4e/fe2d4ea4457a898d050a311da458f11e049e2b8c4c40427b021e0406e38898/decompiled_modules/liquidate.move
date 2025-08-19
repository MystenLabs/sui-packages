module 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        collateral_price: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        debt_price: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        timestamp: u64,
    }

    public fun liquidate<T0, T1, T2>(arg0: 0x2::object::ID, arg1: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg6),
            market           : 0x1::type_name::get<T0>(),
            obligation       : arg0,
            debt_type        : 0x1::type_name::get<T1>(),
            collateral_type  : 0x1::type_name::get<T2>(),
            collateral_price : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::get_price(arg4, 0x1::type_name::get<T2>(), arg5),
            debt_price       : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::get_price(arg4, 0x1::type_name::get<T1>(), arg5),
            timestamp        : v0,
        };
        0x2::event::emit<LiquidateEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::handle_liquidation<T0, T1, T2>(arg1, arg0, arg2, arg3, arg4, arg5, v0, arg6), 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

