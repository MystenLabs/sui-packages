module 0x434980e486508becded9bbdea36b1f029505500a9b52ab2ac921af02d6d377b7::swapper {
    public fun bluemove<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun cetus_0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_whitelisted(arg5), 31415);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), 4295048016, arg4);
        let v3 = v1;
        assert!(0x2::balance::value<T1>(&v3) > arg3, 8001);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), v2);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v3, arg5)
    }

    public fun cetus_1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_whitelisted(arg5), 31415);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&arg2), 79226673515401279992447579055, arg4);
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) > arg3, 8002);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), v2);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v3, arg5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun is_whitelisted(arg0: &mut 0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg0) == @0x84276c0c004b538687cabbc89ce68a8cc60e6202ec27c227afdb998e4234491b || 0x2::tx_context::sender(arg0) == @0x58571b065f05c1472c16341b438870b851dc87bd56d80ddc59e8e00364f6bb6c || 0x2::tx_context::sender(arg0) == @0x170c2b02e324a22238a12db27f60b53d6639990935f2f176fe152a21626a5e11 || 0x2::tx_context::sender(arg0) == @0xe4d6449947bb048138d59b8044ac558294b855b92297ed3f1f483a6d9af14f1e || 0x2::tx_context::sender(arg0) == @0x24848df250c805c2e342c57ba3b9e58972a6840f3964fecf741fadda8e79dd24 || 0x2::tx_context::sender(arg0) == @0x3efca8882362423774bdbac1330e8362f5a31cc8edddba609421537dcdf34bab || 0x2::tx_context::sender(arg0) == @0x3330772f3b86cd8b11a5b6d356dbbd72461ee9d86ccf12fd5e571bd0dbeae9de
    }

    // decompiled from Move bytecode v6
}

