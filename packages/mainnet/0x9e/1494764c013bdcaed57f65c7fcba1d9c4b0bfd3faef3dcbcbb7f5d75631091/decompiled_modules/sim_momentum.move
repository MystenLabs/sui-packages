module 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_momentum {
    struct SimResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        final_sqrt_price: u128,
        exceeded: bool,
    }

    fun bitmap_position(arg0: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) : (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u8) {
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::shr(arg0, 8), (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::and(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(255))) as u8))
    }

    fun compress(arg0: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg1: u32) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(arg1);
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::is_neg(arg0) && !0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::eq(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mod(arg0, v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::zero())) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::div(arg0, v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1))
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::div(arg0, v0)
        }
    }

    fun next_tick_in_word(arg0: &0x2::table::Table<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg2: bool) : (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, bool) {
        let (v0, v1) = if (arg2) {
            let (v2, v3) = bitmap_position(arg1);
            let v4 = if (0x2::table::contains<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>(arg0, v2)) {
                *0x2::table::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>(arg0, v2)
            } else {
                0
            };
            let v5 = if (v3 == 255) {
                115792089237316195423570985008687907853269984665640564039457584007913129639935
            } else {
                (1 << (v3 as u8) + 1) - 1
            };
            let v6 = v4 & v5;
            let (v7, v8) = if (v6 != 0) {
                (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(256)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::bit_math::most_significant_bit(v6) as u32))), true)
            } else {
                (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(256)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1)), false)
            };
            (v8, v7)
        } else {
            let (v9, v10) = bitmap_position(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1)));
            let v11 = if (0x2::table::contains<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>(arg0, v9)) {
                *0x2::table::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>(arg0, v9)
            } else {
                0
            };
            let v12 = if (v10 == 0) {
                0
            } else {
                (1 << (v10 as u8)) - 1
            };
            let v13 = v11 & 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v12;
            let (v14, v15) = if (v13 != 0) {
                (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(v9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(256)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::bit_math::least_significant_bit(v13) as u32))), true)
            } else {
                (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(v9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(256)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(255)), false)
            };
            (v15, v14)
        };
        (v1, v0)
    }

    public fun sim_amount_in(arg0: &SimResult) : u64 {
        arg0.amount_in
    }

    public fun sim_amount_out(arg0: &SimResult) : u64 {
        arg0.amount_out
    }

    public fun sim_exceeded(arg0: &SimResult) : bool {
        arg0.exceeded
    }

    public fun sim_fee(arg0: &SimResult) : u64 {
        arg0.fee
    }

    public fun sim_total_cost(arg0: &SimResult) : u64 {
        arg0.amount_in + arg0.fee
    }

    public fun simulate_swap<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : SimResult {
        if (arg2 == 0) {
            return SimResult{
                amount_in        : 0,
                amount_out       : 0,
                fee              : 0,
                final_sqrt_price : 0,
                exceeded         : true,
            }
        };
        let v0 = if (arg1) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price()
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price()
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0);
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0);
        let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0);
        let v6 = compress(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg0), v3);
        let v7 = arg2;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = false;
        let v12 = 0;
        loop {
            let v13 = if (v7 > 0) {
                if (v1 != v0) {
                    v12 < 50
                } else {
                    false
                }
            } else {
                false
            };
            if (v13) {
                v12 = v12 + 1;
                let (v14, v15) = next_tick_in_word(v4, v6, arg1);
                let v16 = v15;
                let v17 = v14;
                let v18 = 0;
                while (!v16 && v18 < 3) {
                    v18 = v18 + 1;
                    let (v19, v20) = next_tick_in_word(v4, v17, arg1);
                    v17 = v19;
                    v16 = v20;
                };
                if (!v16) {
                    v11 = true;
                    break
                };
                let v21 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(v17, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(v3));
                let v22 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v21);
                let v23 = if (arg1) {
                    if (v22 < v0) {
                        v0
                    } else {
                        v22
                    }
                } else if (v22 > v0) {
                    v0
                } else {
                    v22
                };
                let (v24, v25, v26, v27) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::swap_math::compute_swap_step(v1, v23, v2, v7, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0), true);
                if (v25 != 0 || v27 != 0) {
                    let v28 = v7 - v25;
                    v7 = v28 - v27;
                    v8 = v8 + v25;
                    v9 = v9 + v26;
                    v10 = v10 + v27;
                };
                if (v24 == v23 && v23 == v22) {
                    let v29 = if (arg1) {
                        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::neg(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v5, v21))
                    } else {
                        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v5, v21)
                    };
                    if (!0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::is_neg(v29)) {
                        v2 = v2 + 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::abs_u128(v29);
                    } else {
                        v2 = v2 - 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::abs_u128(v29);
                    };
                    v1 = v24;
                    let v30 = if (arg1) {
                        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v17, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(1))
                    } else {
                        v17
                    };
                    v6 = v30;
                    continue
                };
                v1 = v24;
                v6 = compress(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_tick_at_sqrt_price(v24), v3);
            } else {
                break
            };
        };
        if (v7 > 0 && v12 >= 50) {
            v11 = true;
        };
        SimResult{
            amount_in        : v8,
            amount_out       : v9,
            fee              : v10,
            final_sqrt_price : v1,
            exceeded         : v11,
        }
    }

    // decompiled from Move bytecode v6
}

