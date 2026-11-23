module 0x40430d8aa03a2bb4250d96d114398ae2e85f1288f5166a5dd37f8590825f511c::tradeport_market {
    struct TradePortMarket has drop {
        dummy_field: bool,
    }

    public fun buy<T0: store + key>(arg0: &0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::platform::Platform, arg1: &mut 0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::Pool<0x2::sui::SUI>, arg2: &mut 0xff2251ea99230ed1cbe3a347a209352711c6723fcdcd9286e16636e65bb55cab::tradeport_listings::Store, arg3: &mut 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::tradeport_orderbook::Store, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: u64, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg4);
        let v1 = TradePortMarket{dummy_field: false};
        let (v2, v3, v4, v5) = 0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::nft::begin_purchase<0x2::sui::SUI, T0, TradePortMarket>(v1, arg0, arg1, 0x2::object::id_to_address(&v0), arg5, arg6, arg8, arg9, arg10);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg7, 0xff2251ea99230ed1cbe3a347a209352711c6723fcdcd9286e16636e65bb55cab::tradeport_listings::buy_ob_listing_with_transfer_policy<T0>(arg2, arg3, arg4, &mut v7, &v6, 0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::nft::purchase_owner<0x2::sui::SUI>(&v8), arg5, &mut v9, arg7, arg10));
        0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::nft::finish_purchase<0x2::sui::SUI, T0>(v8, arg0, arg1, v7, v6, v9, arg10);
    }

    // decompiled from Move bytecode v7
}

