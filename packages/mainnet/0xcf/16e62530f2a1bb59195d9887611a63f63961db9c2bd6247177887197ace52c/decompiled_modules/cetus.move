module 0xcf16e62530f2a1bb59195d9887611a63f63961db9c2bd6247177887197ace52c::cetus {
    struct Flash<phantom T0, phantom T1> {
        receipt: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>,
    }

    public fun repay_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: Flash<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let Flash { receipt: v0 } = arg2;
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v0);
            return arg3
        };
        0x89ea51fecbfebe48c0da3f1ade0189ca2065e39e1c16bc8fac83780a19a547f6::cetus::repay_a2b<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v0), arg3)
    }

    public fun repay_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: Flash<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        let Flash { receipt: v0 } = arg2;
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v0);
            return arg3
        };
        0x89ea51fecbfebe48c0da3f1ade0189ca2065e39e1c16bc8fac83780a19a547f6::cetus::repay_b2a<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v0), arg3)
    }

    public fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        0x89ea51fecbfebe48c0da3f1ade0189ca2065e39e1c16bc8fac83780a19a547f6::cetus::swap_a2b<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        0x89ea51fecbfebe48c0da3f1ade0189ca2065e39e1c16bc8fac83780a19a547f6::cetus::swap_b2a<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun flash_a2b<T0, T1>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, Flash<T0, T1>) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Flash<T0, T1>{receipt: 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3) = 0x89ea51fecbfebe48c0da3f1ade0189ca2065e39e1c16bc8fac83780a19a547f6::cetus::flash_out_a2b<T0, T1>(arg2, arg3, v0, arg4);
        let v4 = Flash<T0, T1>{receipt: 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v3)};
        (v2, v4)
    }

    public fun flash_b2a<T0, T1>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Flash<T0, T1>) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Flash<T0, T1>{receipt: 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3) = 0x89ea51fecbfebe48c0da3f1ade0189ca2065e39e1c16bc8fac83780a19a547f6::cetus::flash_out_b2a<T0, T1>(arg2, arg3, v0, arg4);
        let v4 = Flash<T0, T1>{receipt: 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v3)};
        (v2, v4)
    }

    public fun out<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, true, arg2);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            return 0
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
    }

    fun quote<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::begin(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1));
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = vector[];
        if (v1 > 0 && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_swap<T0, T1>(arg1)) {
            let v3 = 0;
            while (v3 < v1) {
                0x1::vector::push_back<u64>(&mut v2, 0);
                v3 = v3 + 1;
            };
        } else {
            let v4 = 0;
            while (v4 < v1) {
                0x1::vector::push_back<u64>(&mut v2, out<T0, T1>(arg1, arg2, *0x1::vector::borrow<u64>(&v0, v4)));
                v4 = v4 + 1;
            };
        };
        0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::end(arg0, v2);
    }

    public fun quote_a2b<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        quote<T0, T1>(arg0, arg1, true);
    }

    public fun quote_b2a<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        quote<T0, T1>(arg0, arg1, false);
    }

    // decompiled from Move bytecode v7
}

