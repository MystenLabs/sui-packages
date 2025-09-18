module 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        collateral_price: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal,
        debt_price: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal,
        seized_ctoken_amount: u64,
        seized_collateral_amount: u64,
        repay_amount: u64,
        timestamp: u64,
    }

    public fun liquidate<T0, T1, T2>(arg0: 0x2::object::ID, arg1: &mut 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0xc17d1d88270b8fabfc423a8000c21a8d265b356b83bc2df9418c55560803ad3a::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::ensure_version_matches<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2) = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::handle_liquidation<T0, T1, T2>(arg1, arg0, arg2, arg3, arg4, arg5, v0, arg6);
        let v3 = v1;
        let v4 = LiquidateEvent{
            liquidator               : 0x2::tx_context::sender(arg6),
            market                   : 0x1::type_name::get<T0>(),
            obligation               : arg0,
            debt_type                : 0x1::type_name::get<T1>(),
            collateral_type          : 0x1::type_name::get<T2>(),
            collateral_price         : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::value::get_price(arg4, 0x1::type_name::get<T2>(), arg5),
            debt_price               : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::value::get_price(arg4, 0x1::type_name::get<T1>(), arg5),
            seized_ctoken_amount     : v2,
            seized_collateral_amount : 0x2::coin::value<T2>(&v3),
            repay_amount             : 0x2::coin::value<T1>(&arg2),
            timestamp                : v0,
        };
        0x2::event::emit<LiquidateEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v3, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

