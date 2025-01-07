module 0x807f5d7ddb96e7c1d0755d6e4e2812cddda0e8083c9376c2b333eccc25112ad6::try {
    struct BoardInfoEvent has copy, drop {
        price_list: vector<u64>,
        depth_list: vector<u64>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun print_vec<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::get_level2_book_status_bid_side<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = BoardInfoEvent{
            price_list : v0,
            depth_list : v1,
        };
        0x2::event::emit<BoardInfoEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

