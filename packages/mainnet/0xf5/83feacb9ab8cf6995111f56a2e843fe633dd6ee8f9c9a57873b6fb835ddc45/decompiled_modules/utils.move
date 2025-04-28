module 0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::utils {
    public fun add_balance_to_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0))
    }

    public fun get_amount_by_liquidity(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u128, arg5: bool) : (u64, u64) {
        if (arg4 == 0) {
            return (0, 0)
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg2, arg0)) {
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5), 0)
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg2, arg1)) {
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg0), arg3, arg4, arg5))
        } else {
            (0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5))
        }
    }

    public fun get_lp_amount_by_liquidity(arg0: u64, arg1: u128, arg2: u128) : u128 {
        if (arg0 == 0) {
            return arg1
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), arg1, arg2)
    }

    public fun get_lp_amount_by_tvl(arg0: u64, arg1: u128, arg2: u128) : u128 {
        if (arg0 == 0) {
            return arg1
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round((arg0 as u128), arg1, arg2)
    }

    public fun get_share_liquidity_by_amount(arg0: u64, arg1: u128, arg2: u64) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), arg1, (arg2 as u128))
    }

    public fun get_user_amount_by_share(arg0: u64, arg1: u64, arg2: u128) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round((arg1 as u128), arg2, (arg0 as u128))
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    public fun price_to_sqrt_price(arg0: u64, arg1: u8) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(0x1::u128::sqrt((arg0 as u128) * 0x1::u128::pow(10, 10)), uint64_max(), 0x1::u128::pow(10, (10 + arg1) / 2))
    }

    public fun remove_balance_from_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: u64, arg2: bool) : (0x2::balance::Balance<T0>, u64) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            return (0x2::balance::zero<T0>(), 0)
        };
        let v1 = if (arg2) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0))
        } else {
            arg1
        };
        (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), v1), 0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0)))
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun sqrt_price_to_price(arg0: u128, arg1: u8, arg2: u8, arg3: u8) : u128 {
        let v0 = if (arg1 > arg2) {
            ((0x1::u256::pow((arg0 as u256) * 0x1::u256::pow(10, arg3) / (uint64_max() as u256), 2) / 0x1::u256::pow(10, arg3)) as u128) * 0x1::u128::pow(10, arg1 - arg2)
        } else {
            ((0x1::u256::pow((arg0 as u256) * 0x1::u256::pow(10, arg3) / (uint64_max() as u256), 2) / 0x1::u256::pow(10, arg3)) as u128) / 0x1::u128::pow(10, arg2 - arg1)
        };
        (v0 as u128)
    }

    public fun str(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = ((arg0 % 10) as u8);
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, v1 + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun uint64_max() : u128 {
        18446744073709551616
    }

    // decompiled from Move bytecode v6
}

