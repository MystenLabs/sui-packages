module 0xdda3946bf164e811e4814d3e83be4aa684afe9f2de619a43063fad23011759c5::adapters {
    public fun cetus_adapter<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg0) == 0 || 0x2::coin::value<T1>(&arg1) == 0, 0);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            let (v0, v1) = 0xdda3946bf164e811e4814d3e83be4aa684afe9f2de619a43063fad23011759c5::utils::cetus_swap<T0, T1>(arg4, arg3, arg0, 0x2::coin::split<T1>(&mut arg1, arg2, arg6), false, true, arg2, 79226673515401279992447579054, arg5, arg6);
            0x2::coin::destroy_zero<T1>(v1);
            return (v0, arg1)
        };
        let (v2, v3) = 0xdda3946bf164e811e4814d3e83be4aa684afe9f2de619a43063fad23011759c5::utils::cetus_swap<T0, T1>(arg4, arg3, 0x2::coin::split<T0>(&mut arg0, arg2, arg6), arg1, true, true, arg2, 4295048017, arg5, arg6);
        0x2::coin::destroy_zero<T0>(v2);
        (arg0, v3)
    }

    public fun kriya_adapter<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg0) == 0 || 0x2::coin::value<T1>(&arg1) == 0, 0);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            let (v0, v1) = 0xdda3946bf164e811e4814d3e83be4aa684afe9f2de619a43063fad23011759c5::utils::kriya_v2_swap<T0, T1>(arg3, arg0, 0x2::coin::split<T1>(&mut arg1, arg2, arg4), false, arg2, arg4);
            0x2::coin::destroy_zero<T1>(v1);
            return (v0, arg1)
        };
        let (v2, v3) = 0xdda3946bf164e811e4814d3e83be4aa684afe9f2de619a43063fad23011759c5::utils::kriya_v2_swap<T0, T1>(arg3, 0x2::coin::split<T0>(&mut arg0, arg2, arg4), arg1, true, arg2, arg4);
        0x2::coin::destroy_zero<T0>(v2);
        (arg0, v3)
    }

    // decompiled from Move bytecode v6
}

