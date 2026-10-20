module 0x6bfcd7e18440087ad1be914451e22b9da81732c47f6b015e6effd6da824cd44c::h {
    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg1: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg3);
        let (v0, v1) = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::buy_returns<T0>(arg0, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg3), 18446744073709551615, 0, @0x0, arg3);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        0x2::coin::into_balance<T0>(v1)
    }

    public fun xs<T0>(arg0: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg1: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg3);
        0x2::coin::into_balance<0x2::sui::SUI>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::sell_returns<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(arg2, arg3), 0, arg3))
    }

    // decompiled from Move bytecode v7
}

