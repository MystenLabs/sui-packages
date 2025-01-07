module 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router {
    public entry fun add_stable_liquidity<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0x2::pay::keep<T0>(arg0, arg8);
        0x2::pay::keep<T1>(arg3, arg8);
        if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let (v1, v2, v3) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::add_liquidity<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T0, T1>(arg6), arg7, 0x2::coin::split<T0>(&mut arg0, arg1, arg8), arg2, 0x2::coin::split<T1>(&mut arg3, arg4, arg8), arg5, arg8);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::destroy_zero_coin<T0>(v1, v0);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::destroy_zero_coin<T1>(v2, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::LSP<T0, T1>>>(v3, v0);
        } else {
            let (v4, v5, v6) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::add_liquidity<T1, T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T1, T0>(arg6), arg7, 0x2::coin::split<T1>(&mut arg3, arg4, arg8), arg5, 0x2::coin::split<T0>(&mut arg0, arg1, arg8), arg2, arg8);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::destroy_zero_coin<T1>(v4, v0);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::destroy_zero_coin<T0>(v5, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::LSP<T1, T0>>>(v6, v0);
        };
    }

    public entry fun create_stable_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::check_stable_pool_exist<T0, T1>(arg8) || 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::check_stable_pool_exist<T1, T0>(arg8);
        if (!v1) {
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::create_pool<T0, T1>(arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        };
        if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let (v2, v3, v4) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::add_liquidity<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T0, T1>(arg8), arg9, arg0, 0, arg2, 0, arg10);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::destroy_zero_coin<T0>(v2, v0);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::destroy_zero_coin<T1>(v3, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::LSP<T0, T1>>>(v4, v0);
        } else {
            let (v5, v6, v7) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::add_liquidity<T1, T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T1, T0>(arg8), arg9, arg2, 0, arg0, 0, arg10);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::destroy_zero_coin<T1>(v5, v0);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::destroy_zero_coin<T0>(v6, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::LSP<T1, T0>>>(v7, v0);
        };
    }

    public entry fun remove_liquidity<T0, T1>(arg0: 0x2::coin::Coin<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::LSP<T0, T1>>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::pay::keep<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::LSP<T0, T1>>(arg0, arg6);
        let (v1, v2) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::remove_liquidity<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T0, T1>(arg4), arg5, 0x2::coin::split<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::LSP<T0, T1>>(&mut arg0, arg1, arg6), arg2, arg3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0);
    }

    public entry fun swap_exact_input<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(arg0, arg5);
        let v0 = if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::swap_exact_x_to_y<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T0, T1>(arg3), arg4, 0x2::coin::split<T0>(&mut arg0, arg1, arg5), arg2, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg5));
            0x2::coin::value<T1>(&v1)
        } else {
            let v2 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::swap_exact_y_to_x<T1, T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T1, T0>(arg3), arg4, 0x2::coin::split<T0>(&mut arg0, arg1, arg5), arg2, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg5));
            0x2::coin::value<T1>(&v2)
        };
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::add_stable_swap_event_internal<T0, T1>(arg1, 0, 0, v0, arg3, arg5);
    }

    public fun swap_exact_input_<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::pay::keep<T0>(arg0, arg5);
        let (v0, v1) = if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let v2 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::swap_exact_x_to_y<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T0, T1>(arg3), arg4, 0x2::coin::split<T0>(&mut arg0, arg1, arg5), arg2, arg5);
            (0x2::coin::value<T1>(&v2), v2)
        } else {
            let v3 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::swap_exact_y_to_x<T1, T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T1, T0>(arg3), arg4, 0x2::coin::split<T0>(&mut arg0, arg1, arg5), arg2, arg5);
            (0x2::coin::value<T1>(&v3), v3)
        };
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::add_stable_swap_event_internal<T0, T1>(arg1, 0, 0, v0, arg3, arg5);
        v1
    }

    public entry fun swap_exact_output<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(arg0, arg5);
        let v0 = if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let (v1, v2) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::swap_x_to_exact_y<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T0, T1>(arg3), arg4, 0x2::coin::split<T0>(&mut arg0, arg1, arg5), arg2, arg5);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::destroy_zero_coin<T1>(v1, 0x2::tx_context::sender(arg5));
            v2
        } else {
            let (v3, v4) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::swap_y_to_exact_x<T1, T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T1, T0>(arg3), arg4, 0x2::coin::split<T0>(&mut arg0, arg1, arg5), arg2, arg5);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::destroy_zero_coin<T1>(v3, 0x2::tx_context::sender(arg5));
            v4
        };
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::add_stable_swap_event_internal<T0, T1>(v0, 0, 0, arg2, arg3, arg5);
    }

    public fun swap_exact_output_<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::pay::keep<T0>(arg0, arg5);
        let (v0, v1) = if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let (v2, v3) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::swap_x_to_exact_y<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T0, T1>(arg3), arg4, 0x2::coin::split<T0>(&mut arg0, arg1, arg5), arg2, arg5);
            (v3, v2)
        } else {
            let (v4, v5) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::swap_y_to_exact_x<T1, T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::get_stable_pool<T1, T0>(arg3), arg4, 0x2::coin::split<T0>(&mut arg0, arg1, arg5), arg2, arg5);
            (v5, v4)
        };
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::add_stable_swap_event_internal<T0, T1>(v0, 0, 0, arg2, arg3, arg5);
        v1
    }

    // decompiled from Move bytecode v6
}

