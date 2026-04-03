module 0xd8d3e35bf423f6296da9b2777b5765fcc11e99793b515a9e1c065b1c8cb5a19c::bluefin_clmm {
    fun compressed_index(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) % 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg1) != 0) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, arg1)
        }
    }

    fun compressed_index_right(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) % 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg1) != 0) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, arg1)
        }
    }

    public fun fetch_ticks_around<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32, arg2: u64) : (vector<u32>, vector<u128>, vector<u128>) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(v0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::tick_spacing(v0);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(4293523660);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(443636);
        let v6 = if (arg2 < 2) {
            2
        } else if (arg2 > 50) {
            50
        } else {
            arg2
        };
        let v7 = 0x1::vector::empty<u32>();
        let v8 = v3;
        let v9 = 0;
        let v10 = 0;
        loop {
            let v11 = if (v9 < arg2) {
                if (v10 < v6) {
                    0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v8, v4)
                } else {
                    false
                }
            } else {
                false
            };
            if (v11) {
                let v12 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2);
                let v13 = compressed_index(v8, v12);
                let (v14, v15) = position(v13);
                let v16 = try_get_bitmap_word(v1, v14) & (1 << v15 | (1 << v15) - 1);
                if (v16 == 0) {
                    v10 = v10 + 1;
                    let v17 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v13, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((v15 as u32))), v12);
                    if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v17, v4)) {
                        break
                    };
                    v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v17, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
                    continue
                };
                let v18 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v13, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((v15 as u32)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((most_significant_bit(v16) as u32)))), v12);
                0x1::vector::push_back<u32>(&mut v7, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v18));
                v9 = v9 + 1;
                if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v18, v4)) {
                    break
                };
                v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v18, v12);
            } else {
                break
            };
        };
        let v19 = 0x1::vector::empty<u32>();
        v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        let v20 = 0;
        let v21 = 0;
        loop {
            let v22 = if (v20 < arg2) {
                if (v21 < v6) {
                    0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v8, v5)
                } else {
                    false
                }
            } else {
                false
            };
            if (v22) {
                let v23 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2);
                let v24 = compressed_index_right(v8, v23);
                let (v25, v26) = position(v24);
                let v27 = if (v26 >= 255) {
                    0
                } else {
                    (1 << v26) - 1 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935
                };
                let v28 = try_get_bitmap_word(v1, v25) & v27;
                if (v28 == 0) {
                    v21 = v21 + 1;
                    let v29 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v24, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(255), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((v26 as u32)))), v23);
                    if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v29, v5)) {
                        break
                    };
                    v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v29, v23);
                    continue
                };
                let v30 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v24, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((least_significant_bit(v28) as u32)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((v26 as u32)))), v23);
                0x1::vector::push_back<u32>(&mut v19, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v30));
                v20 = v20 + 1;
                if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v30, v5)) {
                    break
                };
                v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v30, v23);
            } else {
                break
            };
        };
        let v31 = 0x1::vector::empty<u32>();
        let v32 = 0x1::vector::length<u32>(&v7);
        while (v32 > 0) {
            v32 = v32 - 1;
            0x1::vector::push_back<u32>(&mut v31, *0x1::vector::borrow<u32>(&v7, v32));
        };
        let v33 = 0;
        while (v33 < 0x1::vector::length<u32>(&v19)) {
            0x1::vector::push_back<u32>(&mut v31, *0x1::vector::borrow<u32>(&v19, v33));
            v33 = v33 + 1;
        };
        let v34 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::fetch_provided_ticks<T0, T1>(arg0, v31);
        let v35 = 0x1::vector::empty<u32>();
        let v36 = 0x1::vector::empty<u128>();
        let v37 = 0x1::vector::empty<u128>();
        let v38 = 0;
        while (v38 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>(&v34)) {
            let v39 = 0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>(&v34, v38);
            0x1::vector::push_back<u32>(&mut v35, *0x1::vector::borrow<u32>(&v31, v38));
            0x1::vector::push_back<u128>(&mut v36, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(v39)));
            0x1::vector::push_back<u128>(&mut v37, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_gross(v39));
            v38 = v38 + 1;
        };
        (v35, v36, v37)
    }

    fun least_significant_bit(arg0: u256) : u8 {
        assert!(arg0 > 0, 0);
        let v0 = 255;
        let v1 = v0;
        if (arg0 & 340282366920938463463374607431768211455 > 0) {
            v1 = v0 - 128;
        };
        let v2 = if (arg0 & 340282366920938463463374607431768211455 > 0) {
            arg0
        } else {
            arg0 >> 128
        };
        if (v2 & 18446744073709551615 > 0) {
            v1 = v1 - 64;
        };
        let v3 = if (v2 & 18446744073709551615 > 0) {
            v2
        } else {
            v2 >> 64
        };
        if (v3 & 4294967295 > 0) {
            v1 = v1 - 32;
        };
        let v4 = if (v3 & 4294967295 > 0) {
            v3
        } else {
            v3 >> 32
        };
        if (v4 & 65535 > 0) {
            v1 = v1 - 16;
        };
        let v5 = if (v4 & 65535 > 0) {
            v4
        } else {
            v4 >> 16
        };
        if (v5 & 255 > 0) {
            v1 = v1 - 8;
        };
        let v6 = if (v5 & 255 > 0) {
            v5
        } else {
            v5 >> 8
        };
        if (v6 & 15 > 0) {
            v1 = v1 - 4;
        };
        let v7 = if (v6 & 15 > 0) {
            v6
        } else {
            v6 >> 4
        };
        if (v7 & 3 > 0) {
            v1 = v1 - 2;
        };
        let v8 = if (v7 & 3 > 0) {
            v7
        } else {
            v7 >> 2
        };
        if (v8 & 1 > 0) {
            v1 = v1 - 1;
        };
        v1
    }

    fun most_significant_bit(arg0: u256) : u8 {
        assert!(arg0 > 0, 0);
        let v0 = 0;
        let v1 = v0;
        if (arg0 >= 340282366920938463463374607431768211456) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >= 18446744073709551616) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >= 4294967296) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >= 65536) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >= 256) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >= 16) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >= 4) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >= 2) {
            v1 = v1 + 1;
        };
        v1
    }

    fun position(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u8) {
        let v0 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(256))) & 255) as u8);
        let v1 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0) && v0 != 0) {
            ((256 - (v0 as u16)) as u8)
        } else {
            v0
        };
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::shr(arg0, 8), v1)
    }

    fun try_get_bitmap_word(arg0: &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u256 {
        if (0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, arg1)) {
            *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

