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
        let v11 = 0;
        let v12 = arg2 * 20;
        loop {
            let v13 = if (v10 < arg2) {
                if (v11 < v12) {
                    0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v9, v4)
                } else {
                    false
                }
            } else {
                false
            };
            if (v13) {
                v11 = v11 + 1;
                let (v14, v15) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_bitmap::next_initialized_tick_within_one_word(v0, v9, v2, true);
                if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lt(v14, v4)) {
                    break
                };
                if (v15) {
                    0x1::vector::push_back<u32>(&mut v6, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v14));
                    0x1::vector::push_back<u128>(&mut v7, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::as_u128(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v1, v14)));
                    0x1::vector::push_back<u128>(&mut v8, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_gross(v1, v14));
                    v10 = v10 + 1;
                };
                if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v14, v4)) {
                    break
                };
                v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v14, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
            } else {
                break
            };
        };
        let v16 = 0x1::vector::empty<u32>();
        let v17 = 0x1::vector::empty<u128>();
        let v18 = 0x1::vector::empty<u128>();
        v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
        let v19 = 0;
        let v20 = 0;
        loop {
            let v21 = if (v19 < arg2) {
                if (v20 < v12) {
                    0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v9, v5)
                } else {
                    false
                }
            } else {
                false
            };
            if (v21) {
                v20 = v20 + 1;
                let (v22, v23) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_bitmap::next_initialized_tick_within_one_word(v0, v9, v2, false);
                if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gt(v22, v5)) {
                    break
                };
                if (v23) {
                    0x1::vector::push_back<u32>(&mut v16, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v22));
                    0x1::vector::push_back<u128>(&mut v17, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::as_u128(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v1, v22)));
                    0x1::vector::push_back<u128>(&mut v18, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_gross(v1, v22));
                    v19 = v19 + 1;
                };
                if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v22, v5)) {
                    break
                };
                v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v22, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
            } else {
                break
            };
        };
        let v24 = 0x1::vector::empty<u32>();
        let v25 = 0x1::vector::empty<u128>();
        let v26 = 0x1::vector::empty<u128>();
        let v27 = 0x1::vector::length<u32>(&v6);
        while (v27 > 0) {
            v27 = v27 - 1;
            0x1::vector::push_back<u32>(&mut v24, *0x1::vector::borrow<u32>(&v6, v27));
            0x1::vector::push_back<u128>(&mut v25, *0x1::vector::borrow<u128>(&v7, v27));
            0x1::vector::push_back<u128>(&mut v26, *0x1::vector::borrow<u128>(&v8, v27));
        };
        let v28 = 0;
        while (v28 < 0x1::vector::length<u32>(&v16)) {
            0x1::vector::push_back<u32>(&mut v24, *0x1::vector::borrow<u32>(&v16, v28));
            0x1::vector::push_back<u128>(&mut v25, *0x1::vector::borrow<u128>(&v17, v28));
            0x1::vector::push_back<u128>(&mut v26, *0x1::vector::borrow<u128>(&v18, v28));
            v28 = v28 + 1;
        };
        (v24, v25, v26)
    }

    public fun test_bitmap_one_lookup<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u32, arg2: bool) : (u32, bool) {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_bitmap::next_initialized_tick_within_one_word(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_tick_bitmap<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0), arg2);
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v0), v1)
    }

    public fun test_read_pool<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : (u128, u32, u128, u32) {
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0))
    }

    public fun test_tick_read<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u32) : (u128, u128) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg1);
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::as_u128(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v0, v1)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_gross(v0, v1))
    }

    // decompiled from Move bytecode v6
}

