module 0xd88ebdabeaead893d6ce24259bf596627ff4d209b9e1541c2eb7997fa90651d2::flowx {
    struct FlowXPoolTick has copy, drop {
        index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        liquidity_net: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::I128,
        liquidity_gross: u128,
    }

    struct FlowXPoolStatus has copy, drop {
        index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        sqrt_price: u128,
    }

    public entry fun fetcher<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: vector<u32>) {
        let v0 = 0;
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(arg0);
        while (v0 < 0x1::vector::length<u32>(&arg1)) {
            let v2 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, v0));
            let v3 = FlowXPoolTick{
                index           : v2,
                liquidity_net   : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(v1, v2),
                liquidity_gross : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_gross(v1, v2),
            };
            0x2::event::emit<FlowXPoolTick>(v3);
            v0 = v0 + 1;
        };
        let v4 = FlowXPoolStatus{
            index      : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_index_current<T0, T1>(arg0),
            sqrt_price : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0),
        };
        0x2::event::emit<FlowXPoolStatus>(v4);
    }

    // decompiled from Move bytecode v6
}

