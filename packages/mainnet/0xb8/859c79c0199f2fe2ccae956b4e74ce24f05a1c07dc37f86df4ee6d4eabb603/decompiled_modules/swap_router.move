module 0xb8859c79c0199f2fe2ccae956b4e74ce24f05a1c07dc37f86df4ee6d4eabb603::swap_router {
    struct RouterState has key {
        id: 0x2::object::UID,
        swap_cap: 0x1::option::Option<0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::SwapCap>,
    }

    entry fun deposit_swap_cap(arg0: &mut RouterState, arg1: 0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::SwapCap) {
        0x1::option::fill<0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::SwapCap>(&mut arg0.swap_cap, arg1);
    }

    public fun do_swap<T0, T1, T2>(arg0: &mut RouterState, arg1: &mut 0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::State, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::swap<T0, T1, T2>(arg1, 0x1::option::borrow<0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::SwapCap>(&arg0.swap_cap), arg2, arg3, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RouterState{
            id       : 0x2::object::new(arg0),
            swap_cap : 0x1::option::none<0x443ab6e1662cc575e99f368dc661dbc94ee12fbf43dd4c09538ae465b7a7acac::swap_pool::SwapCap>(),
        };
        0x2::transfer::share_object<RouterState>(v0);
    }

    // decompiled from Move bytecode v6
}

