module 0x11f71dd648341399c43c798c7493d2cf9606ae2c9b8b83f9973c5bb61aec031b::uranus {
    public fun swap_atob<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg3, 4295048016, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        let v3 = 0x11f71dd648341399c43c798c7493d2cf9606ae2c9b8b83f9973c5bb61aec031b::util::merge_all<T0>(arg2, arg5);
        0x11f71dd648341399c43c798c7493d2cf9606ae2c9b8b83f9973c5bb61aec031b::util::transfer<T0>(v3, 0x2::tx_context::sender(arg5));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, arg3, arg5)), 0x2::balance::zero<T1>(), v2);
        0x11f71dd648341399c43c798c7493d2cf9606ae2c9b8b83f9973c5bb61aec031b::util::transfer<T1>(0x2::coin::from_balance<T1>(v1, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun swap_btoa<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, 79226673515401279992447579055, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x11f71dd648341399c43c798c7493d2cf9606ae2c9b8b83f9973c5bb61aec031b::util::merge_all<T1>(arg2, arg5);
        0x11f71dd648341399c43c798c7493d2cf9606ae2c9b8b83f9973c5bb61aec031b::util::transfer<T1>(v3, 0x2::tx_context::sender(arg5));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v3, arg3, arg5)), v2);
        0x11f71dd648341399c43c798c7493d2cf9606ae2c9b8b83f9973c5bb61aec031b::util::transfer<T0>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

