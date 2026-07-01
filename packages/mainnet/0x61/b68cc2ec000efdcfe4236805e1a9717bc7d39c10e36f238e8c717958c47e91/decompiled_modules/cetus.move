module 0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::cetus {
    struct DlmmQuote has copy, drop, store {
        probe_in: u64,
        mid_out: u64,
        end_out: u64,
    }

    public fun a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg1, true, true, 0x2::coin::value<T0>(&arg0), 0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::min_sqrt_price(), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), v2);
        0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg4), arg4);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun a2b_dlmm<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, true, true, 0x2::coin::value<T0>(&arg0), arg2, arg3, arg4, arg5);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), v2, arg3);
        0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg5), arg5);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg1, false, true, 0x2::coin::value<T1>(&arg0), 0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::max_sqrt_price(), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v2);
        0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg4), arg4);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun b2a_dlmm<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, false, true, 0x2::coin::value<T1>(&arg0), arg2, arg3, arg4, arg5);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v2, arg3);
        0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg5), arg5);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    public fun probe_dlmm<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (DlmmQuote, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg0);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, false, true, v0, arg2, arg3, arg4, arg5);
        let v4 = v1;
        let v5 = 0x2::balance::value<T0>(&v4);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v3, arg3);
        0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v2, arg5), arg5);
        let (v6, v7, v8) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, true, true, v5, arg2, arg3, arg4, arg5);
        let v9 = v7;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::from_balance<T0>(v4, arg5)), 0x2::balance::zero<T1>(), v8, arg3);
        0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v6, arg5), arg5);
        let v10 = DlmmQuote{
            probe_in : v0,
            mid_out  : v5,
            end_out  : 0x2::balance::value<T1>(&v9),
        };
        (v10, 0x2::coin::from_balance<T1>(v9, arg5))
    }

    // decompiled from Move bytecode v7
}

