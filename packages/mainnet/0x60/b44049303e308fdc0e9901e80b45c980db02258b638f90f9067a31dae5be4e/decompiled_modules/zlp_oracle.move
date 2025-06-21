module 0x60b44049303e308fdc0e9901e80b45c980db02258b638f90f9067a31dae5be4e::zlp_oracle {
    struct PriceTicketCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    public fun get_exchange_rate_from_zlp<T0: drop>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation, arg2: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SymbolsValuation, arg3: &0x2::tx_context::TxContext) : u128 {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::to_raw(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::to_rate(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::calculate_market_lp_price<T0>(arg0, arg1, arg2)))
    }

    // decompiled from Move bytecode v6
}

