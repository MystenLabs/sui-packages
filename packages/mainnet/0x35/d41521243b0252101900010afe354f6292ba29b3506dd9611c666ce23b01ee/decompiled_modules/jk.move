module 0x35d41521243b0252101900010afe354f6292ba29b3506dd9611c666ce23b01ee::jk {
    public fun cetuswap_0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x1::option::destroy_some<0x2::coin::Coin<T1>>(0x35d41521243b0252101900010afe354f6292ba29b3506dd9611c666ce23b01ee::execution::maybe_a2b<T0, T1>(arg0, arg1, arg2, 0x1::option::some<0x2::coin::Coin<T0>>(arg3), arg4))
    }

    public fun cetuswap_1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1::option::destroy_some<0x2::coin::Coin<T0>>(0x35d41521243b0252101900010afe354f6292ba29b3506dd9611c666ce23b01ee::execution::maybe_b2a<T0, T1>(arg0, arg1, arg2, 0x1::option::some<0x2::coin::Coin<T1>>(arg3), arg4))
    }

    // decompiled from Move bytecode v7
}

