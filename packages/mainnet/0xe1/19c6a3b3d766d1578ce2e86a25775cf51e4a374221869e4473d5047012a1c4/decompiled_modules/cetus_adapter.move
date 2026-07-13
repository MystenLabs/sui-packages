module 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::cetus_adapter {
    fun complete_two_hop_swap<T0>(arg0: &0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::Config, arg1: &mut 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::FeeVault, arg2: 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::FeeReceipt, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::complete_swap<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun swap_a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 4295048017, arg3);
        let v4 = v1;
        0x2::balance::join<T0>(&mut v4, 0x2::coin::into_balance<T0>(arg0));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v4, 0x2::balance::zero<T1>(), v3);
        0x2::coin::from_balance<T1>(v2, arg4)
    }

    fun swap_b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 79226673515401279992447579054, arg3);
        let v4 = v2;
        0x2::balance::join<T1>(&mut v4, 0x2::coin::into_balance<T1>(arg0));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v4, v3);
        0x2::coin::from_balance<T0>(v1, arg4)
    }

    public fun swap_exact_input_a2b<T0, T1>(arg0: &0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::Config, arg1: &mut 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::FeeVault, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::prepare_swap_input<T0>(arg0, arg1, arg2, arg3, arg4, arg10);
        let v2 = swap_a2b<T0, T1>(v0, arg5, arg6, arg9, arg10);
        0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::complete_swap<T1>(arg0, arg1, v1, v2, arg7, arg8, arg4, arg10);
    }

    public fun swap_exact_input_b2a<T0, T1>(arg0: &0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::Config, arg1: &mut 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::FeeVault, arg2: vector<u8>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::prepare_swap_input<T1>(arg0, arg1, arg2, arg3, arg4, arg10);
        let v2 = swap_b2a<T0, T1>(v0, arg5, arg6, arg9, arg10);
        0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::complete_swap<T0>(arg0, arg1, v1, v2, arg7, arg8, arg4, arg10);
    }

    public fun swap_exact_input_two_hop_a2b_a2b<T0, T1, T2>(arg0: &0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::Config, arg1: &mut 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::FeeVault, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: bool, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg9: u64, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == arg4, 3);
        let (v0, v1) = 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::prepare_swap_input<T0>(arg0, arg1, arg2, arg3, arg5, arg12);
        let v2 = swap_a2b<T0, T1>(v0, arg6, arg7, arg11, arg12);
        let v3 = swap_a2b<T1, T2>(v2, arg6, arg8, arg11, arg12);
        complete_two_hop_swap<T2>(arg0, arg1, v1, v3, arg9, arg10, arg5, arg12);
    }

    public fun swap_exact_input_two_hop_a2b_b2a<T0, T1, T2>(arg0: &0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::Config, arg1: &mut 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::FeeVault, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: bool, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u64, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == arg4, 3);
        let (v0, v1) = 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::prepare_swap_input<T0>(arg0, arg1, arg2, arg3, arg5, arg12);
        let v2 = swap_a2b<T0, T1>(v0, arg6, arg7, arg11, arg12);
        let v3 = swap_b2a<T2, T1>(v2, arg6, arg8, arg11, arg12);
        complete_two_hop_swap<T2>(arg0, arg1, v1, v3, arg9, arg10, arg5, arg12);
    }

    public fun swap_exact_input_two_hop_b2a_a2b<T0, T1, T2>(arg0: &0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::Config, arg1: &mut 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::FeeVault, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: bool, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg9: u64, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == arg4, 3);
        let (v0, v1) = 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::prepare_swap_input<T0>(arg0, arg1, arg2, arg3, arg5, arg12);
        let v2 = swap_b2a<T1, T0>(v0, arg6, arg7, arg11, arg12);
        let v3 = swap_a2b<T1, T2>(v2, arg6, arg8, arg11, arg12);
        complete_two_hop_swap<T2>(arg0, arg1, v1, v3, arg9, arg10, arg5, arg12);
    }

    public fun swap_exact_input_two_hop_b2a_b2a<T0, T1, T2>(arg0: &0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::Config, arg1: &mut 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::FeeVault, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: bool, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u64, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == arg4, 3);
        let (v0, v1) = 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator::prepare_swap_input<T0>(arg0, arg1, arg2, arg3, arg5, arg12);
        let v2 = swap_b2a<T1, T0>(v0, arg6, arg7, arg11, arg12);
        let v3 = swap_b2a<T2, T1>(v2, arg6, arg8, arg11, arg12);
        complete_two_hop_swap<T2>(arg0, arg1, v1, v3, arg9, arg10, arg5, arg12);
    }

    // decompiled from Move bytecode v7
}

