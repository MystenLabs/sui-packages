module 0xb5104a5ba1d7d8e213efc4705fa2ec6b5066302d697916754cacd9426aed0ec1::swap_router {
    struct RouterState has key {
        id: 0x2::object::UID,
        swap_cap: 0x1::option::Option<0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::SwapCap>,
    }

    entry fun deposit_swap_cap(arg0: &mut RouterState, arg1: 0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::SwapCap) {
        0x1::option::fill<0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::SwapCap>(&mut arg0.swap_cap, arg1);
    }

    public fun do_swap<T0, T1, T2>(arg0: &mut RouterState, arg1: &mut 0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::State, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::swap<T0, T1, T2>(arg1, 0x1::option::borrow<0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::SwapCap>(&arg0.swap_cap), arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RouterState{
            id       : 0x2::object::new(arg0),
            swap_cap : 0x1::option::none<0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool::SwapCap>(),
        };
        0x2::transfer::share_object<RouterState>(v0);
    }

    // decompiled from Move bytecode v6
}

