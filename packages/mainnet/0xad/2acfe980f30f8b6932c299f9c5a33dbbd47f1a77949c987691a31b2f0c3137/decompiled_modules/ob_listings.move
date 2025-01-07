module 0xad2acfe980f30f8b6932c299f9c5a33dbbd47f1a77949c987691a31b2f0c3137::ob_listings {
    public fun list<T0: store + key, T1>(arg0: &mut 0xad2acfe980f30f8b6932c299f9c5a33dbbd47f1a77949c987691a31b2f0c3137::marketplace::MarketPlace, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::TradeInfo> {
        let (v0, v1) = 0xad2acfe980f30f8b6932c299f9c5a33dbbd47f1a77949c987691a31b2f0c3137::marketplace::get_market_fee(arg0, arg3);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::create_ask_with_commission<T0, T1>(arg1, arg2, arg3, arg4, v1, v0, arg5)
    }

    // decompiled from Move bytecode v6
}

