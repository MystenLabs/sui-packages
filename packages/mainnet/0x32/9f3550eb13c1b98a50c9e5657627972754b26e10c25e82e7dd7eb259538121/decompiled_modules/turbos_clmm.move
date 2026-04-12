module 0x935c31aaf3bfa604f8c28f8bf87552e09371be06bd45ad4d3df492df28d8494c::turbos_clmm {
    public fun fetch_ticks_around<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u32, arg2: u64) : (vector<u32>, vector<u128>, vector<u128>) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg1);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636);
        let v3 = if (arg2 < 2) {
            2
        } else if (arg2 > 50) {
            50
        } else {
            arg2
        };
        let v4 = 0x1::vector::empty<u32>();
        let v5 = 0x1::vector::empty<u128>();
        let v6 = 0x1::vector::empty<u128>();
        let v7 = v0;
        let v8 = 0;
        let v9 = 0;
        loop {
            let v10 = if (v8 < arg2) {
                if (v9 < v3) {
                    0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(v7, v1)
                } else {
                    false
                }
            } else {
                false
            };
            if (v10) {
                let (v11, v12) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::next_initialized_tick_within_one_word<T0, T1, T2>(arg0, v7, true);
                if (v12) {
                    let v13 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v11);
                    0x1::vector::push_back<u32>(&mut v4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v11));
                    0x1::vector::push_back<u128>(&mut v5, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::as_u128(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(v13)));
                    0x1::vector::push_back<u128>(&mut v6, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_gross(v13));
                    v8 = v8 + 1;
                    if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(v11, v1)) {
                        break
                    };
                    v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v11, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1));
                    continue
                };
                v9 = v9 + 1;
                if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(v11, v1)) {
                    break
                };
                v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v11, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1));
            } else {
                break
            };
        };
        let v14 = 0x1::vector::empty<u32>();
        let v15 = 0x1::vector::empty<u128>();
        let v16 = 0x1::vector::empty<u128>();
        v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1));
        v8 = 0;
        v9 = 0;
        loop {
            let v17 = if (v8 < arg2) {
                if (v9 < v3) {
                    0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(v7, v2)
                } else {
                    false
                }
            } else {
                false
            };
            if (v17) {
                let (v18, v19) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::next_initialized_tick_within_one_word<T0, T1, T2>(arg0, v7, false);
                if (v19) {
                    let v20 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v18);
                    0x1::vector::push_back<u32>(&mut v14, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v18));
                    0x1::vector::push_back<u128>(&mut v15, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::as_u128(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(v20)));
                    0x1::vector::push_back<u128>(&mut v16, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_gross(v20));
                    v8 = v8 + 1;
                    if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(v18, v2)) {
                        break
                    };
                    v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v18, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1));
                    continue
                };
                v9 = v9 + 1;
                if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(v18, v2)) {
                    break
                };
                v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v18, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1));
            } else {
                break
            };
        };
        let v21 = 0x1::vector::empty<u32>();
        let v22 = 0x1::vector::empty<u128>();
        let v23 = 0x1::vector::empty<u128>();
        let v24 = 0x1::vector::length<u32>(&v4);
        while (v24 > 0) {
            v24 = v24 - 1;
            0x1::vector::push_back<u32>(&mut v21, *0x1::vector::borrow<u32>(&v4, v24));
            0x1::vector::push_back<u128>(&mut v22, *0x1::vector::borrow<u128>(&v5, v24));
            0x1::vector::push_back<u128>(&mut v23, *0x1::vector::borrow<u128>(&v6, v24));
        };
        let v25 = 0;
        while (v25 < 0x1::vector::length<u32>(&v14)) {
            0x1::vector::push_back<u32>(&mut v21, *0x1::vector::borrow<u32>(&v14, v25));
            0x1::vector::push_back<u128>(&mut v22, *0x1::vector::borrow<u128>(&v15, v25));
            0x1::vector::push_back<u128>(&mut v23, *0x1::vector::borrow<u128>(&v16, v25));
            v25 = v25 + 1;
        };
        (v21, v22, v23)
    }

    // decompiled from Move bytecode v7
}

