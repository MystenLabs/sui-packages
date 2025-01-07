module 0x832e20550ecc8472d573de0b31cdc05b00269440a61f80382beb0b0daa73f4c0::order_depth_display {
    struct AskOrderDepthEvent has copy, drop {
        prices: vector<u64>,
        depths: vector<u64>,
    }

    struct BidOrderDepthEvent has copy, drop {
        prices: vector<u64>,
        depths: vector<u64>,
    }

    public entry fun display_ask_order_depth<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::get_level2_book_status_ask_side<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = AskOrderDepthEvent{
            prices : v0,
            depths : v1,
        };
        0x2::event::emit<AskOrderDepthEvent>(v2);
    }

    public entry fun display_bid_order_depth<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::get_level2_book_status_bid_side<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = BidOrderDepthEvent{
            prices : v0,
            depths : v1,
        };
        0x2::event::emit<BidOrderDepthEvent>(v2);
    }

    public entry fun display_order_depth<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        display_ask_order_depth<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        display_bid_order_depth<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

