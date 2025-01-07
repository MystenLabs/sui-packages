module 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::ob_trade {
    struct OB_LIST_EVENT has copy, drop, store {
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun ob_list<T0: store + key, T1>(arg0: &mut 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::create_ask_with_commission<T0, T1>(arg0, arg1, arg2, arg3, @0x8084455a96bdde21edd8fe48ec3f15dbe1c82b2ee2e0e963d800f3d7d8fbbcd5, arg2 * 250 / 10000, arg4);
        let v0 = OB_LIST_EVENT{
            seller          : 0x2::tx_context::sender(arg4),
            seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id          : arg3,
            amount          : arg2,
        };
        0x2::event::emit<OB_LIST_EVENT>(v0);
    }

    // decompiled from Move bytecode v6
}

