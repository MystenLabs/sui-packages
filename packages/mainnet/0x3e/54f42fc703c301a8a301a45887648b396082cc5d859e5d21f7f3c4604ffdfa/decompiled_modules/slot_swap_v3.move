module 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot_swap_v3 {
    public entry fun buy_with_base_cetus<T0>(arg0: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::bank::Bank, arg1: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::Slot, arg5: u64, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::swap_v3_cetus<T0, 0x2::sui::SUI>(0x2::coin::zero<T0>(arg9), 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::calc_and_transfer_fees(arg0, arg1, 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::take_from_balance<0x2::sui::SUI>(arg4, arg5, true, arg9), arg2, arg3, arg9), arg6, arg7, arg8, arg9);
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v0));
    }

    public entry fun buy_with_base_turbos<T0, T1>(arg0: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::bank::Bank, arg1: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::Slot, arg5: u64, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::swap_v3_turbos<T0, 0x2::sui::SUI, T1>(0x2::coin::zero<T0>(arg9), 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::calc_and_transfer_fees(arg0, arg1, 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::take_from_balance<0x2::sui::SUI>(arg4, arg5, true, arg9), arg2, arg3, arg9), arg6, arg7, arg8, arg9);
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v0));
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
    }

    public entry fun sell_with_base_cetus<T0>(arg0: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::bank::Bank, arg1: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::Slot, arg5: u64, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg8: u64, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::swap_v3_cetus<T0, 0x2::sui::SUI>(0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::take_from_balance<T0>(arg4, arg5, true, arg11), 0x2::coin::zero<0x2::sui::SUI>(arg11), arg6, arg7, arg10, arg11);
        let v2 = v1;
        let v3 = v2;
        v2 = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::calc_and_transfer_fees(arg0, arg1, v3, arg2, arg3, arg11);
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::check_and_transfer_sponsor_gas(&mut v2, arg8, arg9, arg11);
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v0));
    }

    public entry fun sell_with_base_turbos<T0, T1>(arg0: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::bank::Bank, arg1: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::Slot, arg5: u64, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: u64, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::swap_v3_turbos<T0, 0x2::sui::SUI, T1>(0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::take_from_balance<T0>(arg4, arg5, true, arg11), 0x2::coin::zero<0x2::sui::SUI>(arg11), arg6, arg7, arg10, arg11);
        let v2 = v1;
        let v3 = v2;
        v2 = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::calc_and_transfer_fees(arg0, arg1, v3, arg2, arg3, arg11);
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::check_and_transfer_sponsor_gas(&mut v2, arg8, arg9, arg11);
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v0));
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
    }

    public entry fun swap_cetus<T0, T1>(arg0: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::Slot, arg1: u64, arg2: bool, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg2) {
            0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::swap_v3_cetus<T0, T1>(0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::take_from_balance<T0>(arg0, arg1, true, arg6), 0x2::coin::zero<T1>(arg6), arg3, arg4, arg5, arg6)
        } else {
            0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::swap_v3_cetus<T0, T1>(0x2::coin::zero<T0>(arg6), 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::take_from_balance<T1>(arg0, arg1, true, arg6), arg3, arg4, arg5, arg6)
        };
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v0));
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1));
    }

    public entry fun swap_turbos<T0, T1, T2>(arg0: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::Slot, arg1: u64, arg2: bool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::utils::not_base<T0>();
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::utils::not_base<T1>();
        let v0 = 0x2::coin::zero<T0>(arg6);
        let v1 = 0x2::coin::zero<T1>(arg6);
        if (arg2) {
            0x2::coin::join<T0>(&mut v0, 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::take_from_balance<T0>(arg0, arg1, true, arg6));
        } else {
            0x2::coin::join<T1>(&mut v1, 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::take_from_balance<T1>(arg0, arg1, true, arg6));
        };
        let (v2, v3) = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router::swap_v3_turbos<T0, T1, T2>(v0, v1, arg3, arg4, arg5, arg6);
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::slot::add_to_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v3));
    }

    // decompiled from Move bytecode v6
}

