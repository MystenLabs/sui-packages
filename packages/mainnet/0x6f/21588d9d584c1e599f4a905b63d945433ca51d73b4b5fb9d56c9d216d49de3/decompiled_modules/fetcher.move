module 0x79b2bd855e6e20eaafe7b06cc518c226aeb076c281ec7940448be54e3320cfba::fetcher {
    struct Tick has copy, drop, store {
        index: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32,
        info: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::TickInfo,
    }

    public fun fetch_ticks<T0, T1>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: u32, arg2: u64) : vector<Tick> {
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::borrow_ticks<T0, T1>(arg0);
        let v1 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v2 = 0x1::vector::empty<Tick>();
        let v3 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from_u32(arg1);
        if (0x2::table::contains<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::TickInfo>(v0, v3)) {
            let v4 = Tick{
                index : v3,
                info  : *0x2::table::borrow<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::TickInfo>(v0, v3),
            };
            0x1::vector::push_back<Tick>(&mut v2, v4);
        };
        while (0x1::vector::length<Tick>(&v2) < arg2 && 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::lt(v3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::max_tick())) {
            let (v5, v6) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_bitmap::next_initialized_tick_within_one_word(v1, v3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg0), false);
            if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::lte(v5, v3)) {
                break
            };
            if (v6 && 0x2::table::contains<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::TickInfo>(v0, v5)) {
                let v7 = Tick{
                    index : v5,
                    info  : *0x2::table::borrow<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::TickInfo>(v0, v5),
                };
                0x1::vector::push_back<Tick>(&mut v2, v7);
            };
            v3 = v5;
        };
        v2
    }

    public fun index(arg0: &Tick) : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32 {
        arg0.index
    }

    public fun info(arg0: &Tick) : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::TickInfo {
        arg0.info
    }

    // decompiled from Move bytecode v7
}

