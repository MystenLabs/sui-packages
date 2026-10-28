module 0x15f3cbbdca43edb81f0dd824454824ea51fa2e36df5319477548c4f758f2445f::magma {
    struct Flash<phantom T0, phantom T1> {
        receipt: 0x1::option::Option<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>,
    }

    public fun flash_a2b<T0, T1>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, Flash<T0, T1>) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Flash<T0, T1>{receipt: 0x1::option::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg2, arg3, true, true, v0, 4295048016, arg4);
        0x2::balance::destroy_zero<T0>(v2);
        let v5 = Flash<T0, T1>{receipt: 0x1::option::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v4)};
        (v3, v5)
    }

    public fun flash_b2a<T0, T1>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Flash<T0, T1>) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Flash<T0, T1>{receipt: 0x1::option::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg2, arg3, false, true, v0, 79226673515401279992447579055, arg4);
        0x2::balance::destroy_zero<T1>(v3);
        let v5 = Flash<T0, T1>{receipt: 0x1::option::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v4)};
        (v2, v5)
    }

    public fun limit(arg0: u128, arg1: bool, arg2: u64) : u128 {
        let v0 = if (arg2 == 0) {
            arg0
        } else {
            arg0 / 20000 * (arg2 as u128)
        };
        if (arg1) {
            let v2 = if (v0 >= arg0) {
                4295048016
            } else {
                arg0 - v0
            };
            let v3 = if (v2 < 4295048016) {
                4295048016
            } else {
                v2
            };
            if (v3 < arg0) {
                v3
            } else {
                0
            }
        } else {
            let v4 = if (arg0 < 79226673515401279992447579055) {
                arg0
            } else {
                79226673515401279992447579055
            };
            let v5 = if (arg2 == 0 || v0 >= 79226673515401279992447579055 - v4) {
                79226673515401279992447579055
            } else {
                arg0 + v0
            };
            if (v5 > arg0) {
                v5
            } else {
                0
            }
        }
    }

    public fun out<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u128) : u64 {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_pause<T0, T1>(arg0)
        };
        if (v0) {
            return 0
        };
        probe<T0, T1>(arg0, arg1, arg2, arg3, reserve_out<T0, T1>(arg0, arg1))
    }

    fun probe<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u128, arg4: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::get_magma_distribution_staked_liquidity<T0, T1>(arg0);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0);
        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v5 = arg2;
        let v6 = 0;
        while (v5 > 0 && v2 != arg3) {
            if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v4)) {
                return 0
            };
            let (v7, v8) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v0, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v4), arg1);
            v4 = v8;
            let v9 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v7);
            let v10 = if (arg1) {
                if (arg3 > v9) {
                    arg3
                } else {
                    v9
                }
            } else if (arg3 < v9) {
                arg3
            } else {
                v9
            };
            let (v11, v12, v13, v14) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v2, v10, v3, v5, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, true);
            if (v11 != 0 || v14 != 0) {
                if (v5 < v11) {
                    return 0
                };
                let v15 = v5 - v11;
                if (v15 < v14) {
                    return 0
                };
                v5 = v15 - v14;
                v6 = v6 + (v12 as u128);
            };
            if (v13 == v9) {
                v2 = v10;
                let (v16, v17) = if (arg1) {
                    (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v7)), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::magma_distribution_staked_liquidity_net(v7)))
                } else {
                    (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v7), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::magma_distribution_staked_liquidity_net(v7))
                };
                let v18 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v16);
                let v19 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v17);
                if (!0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v16)) {
                    if (340282366920938463463374607431768211455 - v3 < v18 || 340282366920938463463374607431768211455 - v1 < v19) {
                        return 0
                    };
                    v3 = v3 + v18;
                    continue
                };
                if (v3 < v18 || v1 < v19) {
                    return 0
                };
                v3 = v3 - v18;
                continue
            };
            if (v2 != v13) {
                v2 = v13;
            };
        };
        if (v5 > 0 || v2 == arg3) {
            return 0
        };
        let v20 = if (v6 == 0) {
            true
        } else if (v6 > 18446744073709551615) {
            true
        } else {
            v6 > (arg4 as u128)
        };
        if (v20) {
            return 0
        };
        (v6 as u64)
    }

    fun quote<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool, arg3: u64) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::begin(arg0, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg1));
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = vector[];
        let v3 = if (v1 == 0 || 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_pause<T0, T1>(arg1)) {
            0
        } else {
            limit(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1), arg2, arg3)
        };
        let v4 = if (v3 == 0) {
            0
        } else {
            reserve_out<T0, T1>(arg1, arg2)
        };
        let v5 = 0;
        while (v5 < v1) {
            let v6 = if (v3 == 0) {
                0
            } else {
                probe<T0, T1>(arg1, arg2, *0x1::vector::borrow<u64>(&v0, v5), v3, v4)
            };
            0x1::vector::push_back<u64>(&mut v2, v6);
            v5 = v5 + 1;
        };
        0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::end(arg0, v2);
    }

    public fun quote_a2b<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: u64) {
        quote<T0, T1>(arg0, arg1, true, arg2);
    }

    public fun quote_b2a<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: u64) {
        quote<T0, T1>(arg0, arg1, false, arg2);
    }

    public fun repay_a2b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: Flash<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let Flash { receipt: v0 } = arg2;
        if (0x1::option::is_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v0);
            return arg3
        };
        let v1 = 0x1::option::destroy_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v0);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v1);
        assert!(0x2::balance::value<T0>(&arg3) >= v2, 7802);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::zero<T1>(), v1);
        arg3
    }

    public fun repay_b2a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: Flash<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        let Flash { receipt: v0 } = arg2;
        if (0x1::option::is_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v0);
            return arg3
        };
        let v1 = 0x1::option::destroy_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v0);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v1);
        assert!(0x2::balance::value<T1>(&arg3) >= v2, 7802);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v2), v1);
        arg3
    }

    fun reserve_out<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool) : u64 {
        let (v0, v1) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::balances<T0, T1>(arg0);
        if (arg1) {
            v1
        } else {
            v0
        }
    }

    public fun swap_a2b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 4295048016, arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4) == v0, 7801);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v4);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 79226673515401279992447579055, arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4) == v0, 7801);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v4);
        v1
    }

    // decompiled from Move bytecode v7
}

