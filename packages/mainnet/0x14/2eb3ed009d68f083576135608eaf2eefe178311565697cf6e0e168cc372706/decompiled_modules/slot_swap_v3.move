module 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot_swap_v3 {
    public entry fun buy_with_base_cetus<T0>(arg0: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::bank::Bank, arg1: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::Slot, arg5: u64, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg8: &0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::Platform, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_cetus<T0, 0x2::sui::SUI>(0x2::coin::zero<T0>(arg10), 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::calc_and_transfer_fees(arg0, arg1, 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<0x2::sui::SUI>(arg4, arg5, arg8, arg9, arg10), arg2, arg3, arg10), arg6, arg7, arg9, arg10);
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v0));
    }

    public entry fun buy_with_base_turbos<T0, T1>(arg0: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::bank::Bank, arg1: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::Slot, arg5: u64, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::Platform, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_turbos<T0, 0x2::sui::SUI, T1>(0x2::coin::zero<T0>(arg10), 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::calc_and_transfer_fees(arg0, arg1, 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<0x2::sui::SUI>(arg4, arg5, arg8, arg9, arg10), arg2, arg3, arg10), arg6, arg7, arg9, arg10);
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v0));
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
    }

    public entry fun sell_with_base_cetus<T0>(arg0: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::bank::Bank, arg1: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::Slot, arg5: u64, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg8: u64, arg9: 0x1::option::Option<address>, arg10: &0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::Platform, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_cetus<T0, 0x2::sui::SUI>(0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<T0>(arg4, arg5, arg10, arg11, arg12), 0x2::coin::zero<0x2::sui::SUI>(arg12), arg6, arg7, arg11, arg12);
        let v2 = v1;
        let v3 = v2;
        v2 = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::calc_and_transfer_fees(arg0, arg1, v3, arg2, arg3, arg12);
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::check_and_transfer_sponsor_gas(&mut v2, arg8, arg9, arg12);
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v0));
    }

    public entry fun sell_with_base_turbos<T0, T1>(arg0: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::bank::Bank, arg1: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::Slot, arg5: u64, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: u64, arg9: 0x1::option::Option<address>, arg10: &0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::Platform, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_turbos<T0, 0x2::sui::SUI, T1>(0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<T0>(arg4, arg5, arg10, arg11, arg12), 0x2::coin::zero<0x2::sui::SUI>(arg12), arg6, arg7, arg11, arg12);
        let v2 = v1;
        let v3 = v2;
        v2 = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::calc_and_transfer_fees(arg0, arg1, v3, arg2, arg3, arg12);
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::check_and_transfer_sponsor_gas(&mut v2, arg8, arg9, arg12);
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v0));
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
    }

    public entry fun swap_cetus<T0, T1>(arg0: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::Slot, arg1: u64, arg2: bool, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::Platform, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg2) {
            0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_cetus<T0, T1>(0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<T0>(arg0, arg1, arg5, arg6, arg7), 0x2::coin::zero<T1>(arg7), arg3, arg4, arg6, arg7)
        } else {
            0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_cetus<T0, T1>(0x2::coin::zero<T0>(arg7), 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<T1>(arg0, arg1, arg5, arg6, arg7), arg3, arg4, arg6, arg7)
        };
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v0));
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1));
    }

    public entry fun swap_turbos<T0, T1, T2>(arg0: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::Slot, arg1: u64, arg2: bool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::Platform, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::utils::not_base<T0>();
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::utils::not_base<T1>();
        let v0 = 0x2::coin::zero<T0>(arg7);
        let v1 = 0x2::coin::zero<T1>(arg7);
        if (arg2) {
            0x2::coin::join<T0>(&mut v0, 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<T0>(arg0, arg1, arg5, arg6, arg7));
        } else {
            0x2::coin::join<T1>(&mut v1, 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<T1>(arg0, arg1, arg5, arg6, arg7));
        };
        let (v2, v3) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_turbos<T0, T1, T2>(v0, v1, arg3, arg4, arg6, arg7);
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v3));
    }

    // decompiled from Move bytecode v6
}

