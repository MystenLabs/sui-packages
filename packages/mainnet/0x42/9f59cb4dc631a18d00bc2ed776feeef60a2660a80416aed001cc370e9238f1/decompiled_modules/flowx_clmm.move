module 0x935c31aaf3bfa604f8c28f8bf87552e09371be06bd45ad4d3df492df28d8494c::flowx_clmm {
    public fun fetch_ticks_around<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: u32, arg3: u64) : (vector<u32>, vector<u128>, vector<u128>) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg0, arg1);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_tick_bitmap<T0, T1>(v0);
        let v2 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(v0);
        let v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(v0);
        let v4 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from_u32(arg2);
        let v5 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick();
        let v6 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick();
        let v7 = if (arg3 < 2) {
            2
        } else if (arg3 > 50) {
            50
        } else {
            arg3
        };
        let v8 = 0x1::vector::empty<u32>();
        let v9 = 0x1::vector::empty<u128>();
        let v10 = 0x1::vector::empty<u128>();
        let v11 = v4;
        let v12 = 0;
        let v13 = 0;
        loop {
            let v14 = if (v12 < arg3) {
                if (v13 < v7) {
                    0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gte(v11, v5)
                } else {
                    false
                }
            } else {
                false
            };
            if (v14) {
                let (v15, v16) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(v1, v11, v3, true);
                if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lt(v15, v5)) {
                    break
                };
                if (v16) {
                    0x1::vector::push_back<u32>(&mut v8, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::as_u32(v15));
                    0x1::vector::push_back<u128>(&mut v9, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::as_u128(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(v2, v15)));
                    0x1::vector::push_back<u128>(&mut v10, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_gross(v2, v15));
                    v12 = v12 + 1;
                } else {
                    v13 = v13 + 1;
                };
                if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lte(v15, v5)) {
                    break
                };
                v11 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::sub(v15, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(1));
            } else {
                break
            };
        };
        let v17 = 0x1::vector::empty<u32>();
        let v18 = 0x1::vector::empty<u128>();
        let v19 = 0x1::vector::empty<u128>();
        v11 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::add(v4, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(1));
        let v20 = 0;
        let v21 = 0;
        loop {
            let v22 = if (v20 < arg3) {
                if (v21 < v7) {
                    0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lte(v11, v6)
                } else {
                    false
                }
            } else {
                false
            };
            if (v22) {
                let (v23, v24) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(v1, v11, v3, false);
                if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gt(v23, v6)) {
                    break
                };
                if (v24) {
                    0x1::vector::push_back<u32>(&mut v17, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::as_u32(v23));
                    0x1::vector::push_back<u128>(&mut v18, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::as_u128(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(v2, v23)));
                    0x1::vector::push_back<u128>(&mut v19, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_gross(v2, v23));
                    v20 = v20 + 1;
                } else {
                    v21 = v21 + 1;
                };
                if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gte(v23, v6)) {
                    break
                };
                v11 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::add(v23, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(1));
            } else {
                break
            };
        };
        let v25 = 0x1::vector::empty<u32>();
        let v26 = 0x1::vector::empty<u128>();
        let v27 = 0x1::vector::empty<u128>();
        let v28 = 0x1::vector::length<u32>(&v8);
        while (v28 > 0) {
            v28 = v28 - 1;
            0x1::vector::push_back<u32>(&mut v25, *0x1::vector::borrow<u32>(&v8, v28));
            0x1::vector::push_back<u128>(&mut v26, *0x1::vector::borrow<u128>(&v9, v28));
            0x1::vector::push_back<u128>(&mut v27, *0x1::vector::borrow<u128>(&v10, v28));
        };
        let v29 = 0;
        while (v29 < 0x1::vector::length<u32>(&v17)) {
            0x1::vector::push_back<u32>(&mut v25, *0x1::vector::borrow<u32>(&v17, v29));
            0x1::vector::push_back<u128>(&mut v26, *0x1::vector::borrow<u128>(&v18, v29));
            0x1::vector::push_back<u128>(&mut v27, *0x1::vector::borrow<u128>(&v19, v29));
            v29 = v29 + 1;
        };
        (v25, v26, v27)
    }

    // decompiled from Move bytecode v7
}

