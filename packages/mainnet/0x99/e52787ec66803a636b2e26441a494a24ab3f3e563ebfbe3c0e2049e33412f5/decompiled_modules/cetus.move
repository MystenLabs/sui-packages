module 0x3bc077d34efb18af154d31a7041bb44c67be35ef2c3db6ec7df0ff5f66f4841f::cetus {
    public fun flash_a2b<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::principal(arg0), 4295048016, arg3);
        0x2::balance::destroy_zero<T0>(v0);
        (v1, v2)
    }

    public fun flash_a2b_or_skip<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, u64) {
        if (!0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::live(arg0)) {
            return (0x2::balance::zero<T1>(), 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(), 0)
        };
        let (v0, v1) = flash_a2b<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        (v0, 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v2), owed<T0, T1>(&v2))
    }

    public fun flash_b2a<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::principal(arg0), 79226673515401279992447579055, arg3);
        0x2::balance::destroy_zero<T1>(v1);
        (v0, v2)
    }

    public fun flash_b2a_or_skip<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, u64) {
        if (!0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::live(arg0)) {
            return (0x2::balance::zero<T0>(), 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(), 0)
        };
        let (v0, v1) = flash_b2a<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        (v0, 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v2), owed<T0, T1>(&v2))
    }

    public fun owed<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : u64 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(arg0)
    }

    fun quote<T0, T1>(arg0: &mut 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u8, arg3: bool) {
        if (!0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::quoting(arg0)) {
            return
        };
        0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::record_quote(arg0, quote_amount<T0, T1>(arg1, 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::quote_input(arg0, arg2), arg3));
    }

    public fun quote_a2b<T0, T1>(arg0: &mut 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u8) {
        quote<T0, T1>(arg0, arg1, arg2, true);
    }

    fun quote_amount<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let v0 = 0;
        if (arg1 > 0 && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, T1>(arg0)) {
            let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg2, true, arg1);
            if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v1)) {
                v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1);
            };
        };
        v0
    }

    public fun quote_b2a<T0, T1>(arg0: &mut 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u8) {
        quote<T0, T1>(arg0, arg1, arg2, false);
    }

    fun quote_probes<T0, T1>(arg0: &mut 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Probes, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u8, arg3: bool) {
        let v0 = 0;
        while (v0 < 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::probe_count(arg0)) {
            0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::record_probe(arg0, quote_amount<T0, T1>(arg1, 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::probe_input(arg0, v0, arg2), arg3), 0);
            v0 = v0 + 1;
        };
    }

    public fun quote_probes_a2b<T0, T1>(arg0: &mut 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Probes, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u8) {
        quote_probes<T0, T1>(arg0, arg1, arg2, true);
    }

    public fun quote_probes_b2a<T0, T1>(arg0: &mut 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Probes, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u8) {
        quote_probes<T0, T1>(arg0, arg1, arg2, false);
    }

    public fun repay_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), arg3);
    }

    public fun repay_a2b_or_skip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>) {
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&arg3)) {
            0x2::balance::destroy_zero<T0>(arg2);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg3);
        } else {
            repay_a2b<T0, T1>(arg0, arg1, arg2, 0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg3));
        };
    }

    public fun repay_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, arg3);
    }

    public fun repay_b2a_or_skip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>) {
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&arg3)) {
            0x2::balance::destroy_zero<T1>(arg2);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg3);
        } else {
            repay_b2a<T0, T1>(arg0, arg1, arg2, 0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg3));
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048016, arg3);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v2);
        v1
    }

    public fun swap_a2b_or_skip<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        if (!0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::live(arg0)) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        swap_a2b<T0, T1>(arg1, arg2, arg3, arg4)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579055, arg3);
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v2);
        v0
    }

    public fun swap_b2a_or_skip<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        if (!0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::live(arg0)) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        swap_b2a<T0, T1>(arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

