module 0x935c31aaf3bfa604f8c28f8bf87552e09371be06bd45ad4d3df492df28d8494c::kriya_clmm {
    public fun fetch_pool_snapshot<T0, T1>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u64>) : (u128, u32, u128, vector<u32>, vector<u128>, vector<u128>) {
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_index_current<T0, T1>(arg0);
        let (v1, v2, v3) = fetch_ticks_around<T0, T1>(arg0, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v0), 0x935c31aaf3bfa604f8c28f8bf87552e09371be06bd45ad4d3df492df28d8494c::clmm_common::resolve_tick_window(arg1, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg0)));
        (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::liquidity<T0, T1>(arg0), v1, v2, v3)
    }

    public fun fetch_ticks_around<T0, T1>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: u32, arg2: u64) : (vector<u32>, vector<u128>, vector<u128>) {
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from_u32(arg1);
        let v1 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::neg_from(443636);
        let v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(443636);
        let v3 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg0);
        let v4 = if (arg2 < 2) {
            2
        } else if (arg2 > 50) {
            50
        } else {
            arg2
        };
        let v5 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v6 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::borrow_ticks<T0, T1>(arg0);
        let v7 = 0x1::vector::empty<u32>();
        let v8 = 0x1::vector::empty<u128>();
        let v9 = 0x1::vector::empty<u128>();
        let v10 = v0;
        let v11 = 0;
        let v12 = 0;
        loop {
            let v13 = if (v11 < arg2) {
                if (v12 < v4) {
                    0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::gte(v10, v1)
                } else {
                    false
                }
            } else {
                false
            };
            if (v13) {
                let (v14, v15) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_bitmap::next_initialized_tick_within_one_word(v5, v10, v3, true);
                if (v15) {
                    0x1::vector::push_back<u32>(&mut v7, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v14));
                    0x1::vector::push_back<u128>(&mut v8, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i128::as_u128(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::get_liquidity_net(v6, v14)));
                    0x1::vector::push_back<u128>(&mut v9, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::get_liquidity_gross(v6, v14));
                    v11 = v11 + 1;
                    v12 = 0;
                    if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::lte(v14, v1)) {
                        break
                    };
                    v10 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(v14, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(1));
                    continue
                };
                v12 = v12 + 1;
                if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::lte(v14, v1)) {
                    break
                };
                v10 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(v14, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(1));
            } else {
                break
            };
        };
        let v16 = 0x1::vector::empty<u32>();
        let v17 = 0x1::vector::empty<u128>();
        let v18 = 0x1::vector::empty<u128>();
        v10 = v0;
        v11 = 0;
        v12 = 0;
        loop {
            let v19 = if (v11 < arg2) {
                if (v12 < v4) {
                    0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::lte(v10, v2)
                } else {
                    false
                }
            } else {
                false
            };
            if (v19) {
                let (v20, v21) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_bitmap::next_initialized_tick_within_one_word(v5, v10, v3, false);
                if (v21) {
                    0x1::vector::push_back<u32>(&mut v16, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v20));
                    0x1::vector::push_back<u128>(&mut v17, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i128::as_u128(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::get_liquidity_net(v6, v20)));
                    0x1::vector::push_back<u128>(&mut v18, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::get_liquidity_gross(v6, v20));
                    v11 = v11 + 1;
                    v12 = 0;
                    if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::gte(v20, v2)) {
                        break
                    };
                    v10 = v20;
                    continue
                };
                v12 = v12 + 1;
                if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::gte(v20, v2)) {
                    break
                };
                v10 = v20;
            } else {
                break
            };
        };
        let v22 = 0x1::vector::empty<u32>();
        let v23 = 0x1::vector::empty<u128>();
        let v24 = 0x1::vector::empty<u128>();
        let v25 = 0x1::vector::length<u32>(&v7);
        while (v25 > 0) {
            v25 = v25 - 1;
            0x1::vector::push_back<u32>(&mut v22, *0x1::vector::borrow<u32>(&v7, v25));
            0x1::vector::push_back<u128>(&mut v23, *0x1::vector::borrow<u128>(&v8, v25));
            0x1::vector::push_back<u128>(&mut v24, *0x1::vector::borrow<u128>(&v9, v25));
        };
        let v26 = 0;
        while (v26 < 0x1::vector::length<u32>(&v16)) {
            0x1::vector::push_back<u32>(&mut v22, *0x1::vector::borrow<u32>(&v16, v26));
            0x1::vector::push_back<u128>(&mut v23, *0x1::vector::borrow<u128>(&v17, v26));
            0x1::vector::push_back<u128>(&mut v24, *0x1::vector::borrow<u128>(&v18, v26));
            v26 = v26 + 1;
        };
        (v22, v23, v24)
    }

    // decompiled from Move bytecode v7
}

