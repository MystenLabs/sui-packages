module 0xe344256492920595f9370eaf476b0fd0d51bc423d2eeeac96692cd3e6c2c69f4::turbos {
    struct Flash<phantom T0, phantom T1> {
        receipt: 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>,
    }

    public fun flash_a2b<T0, T1, T2>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Flash<T0, T1>) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Flash<T0, T1>{receipt: 0x1::option::none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg5), true, (v0 as u128), true, 4295048017, arg3, arg4, arg5);
        0x2::coin::destroy_zero<T0>(v2);
        let v5 = Flash<T0, T1>{receipt: 0x1::option::some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v4)};
        (0x2::coin::into_balance<T1>(v3), v5)
    }

    public fun flash_b2a<T0, T1, T2>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Flash<T0, T1>) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Flash<T0, T1>{receipt: 0x1::option::none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg5), false, (v0 as u128), true, 79226673515401279992447579054, arg3, arg4, arg5);
        0x2::coin::destroy_zero<T1>(v3);
        let v5 = Flash<T0, T1>{receipt: 0x1::option::some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v4)};
        (0x2::coin::into_balance<T0>(v2), v5)
    }

    public fun limit(arg0: u128, arg1: bool, arg2: u64) : u128 {
        let v0 = if (arg2 == 0) {
            arg0
        } else {
            arg0 / 20000 * (arg2 as u128)
        };
        if (arg1) {
            let v2 = if (v0 >= arg0) {
                4295048017
            } else {
                arg0 - v0
            };
            let v3 = if (v2 < 4295048017) {
                4295048017
            } else {
                v2
            };
            if (v3 < arg0) {
                v3
            } else {
                0
            }
        } else {
            let v4 = if (arg0 < 79226673515401279992447579054) {
                arg0
            } else {
                79226673515401279992447579054
            };
            let v5 = if (arg2 == 0 || v0 >= 79226673515401279992447579054 - v4) {
                79226673515401279992447579054
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

    public fun out<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            !tradable<T0, T1, T2>(arg0, arg5)
        };
        if (v0) {
            return 0
        };
        let v1 = reserve_out<T0, T1, T2>(arg0, arg1);
        probe<T0, T1, T2>(arg0, arg1, arg2, arg3, v1, arg4, arg5, arg6)
    }

    fun probe<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::compute_swap_result<T0, T1, T2>(arg0, arg1, (arg2 as u128), true, arg3, arg5, arg6, arg7);
        let v1 = 0x2::bcs::new(0x1::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(&v0));
        0x2::bcs::peel_u128(&mut v1);
        0x2::bcs::peel_u128(&mut v1);
        let v2 = 0x2::bcs::peel_u128(&mut v1);
        0x2::bcs::peel_u32(&mut v1);
        0x2::bcs::peel_u128(&mut v1);
        0x2::bcs::peel_u128(&mut v1);
        let v3 = if (0x2::bcs::peel_u128(&mut v1) > 0) {
            true
        } else if (0x2::bcs::peel_u128(&mut v1) == 0) {
            true
        } else {
            0x2::bcs::peel_u128(&mut v1) == arg3
        };
        if (v3) {
            return 0
        };
        if (v2 > (arg4 as u128) || v2 > 18446744073709551615) {
            return 0
        };
        (v2 as u64)
    }

    fun quote<T0, T1, T2>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::begin(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1));
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = vector[];
        let v3 = if (v1 == 0 || !tradable<T0, T1, T2>(arg1, arg5)) {
            0
        } else {
            limit(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg1), arg2, arg3)
        };
        let v4 = if (v3 == 0) {
            0
        } else {
            reserve_out<T0, T1, T2>(arg1, arg2)
        };
        let v5 = 0;
        while (v5 < v1) {
            let v6 = if (v3 == 0) {
                0
            } else {
                probe<T0, T1, T2>(arg1, arg2, *0x1::vector::borrow<u64>(&v0, v5), v3, v4, arg4, arg5, arg6)
            };
            0x1::vector::push_back<u64>(&mut v2, v6);
            v5 = v5 + 1;
        };
        0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::end(arg0, v2);
    }

    public fun quote_a2b<T0, T1, T2>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        quote<T0, T1, T2>(arg0, arg1, true, arg2, arg3, arg4, arg5);
    }

    public fun quote_b2a<T0, T1, T2>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        quote<T0, T1, T2>(arg0, arg1, false, arg2, arg3, arg4, arg5);
    }

    public fun repay_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: Flash<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let Flash { receipt: v0 } = arg1;
        if (0x1::option::is_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v0);
            return arg2
        };
        let v1 = 0x1::option::destroy_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v0);
        let (_, _, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v1);
        assert!(0x2::balance::value<T0>(&arg2) >= v4, 7702);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v4), arg4), 0x2::coin::zero<T1>(arg4), v1, arg3);
        arg2
    }

    public fun repay_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: Flash<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let Flash { receipt: v0 } = arg1;
        if (0x1::option::is_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v0);
            return arg2
        };
        let v1 = 0x1::option::destroy_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v0);
        let (_, _, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v1);
        assert!(0x2::balance::value<T1>(&arg2) >= v4, 7702);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2, v4), arg4), v1, arg3);
        arg2
    }

    fun reserve_out<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool) : u64 {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T2>(arg0);
        if (arg1) {
            v1
        } else {
            v0
        }
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return 0x2::balance::zero<T1>()
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), true, (v0 as u128), true, 4295048017, arg2, arg3, arg4);
        let v4 = v3;
        0x2::coin::destroy_zero<T0>(v1);
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        assert!(v7 == v0, 7701);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(arg1, arg4), 0x2::coin::zero<T1>(arg4), v4, arg3);
        0x2::coin::into_balance<T1>(v2)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return 0x2::balance::zero<T0>()
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), false, (v0 as u128), true, 79226673515401279992447579054, arg2, arg3, arg4);
        let v4 = v3;
        0x2::coin::destroy_zero<T1>(v2);
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        assert!(v7 == v0, 7701);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(arg1, arg4), v4, arg3);
        0x2::coin::into_balance<T0>(v1)
    }

    fun tradable<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) : bool {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_unlocked<T0, T1, T2>(arg0) && 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::version(arg1) <= 18
    }

    // decompiled from Move bytecode v7
}

