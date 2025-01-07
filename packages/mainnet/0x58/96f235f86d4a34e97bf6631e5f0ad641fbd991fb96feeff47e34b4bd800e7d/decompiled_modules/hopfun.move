module 0x5896f235f86d4a34e97bf6631e5f0ad641fbd991fb96feeff47e34b4bd800e7d::hopfun {
    fun get_1(arg0: u64) : u64 {
        arg0 + arg0 / 100
    }

    public fun hop_fun_swap<T0>(arg0: &mut 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::KongBot<0x2::sui::SUI>, arg1: &mut 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::Banana<0x2::sui::SUI>, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::transfer_bananas<0x2::sui::SUI>(arg0, arg1, arg3, arg6);
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::buy<T0>(arg2, arg4, v1, get_1(arg5), arg5, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun hop_fun_swap_sell<T0>(arg0: &mut 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::KongBot<0x2::sui::SUI>, arg1: &mut 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::Banana<0x2::sui::SUI>, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::transfer_bananas<0x2::sui::SUI>(arg0, arg1, 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::sell_returns<T0>(arg2, arg4, arg3, arg5, arg6), arg6);
        0x5896f235f86d4a34e97bf6631e5f0ad641fbd991fb96feeff47e34b4bd800e7d::utils::transfer_or_destroy_coin<0x2::sui::SUI>(v1, arg6);
    }

    // decompiled from Move bytecode v6
}

