module 0xa3da93ff9c8afa3cfb578e4e3157a35c633788c86f9b1c8c31e2aade3d03c592::mmt_tick_lens {
    struct Tick has copy, drop, store {
        index: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        info: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::TickInfo,
    }

    public fun get_all_ticks<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : vector<Tick> {
        let v0 = 0x1::vector::empty<Tick>();
        0x1::vector::append<Tick>(&mut v0, get_initialized_ticks<T0, T1>(arg0, arg1, arg2, true));
        0x1::vector::append<Tick>(&mut v0, get_initialized_ticks<T0, T1>(arg0, arg1, arg2, false));
        v0
    }

    public fun get_initialized_ticks<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) : vector<Tick> {
        let v0 = 0x1::vector::empty<Tick>();
        let v1 = 0;
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg0);
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0);
        while (0x1::vector::length<Tick>(&v0) < arg1 && v1 < arg2) {
            v1 = v1 + 1;
            let (v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_bitmap::next_initialized_tick_within_one_word(v3, v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0), arg3);
            if (arg3 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lt(v5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_tick()) || 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gt(v5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_tick())) {
                break
            };
            let v7 = if (arg3) {
                0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1))
            } else {
                v5
            };
            v2 = v7;
            if (v6) {
                let v8 = Tick{
                    index : v5,
                    info  : *0x2::table::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::TickInfo>(v4, v5),
                };
                0x1::vector::push_back<Tick>(&mut v0, v8);
            };
        };
        v0
    }

    // decompiled from Move bytecode v7
}

