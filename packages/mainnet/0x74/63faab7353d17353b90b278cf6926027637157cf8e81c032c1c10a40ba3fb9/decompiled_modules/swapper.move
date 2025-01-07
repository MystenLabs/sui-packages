module 0x7463faab7353d17353b90b278cf6926027637157cf8e81c032c1c10a40ba3fb9::swapper {
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
        0x2::tx_context::sender(arg0) == @0x84276c0c004b538687cabbc89ce68a8cc60e6202ec27c227afdb998e4234491b || 0x2::tx_context::sender(arg0) == @0x58571b065f05c1472c16341b438870b851dc87bd56d80ddc59e8e00364f6bb6c || 0x2::tx_context::sender(arg0) == @0xfbe8f5b928e9235f80c73d690cf5adf34f69c3ca0182c234925ad8e679eef566 || 0x2::tx_context::sender(arg0) == @0xd19dc183c90a2cf7e9ba53bf31968c0d5bbb2e65fa46ca8f50761471a1cecf37 || 0x2::tx_context::sender(arg0) == @0xcf4898fcd07d4f51c3d3bff215d47a322aba67fd61978daa5080d8469eb03717 || 0x2::tx_context::sender(arg0) == @0x6bf6749e65dc0888ae77f1e200bffb2f68bb1fc07453df8efb8eed49b11c22e8 || 0x2::tx_context::sender(arg0) == @0x336849efb012276c606cb38aa87d92601ba089c9da0f512882b7ef106d934f6d
    }

    // decompiled from Move bytecode v6
}

