module 0xfd149a51106dba9ba6568a2ba30aa9e496fa56040bf97bc98ca4a3b1aa3bef8::flowx_tick_util {
    struct TickData has copy, drop, store {
        tick_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        liquidity_gross: u128,
        liquidity_net: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::I128,
    }

    struct SurroundingTicksEvent has copy, drop {
        current_tick: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        ticks_up: vector<TickData>,
        ticks_down: vector<TickData>,
    }

    fun create_tick_data(arg0: &0x2::table::Table<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::TickInfo>, arg1: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32) : TickData {
        TickData{
            tick_index      : arg1,
            liquidity_gross : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_gross(arg0, arg1),
            liquidity_net   : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(arg0, arg1),
        }
    }

    public entry fun get_surrounding_ticks<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: u64) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_index_current<T0, T1>(arg0);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(arg0);
        let v2 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(arg0);
        let v4 = 0x1::vector::empty<TickData>();
        let v5 = 0x1::vector::empty<TickData>();
        let v6 = 0;
        let v7 = v0;
        while (v6 < arg1) {
            let (v8, v9) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(v2, v7, v1, false);
            if (!v9 || 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::eq(v8, v7)) {
                break
            };
            if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::is_initialized(v3, v8)) {
                0x1::vector::push_back<TickData>(&mut v4, create_tick_data(v3, v8));
                v6 = v6 + 1;
            };
            v7 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::add(v8, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(1));
        };
        v6 = 0;
        v7 = v0;
        while (v6 < arg1) {
            let (v10, v11) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(v2, v7, v1, true);
            if (!v11 || 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::eq(v10, v7)) {
                break
            };
            if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::is_initialized(v3, v10)) {
                0x1::vector::push_back<TickData>(&mut v5, create_tick_data(v3, v10));
                v6 = v6 + 1;
            };
            v7 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::sub(v10, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(1));
        };
        let v12 = SurroundingTicksEvent{
            current_tick : v0,
            ticks_up     : v4,
            ticks_down   : v5,
        };
        0x2::event::emit<SurroundingTicksEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

