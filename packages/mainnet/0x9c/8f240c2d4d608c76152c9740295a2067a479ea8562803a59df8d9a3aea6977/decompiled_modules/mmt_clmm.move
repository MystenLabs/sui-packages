module 0x6fedc46981bdbc93eb7221cf5b263be1f4b36a62892c89cf0883eeba80a63790::mmt_clmm {
    public fun fetch_ticks_around<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u32, arg2: u64) : (vector<u32>, vector<u128>, vector<u128>) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0);
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg1);
        let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_tick();
        let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_tick();
        let v6 = 0x1::vector::empty<u32>();
        let v7 = 0x1::vector::empty<u128>();
        let v8 = 0x1::vector::empty<u128>();
        let v9 = v3;
        let v10 = 0;
        while (v10 < arg2 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v9, v4)) {
            let (v11, v12) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_bitmap::next_initialized_tick_within_one_word(v0, v9, v2, true);
            if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lt(v11, v4)) {
                break
            };
            if (v12) {
                0x1::vector::push_back<u32>(&mut v6, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v11));
                0x1::vector::push_back<u128>(&mut v7, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::as_u128(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v1, v11)));
                0x1::vector::push_back<u128>(&mut v8, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_gross(v1, v11));
                v10 = v10 + 1;
            };
            if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v11, v4)) {
                break
            };
            v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v11, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
        };
        let v13 = 0x1::vector::empty<u32>();
        let v14 = 0x1::vector::empty<u128>();
        let v15 = 0x1::vector::empty<u128>();
        v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
        let v16 = 0;
        while (v16 < arg2 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v9, v5)) {
            let (v17, v18) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_bitmap::next_initialized_tick_within_one_word(v0, v9, v2, false);
            if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gt(v17, v5)) {
                break
            };
            if (v18) {
                0x1::vector::push_back<u32>(&mut v13, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v17));
                0x1::vector::push_back<u128>(&mut v14, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::as_u128(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v1, v17)));
                0x1::vector::push_back<u128>(&mut v15, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_gross(v1, v17));
                v16 = v16 + 1;
            };
            if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v17, v5)) {
                break
            };
            v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v17, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
        };
        let v19 = 0x1::vector::empty<u32>();
        let v20 = 0x1::vector::empty<u128>();
        let v21 = 0x1::vector::empty<u128>();
        let v22 = 0x1::vector::length<u32>(&v6);
        while (v22 > 0) {
            v22 = v22 - 1;
            0x1::vector::push_back<u32>(&mut v19, *0x1::vector::borrow<u32>(&v6, v22));
            0x1::vector::push_back<u128>(&mut v20, *0x1::vector::borrow<u128>(&v7, v22));
            0x1::vector::push_back<u128>(&mut v21, *0x1::vector::borrow<u128>(&v8, v22));
        };
        let v23 = 0;
        while (v23 < 0x1::vector::length<u32>(&v13)) {
            0x1::vector::push_back<u32>(&mut v19, *0x1::vector::borrow<u32>(&v13, v23));
            0x1::vector::push_back<u128>(&mut v20, *0x1::vector::borrow<u128>(&v14, v23));
            0x1::vector::push_back<u128>(&mut v21, *0x1::vector::borrow<u128>(&v15, v23));
            v23 = v23 + 1;
        };
        (v19, v20, v21)
    }

    // decompiled from Move bytecode v6
}

