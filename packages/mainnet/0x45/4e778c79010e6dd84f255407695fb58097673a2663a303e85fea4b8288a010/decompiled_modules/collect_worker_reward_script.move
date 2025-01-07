module 0x454e778c79010e6dd84f255407695fb58097673a2663a303e85fea4b8288a010::collect_worker_reward_script {
    public entry fun collect_reward<T0, T1, T2, T3>(arg0: &mut 0x9cb48aa1b41a1183ecdabde578e640e05a08170f8ca165b743ffded0b1256391::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x9cb48aa1b41a1183ecdabde578e640e05a08170f8ca165b743ffded0b1256391::cetus_clmm_worker::collect_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun collect_reward_all_reverse<T0, T1, T2, T3>(arg0: &mut 0x9cb48aa1b41a1183ecdabde578e640e05a08170f8ca165b743ffded0b1256391::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x9cb48aa1b41a1183ecdabde578e640e05a08170f8ca165b743ffded0b1256391::cetus_clmm_worker::collect_reward_all_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun collect_reward_pool_reverse<T0, T1, T2, T3>(arg0: &mut 0x9cb48aa1b41a1183ecdabde578e640e05a08170f8ca165b743ffded0b1256391::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x9cb48aa1b41a1183ecdabde578e640e05a08170f8ca165b743ffded0b1256391::cetus_clmm_worker::collect_reward_pool_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun collect_reward_swap_reverse<T0, T1, T2, T3>(arg0: &mut 0x9cb48aa1b41a1183ecdabde578e640e05a08170f8ca165b743ffded0b1256391::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x9cb48aa1b41a1183ecdabde578e640e05a08170f8ca165b743ffded0b1256391::cetus_clmm_worker::collect_reward_swap_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

