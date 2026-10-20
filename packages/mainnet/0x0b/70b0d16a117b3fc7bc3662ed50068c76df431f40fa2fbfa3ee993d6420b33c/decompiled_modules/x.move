module 0xb70b0d16a117b3fc7bc3662ed50068c76df431f40fa2fbfa3ee993d6420b33c::x {
    public fun ab<T0, T1>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg2);
        0x2::coin::into_balance<T1>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_x_for_coin_y<T0, T1, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Uncorrelated>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), 0, arg2))
    }

    public fun ac<T0, T1>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg2);
        0x2::coin::into_balance<T1>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_x_for_coin_y<T0, T1, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Stable>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), 0, arg2))
    }

    public fun ba<T0, T1>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg2);
        0x2::coin::into_balance<T0>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_y_for_coin_x<T0, T1, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Uncorrelated>(arg0, 0x2::coin::from_balance<T1>(arg1, arg2), 0, arg2))
    }

    public fun ca<T0, T1>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg2);
        0x2::coin::into_balance<T0>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_y_for_coin_x<T0, T1, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Stable>(arg0, 0x2::coin::from_balance<T1>(arg1, arg2), 0, arg2))
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        ab<0x2::sui::SUI, T0>(arg0, arg1, arg2)
    }

    public fun sy<T0>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        ac<0x2::sui::SUI, T0>(arg0, arg1, arg2)
    }

    public fun xs<T0>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        ba<0x2::sui::SUI, T0>(arg0, arg1, arg2)
    }

    public fun ys<T0>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        ca<0x2::sui::SUI, T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

