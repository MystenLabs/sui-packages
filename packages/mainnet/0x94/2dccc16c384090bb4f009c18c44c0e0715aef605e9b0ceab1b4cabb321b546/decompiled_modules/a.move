module 0x50100bc13ea92f9963acfcf0b167a3be11426b5bd405dc1c67eee3aca3cd5bb0::a {
    public fun return_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun x1<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg1, arg2, arg0, 0x2::coin::zero<T1>(arg3), arg3);
        return_remaining_coin<T0>(v0, arg3);
        v1
    }

    public fun x2<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&arg0), 4295048017, arg3);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), v2);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun x4<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::coin::value<T0>(&arg0), arg0, 1, arg1, arg2)
    }

    public fun x5<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T0, T1>(arg0, 0x2::coin::value<T0>(&arg0), 1, arg1, arg2, arg3)
    }

    public fun x6<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, arg0, 0x2::coin::value<T0>(&arg0), 1, arg2)
    }

    public fun x7<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg2: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let (v1, v2) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_reserves_size<T0, T1>(arg1);
        let (v3, v4) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_fees_config<T0, T1>(arg1);
        let (v5, v6) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::swap<T0, T1>(arg1, arg2, arg3, arg0, v0, 0x2::coin::zero<T1>(arg4), 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_amount_out<T0, T1>(v1, v2, v3, v4, v0), arg4);
        return_remaining_coin<T0>(v5, arg4);
        v6
    }

    public fun x8<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg2: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let (v1, v2) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_reserves_size<T0, T1>(arg1);
        let (v3, v4) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_fees_config<T0, T1>(arg1);
        let (v5, v6) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::swap<T0, T1>(arg1, arg2, arg3, arg0, v0, 0x2::coin::zero<T1>(arg4), 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_amount_out<T0, T1>(v1, v2, v3, v4, v0), arg4);
        return_remaining_coin<T0>(v5, arg4);
        v6
    }

    public fun x9<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T0>>(arg0), 0x2::coin::value<T0>(&arg0), arg2, arg3);
        return_remaining_coin<T0>(v0, arg3);
        v1
    }

    public fun xa<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::swap_token_x<T0, T1>(arg1, arg2, arg0, 0x2::coin::value<T0>(&arg0), arg3)
    }

    public fun xb<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::Global, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, _, _, _) = 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::swap_out<T0, T1>(arg1, arg0, 1, true, arg2);
        v0
    }

    public fun y1<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg1, arg2, 0x2::coin::zero<T0>(arg3), arg0, arg3);
        return_remaining_coin<T1>(v1, arg3);
        v0
    }

    public fun y2<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&arg0), 79226673515401279992447579054, arg3);
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v2);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun y4<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(0x2::coin::value<T1>(&arg0), arg0, 1, arg1, arg2)
    }

    public fun y5<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T1, T0>(arg0, 0x2::coin::value<T1>(&arg0), 1, arg1, arg2, arg3)
    }

    public fun y6<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, arg0, 0x2::coin::value<T1>(&arg0), 1, arg2)
    }

    public fun y7<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg2: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        let (v1, v2) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_reserves_size<T1, T0>(arg1);
        let (v3, v4) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_fees_config<T1, T0>(arg1);
        let (v5, v6) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T0>(arg4), 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_amount_out<T1, T0>(v1, v2, v3, v4, v0), arg0, v0, arg4);
        return_remaining_coin<T1>(v6, arg4);
        v5
    }

    public fun y8<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg2: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        let (v1, v2) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_reserves_size<T1, T0>(arg1);
        let (v3, v4) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_fees_config<T1, T0>(arg1);
        let (v5, v6) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T0>(arg4), 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_amount_out<T1, T0>(v1, v2, v3, v4, v0), arg0, v0, arg4);
        return_remaining_coin<T1>(v6, arg4);
        v5
    }

    public fun y9<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T1>>(arg0), 0x2::coin::value<T1>(&arg0), arg2, arg3);
        return_remaining_coin<T1>(v0, arg3);
        v1
    }

    public fun ya<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::swap_token_y<T0, T1>(arg1, arg2, arg0, 0x2::coin::value<T1>(&arg0), arg3)
    }

    public fun yb<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::Global, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, _, _, _) = 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::swap_out<T1, T0>(arg1, arg0, 1, false, arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

