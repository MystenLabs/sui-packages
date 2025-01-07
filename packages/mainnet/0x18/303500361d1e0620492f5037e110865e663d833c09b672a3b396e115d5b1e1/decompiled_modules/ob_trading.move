module 0x18303500361d1e0620492f5037e110865e663d833c09b672a3b396e115d5b1e1::ob_trading {
    public fun accept_collection_bid<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::market_sell<T0, T1>(arg0, arg1, arg3, arg4, arg5);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::finish_trade<T0, T1>(arg0, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::trade_id(&v0), arg1, arg2, arg5)
    }

    public fun accept_token_bid<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding::Bid<T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding::sell_nft_from_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun buy<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::buy_nft<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cancel_collection_bid<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::cancel_bid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun cancel_token_bid<T0>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding::Bid<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding::close_bid<T0>(arg0, arg1);
    }

    public fun collection_bid<T0: store + key, T1>(arg0: &mut 0x18303500361d1e0620492f5037e110865e663d833c09b672a3b396e115d5b1e1::marketplace::MarketPlace, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::TradeInfo> {
        let (v0, v1) = 0x18303500361d1e0620492f5037e110865e663d833c09b672a3b396e115d5b1e1::marketplace::get_market_fee(arg0, arg3);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::create_bid_with_commission<T0, T1>(arg1, arg2, arg3, v1, v0, arg4, arg5)
    }

    public fun list<T0: store + key, T1>(arg0: &mut 0x18303500361d1e0620492f5037e110865e663d833c09b672a3b396e115d5b1e1::marketplace::MarketPlace, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::TradeInfo> {
        let (v0, v1) = 0x18303500361d1e0620492f5037e110865e663d833c09b672a3b396e115d5b1e1::marketplace::get_market_fee(arg0, arg3);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::create_ask_with_commission<T0, T1>(arg1, arg2, arg3, arg4, v1, v0, arg5)
    }

    public fun token_bid<T0>(arg0: &mut 0x18303500361d1e0620492f5037e110865e663d833c09b672a3b396e115d5b1e1::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = 0x18303500361d1e0620492f5037e110865e663d833c09b672a3b396e115d5b1e1::marketplace::get_market_fee(arg0, arg3);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding::create_bid_with_commission<T0>(arg1, arg2, arg3, v1, v0, arg4, arg5)
    }

    public fun unlist<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::cancel_ask<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

