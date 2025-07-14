module 0x95a9579a7fd1136231f267234dbb71c66eda8843f7709d9d8742b04b6c1057f0::factory {
    struct Hop has copy, drop, store {
        pool_id: 0x2::object::ID,
        a2b: bool,
    }

    struct ProfitEvent has copy, drop, store {
        direction: u8,
    }

    struct ProfitCalculationEvent has copy, drop, store {
        price_ins: vector<u128>,
        price_outs: vector<u128>,
        fees: vector<u64>,
    }

    public entry fun check_profit_0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>) : u8 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0x1::vector::empty<u128>();
        let (v3, v4, v5) = inner_mmt<T1, T0>(arg1, true);
        0x1::vector::push_back<u64>(&mut v0, v5);
        0x1::vector::push_back<u128>(&mut v1, v3);
        0x1::vector::push_back<u128>(&mut v2, v4);
        let (v6, v7, v8) = inner_cetus<T0, T1>(arg0, true);
        0x1::vector::push_back<u64>(&mut v0, v8);
        0x1::vector::push_back<u128>(&mut v1, v6);
        0x1::vector::push_back<u128>(&mut v2, v7);
        let v9 = ProfitCalculationEvent{
            price_ins  : v1,
            price_outs : v2,
            fees       : v0,
        };
        0x2::event::emit<ProfitCalculationEvent>(v9);
        profit_direction(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(79228162514264337593543950336, v3, 79228162514264337593543950336), v6, v4), v7, v0)
    }

    public entry fun check_profit_1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : u8 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0x1::vector::empty<u128>();
        let (v3, v4, v5) = inner_mmt<T0, T1>(arg1, false);
        0x1::vector::push_back<u64>(&mut v0, v5);
        0x1::vector::push_back<u128>(&mut v1, v3);
        0x1::vector::push_back<u128>(&mut v2, v4);
        let (v6, v7, v8) = inner_cetus<T0, T1>(arg0, true);
        0x1::vector::push_back<u64>(&mut v0, v8);
        0x1::vector::push_back<u128>(&mut v1, v6);
        0x1::vector::push_back<u128>(&mut v2, v7);
        let v9 = ProfitCalculationEvent{
            price_ins  : v1,
            price_outs : v2,
            fees       : v0,
        };
        0x2::event::emit<ProfitCalculationEvent>(v9);
        profit_direction(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(79228162514264337593543950336, v3, 79228162514264337593543950336), v6, v4), v7, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun inner_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool) : (u128, u128, u64) {
        let (v0, v1) = price_from_sqrt_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), arg1);
        (((v0 >> 32) as u128), ((v1 >> 32) as u128), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0))
    }

    fun inner_mmt<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool) : (u128, u128, u64) {
        let (v0, v1) = price_from_sqrt_price(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), arg1);
        (((v0 >> 32) as u128), ((v1 >> 32) as u128), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0))
    }

    fun price_from_sqrt_price(arg0: u128, arg1: bool) : (u256, u256) {
        if (arg1) {
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg0, arg0), 340282366920938463463374607431768211456)
        } else {
            (340282366920938463463374607431768211456, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg0, arg0))
        }
    }

    public entry fun profit_direction(arg0: u128, arg1: u128, arg2: vector<u64>) : u8 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg2);
        let v2 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg0 == arg1
        };
        let v3 = if (v2) {
            0
        } else if (arg0 > arg1) {
            while (v0 < v1) {
                arg0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(arg0, 1000000 - (*0x1::vector::borrow<u64>(&arg2, v0) as u128), 1000000);
                v0 = v0 + 1;
            };
            if (arg0 > arg1) {
                1
            } else {
                0
            }
        } else {
            let v4 = 0;
            while (v4 < v1) {
                arg1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(arg1, 1000000 - (*0x1::vector::borrow<u64>(&arg2, v1 - 1 - v4) as u128), 1000000);
                v4 = v4 + 1;
            };
            if (arg1 > arg0) {
                2
            } else {
                0
            }
        };
        let v5 = ProfitEvent{direction: v3};
        0x2::event::emit<ProfitEvent>(v5);
        v3
    }

    // decompiled from Move bytecode v6
}

