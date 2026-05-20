module 0x4b06f0c678001d9ce9da8340222905f0fc241ee8800894dd97bf414d08a7ac83::fetcher {
    struct IndexedTick has copy, drop {
        index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        liquidity_net: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::I128,
        liquidity_gross: u128,
    }

    public fun fetch_indexed_ticks<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: u32, arg2: u64) : vector<IndexedTick> {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(arg0);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v2 = 0x1::vector::empty<IndexedTick>();
        let v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from_u32(arg1);
        if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::is_initialized(v0, v3)) {
            0x1::vector::push_back<IndexedTick>(&mut v2, read_tick(v0, v3));
        };
        while (0x1::vector::length<IndexedTick>(&v2) < arg2) {
            let (v4, v5) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(v1, v3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(arg0), false);
            if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lte(v4, v3)) {
                break
            };
            if (v5 && 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::is_initialized(v0, v4)) {
                0x1::vector::push_back<IndexedTick>(&mut v2, read_tick(v0, v4));
            };
            v3 = v4;
        };
        v2
    }

    public fun fetch_ticks<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: u32, arg2: u64) : vector<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::TickInfo> {
        0x1::vector::empty<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::TickInfo>()
    }

    fun read_tick(arg0: &0x2::table::Table<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::TickInfo>, arg1: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32) : IndexedTick {
        IndexedTick{
            index           : arg1,
            liquidity_net   : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(arg0, arg1),
            liquidity_gross : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_gross(arg0, arg1),
        }
    }

    // decompiled from Move bytecode v7
}

