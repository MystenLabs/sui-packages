module 0xb888907b2d86fc1c39ee7574777f603a708897c71f0ab815998f50760cccebef::ferret {
    struct ContractData has store, key {
        id: 0x2::object::UID,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914, 10000000000);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun animeswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg4), 10000000002);
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T1>(arg4), arg4);
        transfer_or_destroy_zero<T0>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    public fun animeswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg4), 10000000002);
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg1, arg2, 0x2::coin::zero<T0>(arg4), arg3, arg4);
        transfer_or_destroy_zero<T1>(v1, 0x2::tx_context::sender(arg4));
        v0
    }

    public fun belaunchswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::Global, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg3), 10000000002);
        let (v0, _, _, _) = 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::swap_out<T0, T1>(arg1, arg2, 0, true, arg3);
        v0
    }

    public fun belaunchswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::Global, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg3), 10000000002);
        let (v0, _, _, _) = 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::swap_out<T1, T0>(arg1, arg2, 0, false, arg3);
        v0
    }

    public fun bluemoveswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg3), 10000000002);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::coin::value<T0>(&arg2), arg2, 0, arg1, arg3)
    }

    public fun bluemoveswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg3), 10000000002);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(0x2::coin::value<T1>(&arg2), arg2, 0, arg1, arg3)
    }

    public fun cetuswap_0<T0, T1>(arg0: &mut AccessList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg5), 10000000002);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&arg4), 4295048016, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(arg4), 0x2::balance::zero<T1>(), v2);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun cetuswap_1<T0, T1>(arg0: &mut AccessList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg5), 10000000002);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&arg4), 79226673515401279992447579055, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg4), v2);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_access_list(arg0);
    }

    public fun interestswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg4), 10000000002);
        0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::swap_token_x<T0, T1>(arg1, arg2, arg3, 0, arg4)
    }

    public fun interestswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg4), 10000000002);
        0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::swap_token_y<T0, T1>(arg1, arg2, arg3, 0, arg4)
    }

    fun is_valid(arg0: &mut AccessList, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = arg0.list;
        let v1 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun jujubeswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg2: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg3: &0x2::clock::Clock, arg4: vector<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T1>> {
        assert!(is_valid(arg0, arg5), 10000000002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg4);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg4);
        let (v1, v2) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_reserves_size<T0, T1>(arg1);
        let (v3, v4) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_fees_config<T0, T1>(arg1);
        let (v5, v6) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::swap<T0, T1>(arg1, arg2, arg3, v0, 0, 0x2::coin::zero<T1>(arg5), 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_amount_out<T0, T1>(v1, v2, v3, v4, 0x2::coin::value<T0>(&v0)), arg5);
        0x2::coin::destroy_zero<T0>(v5);
        0x1::vector::singleton<0x2::coin::Coin<T1>>(v6)
    }

    public fun jujubeswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg2: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg3: &0x2::clock::Clock, arg4: vector<0x2::coin::Coin<T1>>, arg5: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(is_valid(arg0, arg5), 10000000002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg4);
        0x1::vector::destroy_empty<0x2::coin::Coin<T1>>(arg4);
        let (v1, v2) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_reserves_size<T1, T0>(arg1);
        let (v3, v4) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_fees_config<T1, T0>(arg1);
        let (v5, v6) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T0>(arg5), 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_amount_out<T1, T0>(v1, v2, v3, v4, 0x2::coin::value<T1>(&v0)), v0, 0, arg5);
        0x2::coin::destroy_zero<T1>(v6);
        0x1::vector::singleton<0x2::coin::Coin<T0>>(v5)
    }

    public fun kriyaswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg3), 10000000002);
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, arg2, 0x2::coin::value<T0>(&arg2), 0, arg3)
    }

    public fun kriyaswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg3), 10000000002);
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, arg2, 0x2::coin::value<T1>(&arg2), 0, arg3)
    }

    fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::singleton<address>(@0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914);
        0x1::vector::push_back<address>(&mut v0, @0x6a2fdf6ed9df04787cab1478d57c97755764da30afd41b0aeea9141fafa984ac);
        0x1::vector::push_back<address>(&mut v0, @0xf060418a475679985421b63daad483218c6de2c051abf60d40974c656a5655ba);
        0x1::vector::push_back<address>(&mut v0, @0x9513af2fcc963b8396bdafc83610d125ec1e6330080bdabb3cf7fc7e0df9c84b);
        0x1::vector::push_back<address>(&mut v0, @0x83dbcc5cd37cd5a6e67b62c42ae746687424e1fa2900b160502e7e63638c5df7);
        0x1::vector::push_back<address>(&mut v0, @0x2615225a2d6de6f00725269813b12ba28cabab55c657d9374910bab5447353e8);
        0x1::vector::push_back<address>(&mut v0, @0x2a5ac6061f5292986adc503f14ffcae89066bc3e9e870ca8e218de0e47e02d2b);
        0x1::vector::push_back<address>(&mut v0, @0x78836e603db75cd5fcae3ab9ca84b08289662958bc7e22aa5ba22f319bd89d76);
        0x1::vector::push_back<address>(&mut v0, @0x739690bd8aaf1cde18e35b11a8e392163c2f20fb507e208baac7eab9b5861543);
        0x1::vector::push_back<address>(&mut v0, @0x3801731f782be9c067a0a19aa39c777c9412e3bc5c25fa396cd6f771971dadc7);
        let v1 = AccessList{
            id   : 0x2::object::new(arg0),
            list : v0,
        };
        0x2::transfer::share_object<AccessList>(v1);
    }

    public fun stable_bluemoveswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg4), 10000000002);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T0, T1>(arg3, 0x2::coin::value<T0>(&arg3), 0, arg1, arg2, arg4)
    }

    public fun stable_bluemoveswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg4), 10000000002);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T1, T0>(arg3, 0x2::coin::value<T1>(&arg3), 0, arg1, arg2, arg4)
    }

    public fun suiswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg4), 10000000002);
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T0>>(arg3), 0x2::coin::value<T0>(&arg3), arg2, arg4);
        transfer_or_destroy_zero<T0>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    public fun suiswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg4), 10000000002);
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T1>>(arg3), 0x2::coin::value<T1>(&arg3), arg2, arg4);
        transfer_or_destroy_zero<T1>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    public fun transfer_coins_with_threshold_2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 10000000001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

