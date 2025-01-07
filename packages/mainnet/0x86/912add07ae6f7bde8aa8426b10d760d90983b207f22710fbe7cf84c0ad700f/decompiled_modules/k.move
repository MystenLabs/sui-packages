module 0x86912add07ae6f7bde8aa8426b10d760d90983b207f22710fbe7cf84c0ad700f::k {
    struct Tick has copy, drop, store {
        index: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32,
        liquidity_gross: u128,
        liquidity_net: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i128::I128,
    }

    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<Tick>,
    }

    public fun fts<T0, T1>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) : u64 {
        let v0 = if (0x1::vector::is_empty<u32>(&arg1)) {
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::neg_from(443636 + 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg0))
        } else {
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, 0))
        };
        let v1 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg0));
        let v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::shr(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::add(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::div(v0, v1), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(1)), 8);
        let v3 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v4 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::borrow_ticks<T0, T1>(arg0);
        let v5 = 0x1::vector::empty<Tick>();
        let v6 = 0;
        let v7 = false;
        let v8 = 0;
        while (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::lte(v2, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::shr(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::div(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from_u32(443636), v1), 8))) {
            if (0x2::table::contains<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, u256>(v3, v2)) {
                let v9 = 0;
                while (v9 <= 255) {
                    if (*0x2::table::borrow<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, u256>(v3, v2) & 1 << v9 != 0) {
                        let v10 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::mul(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::add(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::shl(v2, 8), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from((v9 as u32))), v1);
                        if (v7 || 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::lt(v0, v10)) {
                            let v11 = Tick{
                                index           : v10,
                                liquidity_gross : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::get_liquidity_gross(v4, v10),
                                liquidity_net   : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::get_liquidity_net(v4, v10),
                            };
                            0x1::vector::push_back<Tick>(&mut v5, v11);
                            let v12 = v6 + 1;
                            v6 = v12;
                            if (v12 == arg2) {
                                break
                            };
                            v7 = true;
                        };
                    };
                    if (v9 == 255) {
                        break
                    };
                    v9 = v9 + 1;
                };
            };
            let v13 = v8 + 1;
            v8 = v13;
            if (v6 == arg2) {
                break
            };
            v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::add(v2, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(1));
            if (v13 >= 500) {
                let v14 = Tick{
                    index           : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::mul(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::shl(v2, 8), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(1)), v1),
                    liquidity_gross : 0,
                    liquidity_net   : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i128::zero(),
                };
                0x1::vector::push_back<Tick>(&mut v5, v14);
                break
            };
        };
        let v15 = FetchTicksResultEvent{ticks: v5};
        0x2::event::emit<FetchTicksResultEvent>(v15);
        v8
    }

    // decompiled from Move bytecode v6
}

