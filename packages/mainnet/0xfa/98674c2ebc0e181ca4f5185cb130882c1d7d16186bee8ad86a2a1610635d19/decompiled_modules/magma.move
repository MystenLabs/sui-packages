module 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::magma {
    fun addr<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) : address {
        0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg0)
    }

    public fun flash_borrow_a2b<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>> {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::principal(arg0);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, limit(true), arg3);
        0x2::balance::destroy_zero<T0>(v1);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::seed<T1>(arg0, v2);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v3, v0)
    }

    public fun flash_borrow_b2a<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>> {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::principal(arg0);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, limit(false), arg3);
        0x2::balance::destroy_zero<T1>(v2);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::seed<T0>(arg0, v1);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v3, v0)
    }

    public fun flash_repay_a2b<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>>) {
        let (v0, _) = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::open<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(arg3);
        let v2 = v0;
        let v3 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_final<T0>(arg0);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v2)), 0x2::balance::zero<T1>(), v2);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::settle<T0>(arg0, v3);
    }

    public fun flash_repay_b2a<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>>) {
        let (v0, _) = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::open<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(arg3);
        let v2 = v0;
        let v3 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_final<T1>(arg0);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v2)), v2);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::settle<T1>(arg0, v3);
    }

    fun limit(arg0: bool) : u128 {
        if (arg0) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price()
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price()
        }
    }

    public fun peek<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0 || 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_pause<T0, T1>(arg0)) {
            return 0
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v1 = limit(arg1);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0);
        let v4 = arg2;
        let v5 = 0;
        let v6 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        while (v4 > 0 && v2 != v1) {
            if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v6)) {
                return 0
            };
            let (v7, v8) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v0, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v6), arg1);
            v6 = v8;
            let v9 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v7);
            let v10 = if (arg1) {
                if (v1 > v9) {
                    v1
                } else {
                    v9
                }
            } else if (v1 < v9) {
                v1
            } else {
                v9
            };
            let (v11, v12, v13, v14) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v2, v10, v3, v4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, true);
            if (v11 != 0 || v14 != 0) {
                let v15 = v4 - v11;
                v4 = v15 - v14;
                v5 = v5 + v12;
            };
            if (v13 == v9) {
                v2 = v10;
                let v16 = if (arg1) {
                    0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v7))
                } else {
                    0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v7)
                };
                let v17 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v16);
                if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v16)) {
                    if (v17 > v3) {
                        return 0
                    };
                    v3 = v3 - v17;
                    continue
                };
                if (v17 > 340282366920938463463374607431768211455 - v3) {
                    return 0
                };
                v3 = v3 + v17;
                continue
            };
            if (v2 != v13) {
                v2 = v13;
            };
        };
        if (v4 > 0) {
            return 0
        };
        v5
    }

    public fun r_a2b<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u8, arg4: &0x2::clock::Clock) {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_in<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T1>(arg0, arg3, 0x2::balance::zero<T1>(), addr<T0, T1>(arg2));
            return
        };
        let (v2, v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v1, limit(true), arg4);
        0x2::balance::destroy_zero<T0>(v2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T1>(), v4);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T1>(arg0, arg3, v3, addr<T0, T1>(arg2));
    }

    public fun r_b2a<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u8, arg4: &0x2::clock::Clock) {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_in<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T0>(arg0, arg3, 0x2::balance::zero<T0>(), addr<T0, T1>(arg2));
            return
        };
        let (v2, v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v1, limit(false), arg4);
        0x2::balance::destroy_zero<T1>(v3);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v0, v4);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T0>(arg0, arg3, v2, addr<T0, T1>(arg2));
    }

    // decompiled from Move bytecode v7
}

