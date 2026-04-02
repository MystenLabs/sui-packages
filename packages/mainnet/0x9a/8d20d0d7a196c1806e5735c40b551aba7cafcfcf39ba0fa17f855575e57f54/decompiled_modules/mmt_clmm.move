module 0x6fedc46981bdbc93eb7221cf5b263be1f4b36a62892c89cf0883eeba80a63790::mmt_clmm {
    fun cast_to_u8(arg0: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) : u8 {
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::abs_u32(arg0) < 256, value_out_of_range());
        ((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::abs_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(256))) & 255) as u8)
    }

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
            let (v11, v12) = next_initialized_tick_within_one_word(v0, v9, v2, true);
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
            let (v17, v18) = next_initialized_tick_within_one_word(v0, v9, v2, false);
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

    fun next_initialized_tick_within_one_word(arg0: &0x2::table::Table<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg2: u32, arg3: bool) : (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, bool) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(arg2);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::div(arg1, v0);
        let v2 = v1;
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::is_neg(arg1) && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::abs_u32(arg1) % arg2 != 0) {
            v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1));
        };
        if (arg3) {
            let (v5, v6) = position(v2);
            let v7 = try_get_tick_word(arg0, v5) & (1 << v6) - 1 + (1 << v6);
            let v8 = if (v7 != 0) {
                0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((v6 as u32)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::bit_math::most_significant_bit(v7) as u32)))), v0)
            } else {
                0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((v6 as u32))), v0)
            };
            (v8, v7 != 0)
        } else {
            let (v9, v10) = position(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1)));
            let v11 = try_get_tick_word(arg0, v9) & ((1 << v10) - 1 ^ 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::constants::max_u256());
            let v12 = if (v11 != 0) {
                0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::bit_math::least_significant_bit(v11) as u32) - (v10 as u32))), v0)
            } else {
                0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::constants::max_u8() as u32) - (v10 as u32))), v0)
            };
            (v12, v11 != 0)
        }
    }

    fun position(arg0: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) : (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u8) {
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::shr(arg0, 8), cast_to_u8(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mod(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(256))))
    }

    fun try_get_tick_word(arg0: &0x2::table::Table<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) : u256 {
        if (!0x2::table::contains<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>(arg0, arg1)) {
            0
        } else {
            *0x2::table::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>(arg0, arg1)
        }
    }

    fun value_out_of_range() : u64 {
        77
    }

    // decompiled from Move bytecode v6
}

