module 0x400500f2432ce2637913fffa914acfbcb9011d8a1f66e2f0ee79fed976f37b37::factory {
    struct Hop has copy, drop, store {
        pool_id: 0x2::object::ID,
        a2b: bool,
    }

    struct OraclePath has store, key {
        id: 0x2::object::UID,
        hops: vector<Hop>,
        meta_fwd: u64,
        meta_rev: u64,
    }

    struct ProfitEvent has copy, drop, store {
        direction: u8,
    }

    struct ProfitCalculationEvent has copy, drop, store {
        price_ins: vector<u128>,
        price_outs: vector<u128>,
        fees: vector<u64>,
    }

    fun calc_hop<T0, T1>(arg0: &Hop, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>) : (u128, u128, u64) {
        if (arg0.pool_id == 0x2::object::id_from_address(@0x51e883ba7c0b566a26cbc8a94cd33eb0abd418a77cc1e60ad22fd9b1f29cd2ab)) {
            inner_cetus<T0, T1>(arg1, arg0.a2b)
        } else {
            assert!(arg0.pool_id == 0x2::object::id_from_address(@0x455cf8d2ac91e7cb883f515874af750ed3cd18195c970b7a2d46235ac2b0c388), 404);
            inner_mmt<T1, T0>(arg2, arg0.a2b)
        }
    }

    public entry fun check_profit<T0, T1>(arg0: &OraclePath, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>) : u8 {
        let v0 = 79228162514264337593543950336;
        let v1 = 79228162514264337593543950336;
        let v2 = v1;
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u128>();
        let v5 = 0x1::vector::empty<u128>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<Hop>(&arg0.hops)) {
            let (v7, v8, v9) = calc_hop<T0, T1>(0x1::vector::borrow<Hop>(&arg0.hops, v6), arg1, arg2);
            v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(v0, v7, v1);
            v2 = v8;
            0x1::vector::push_back<u64>(&mut v3, v9);
            0x1::vector::push_back<u128>(&mut v4, v7);
            0x1::vector::push_back<u128>(&mut v5, v8);
            v6 = v6 + 1;
        };
        let v10 = ProfitCalculationEvent{
            price_ins  : v4,
            price_outs : v5,
            fees       : v3,
        };
        0x2::event::emit<ProfitCalculationEvent>(v10);
        profit_direction(v0, v2, v3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hop{
            pool_id : 0x2::object::id_from_address(@0x51e883ba7c0b566a26cbc8a94cd33eb0abd418a77cc1e60ad22fd9b1f29cd2ab),
            a2b     : false,
        };
        let v1 = Hop{
            pool_id : 0x2::object::id_from_address(@0x455cf8d2ac91e7cb883f515874af750ed3cd18195c970b7a2d46235ac2b0c388),
            a2b     : true,
        };
        let v2 = 0x1::vector::empty<Hop>();
        0x1::vector::push_back<Hop>(&mut v2, v0);
        0x1::vector::push_back<Hop>(&mut v2, v1);
        let v3 = OraclePath{
            id       : 0x2::object::new(arg0),
            hops     : v2,
            meta_fwd : 0,
            meta_rev : 0,
        };
        0x2::transfer::public_transfer<OraclePath>(v3, 0x2::tx_context::sender(arg0));
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

    public entry fun transfer_owner(arg0: OraclePath, arg1: address) {
        0x2::transfer::public_transfer<OraclePath>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

