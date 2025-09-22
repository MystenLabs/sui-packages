module 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        collateral_price: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        debt_price: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        seized_ctoken_amount: u64,
        seized_collateral_amount: u64,
        repay_amount: u64,
        timestamp: u64,
    }

    public fun liquidate<T0, T1, T2>(arg0: 0x2::object::ID, arg1: &mut 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::ensure_version_matches<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2) = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::handle_liquidation<T0, T1, T2>(arg1, arg0, arg2, arg3, arg4, arg5, v0, arg6);
        let v3 = v1;
        let v4 = LiquidateEvent{
            liquidator               : 0x2::tx_context::sender(arg6),
            market                   : 0x1::type_name::get<T0>(),
            obligation               : arg0,
            debt_type                : 0x1::type_name::get<T1>(),
            collateral_type          : 0x1::type_name::get<T2>(),
            collateral_price         : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::value::get_price(arg4, 0x1::type_name::get<T2>(), arg5),
            debt_price               : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::value::get_price(arg4, 0x1::type_name::get<T1>(), arg5),
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

