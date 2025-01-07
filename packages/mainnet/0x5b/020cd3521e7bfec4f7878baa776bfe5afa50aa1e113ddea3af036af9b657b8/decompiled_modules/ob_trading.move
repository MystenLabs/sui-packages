module 0x5b020cd3521e7bfec4f7878baa776bfe5afa50aa1e113ddea3af036af9b657b8::ob_trading {
    public fun list<T0: store + key, T1>(arg0: &mut 0x5b020cd3521e7bfec4f7878baa776bfe5afa50aa1e113ddea3af036af9b657b8::marketplace::MarketPlace, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::TradeInfo> {
        let (v0, v1) = 0x5b020cd3521e7bfec4f7878baa776bfe5afa50aa1e113ddea3af036af9b657b8::marketplace::get_market_fee(arg0, arg3);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::create_ask_with_commission<T0, T1>(arg1, arg2, arg3, arg4, v1, v0, arg5)
    }

    // decompiled from Move bytecode v6
}

