module 0x2fb94523af25ff435f4f9973e641b3e07fd528ade6d6b12cede7a00a2113ca1a::dex_cetus {
    struct SwapExecuted has copy, drop {
        dex_name: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        trader: address,
        pool_address: address,
    }

    public fun swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 - v0 * 30 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        let v2 = SwapExecuted{
            dex_name     : b"Cetus",
            amount_in    : v0,
            amount_out   : v1,
            trader       : arg1,
            pool_address : @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1, arg2)
    }

    public fun get_dex_info() : 0x2fb94523af25ff435f4f9973e641b3e07fd528ade6d6b12cede7a00a2113ca1a::dex_trait::DexInfo {
        0x2fb94523af25ff435f4f9973e641b3e07fd528ade6d6b12cede7a00a2113ca1a::dex_trait::create_dex_info(b"Cetus", 30, @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb)
    }

    public fun swap_cross<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 0x2fb94523af25ff435f4f9973e641b3e07fd528ade6d6b12cede7a00a2113ca1a::constants::get_zero_amount_error());
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 4295048016, arg4);
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v3);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg6);
        let v5 = SwapExecuted{
            dex_name     : b"Cetus-Cross",
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v4),
            trader       : arg5,
            pool_address : 0x2fb94523af25ff435f4f9973e641b3e07fd528ade6d6b12cede7a00a2113ca1a::constants::get_cetus_sui_usdc_pool(),
        };
        0x2::event::emit<SwapExecuted>(v5);
        v4
    }

    public fun swap_cross_simple<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0x2fb94523af25ff435f4f9973e641b3e07fd528ade6d6b12cede7a00a2113ca1a::constants::get_zero_amount_error());
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 4295048016, arg3);
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), v3);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg5);
        let v5 = SwapExecuted{
            dex_name     : b"Cetus-Cross-Simple",
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v4),
            trader       : arg4,
            pool_address : 0x2fb94523af25ff435f4f9973e641b3e07fd528ade6d6b12cede7a00a2113ca1a::constants::get_cetus_sui_usdc_pool(),
        };
        0x2::event::emit<SwapExecuted>(v5);
        v4
    }

    public fun swap_generic<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 - v0 * 30 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x0);
        let v2 = SwapExecuted{
            dex_name     : b"Cetus",
            amount_in    : v0,
            amount_out   : v1,
            trader       : arg1,
            pool_address : @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::split<T0>(&mut arg0, v1, arg2)
    }

    // decompiled from Move bytecode v6
}

