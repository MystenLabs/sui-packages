module 0x408764241a79a97ce35f8253c23f48eff0e4b68da0b47352424b4e1f3e6640e4::cetus_clmm_protocol {
    public(friend) fun swap_a_to_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::zero<T1>(arg4), true, true, 0x2::coin::value<T0>(&arg2), 4295048016, false, arg3, arg4)
    }

    public(friend) fun swap_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T0, T1>(arg0, arg1, 0x2::coin::zero<T0>(arg4), arg2, false, true, 0x2::coin::value<T1>(&arg2), 79226673515401279992447579055, false, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

