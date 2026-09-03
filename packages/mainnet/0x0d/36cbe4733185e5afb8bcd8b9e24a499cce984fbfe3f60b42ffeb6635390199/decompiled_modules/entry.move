module 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::entry {
    struct Fired has copy, drop {
        pair_cetus: address,
        pair_bluefin: address,
        buy_on_cetus: bool,
        spread_bps: u64,
        size_b: u64,
        profit_b: u64,
    }

    struct FiredFlash has copy, drop {
        pair_cetus: address,
        pair_bluefin: address,
        buy_on_cetus: bool,
        spread_bps: u64,
        size_b: u64,
        profit_b: u64,
    }

    struct FiredTri has copy, drop {
        pool_1: address,
        pool_2: address,
        pool_3: address,
        forward: bool,
        size_s: u64,
        profit_b: u64,
    }

    fun a_to_b_units(arg0: u64, arg1: u128) : u64 {
        ((((arg0 as u256) * (arg1 as u256) >> 64) * (arg1 as u256) >> 64) as u64)
    }

    fun af_swap_exact<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0x2::coin::into_balance<T2>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in_direct<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T1>(arg6, arg7), 0, arg7))
    }

    fun b_to_a_units(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg1 as u256) * (arg1 as u256);
        if (v0 == 0) {
            return 18446744073709551615
        };
        (((((arg0 as u256) << 128) + v0 - 1) / v0) as u64)
    }

    fun bluefin_buy_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, 0x2::balance::zero<T0>(), arg2, false, true, 0x2::balance::value<T1>(&arg2), 0, 79226673515401279992447579054);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun bluefin_buy_second<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, arg2, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg2), 0, 4295048017);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun bluefin_sell_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, arg2, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg2), 0, 4295048017);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun bluefin_sell_a_into<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        0x2::balance::join<T1>(arg3, bluefin_sell_a<T0, T1>(arg0, arg1, arg2, arg4));
    }

    fun bluefin_sell_second<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, 0x2::balance::zero<T0>(), arg2, false, true, 0x2::balance::value<T1>(&arg2), 0, 79226673515401279992447579054);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun bolt_buy_base<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg2;
        if (0x2::balance::value<T1>(&arg2) == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return (0x2::balance::zero<T0>(), split_over_cap<T1>(v0, bolt_buy_cap<T0, T1>(arg0, arg1, arg3)))
        };
        let (v1, v2) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg3, arg2, 0x1::option::none<u64>(), arg4);
        0x2::balance::destroy_zero<T1>(v2);
        (v1, split_over_cap<T1>(v0, bolt_buy_cap<T0, T1>(arg0, arg1, arg3)))
    }

    fun bolt_buy_cap<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_base_liquidity_inner<T0>(arg0);
        let (v2, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg1, arg2);
        bolt_cap_units(v0, v2)
    }

    fun bolt_cap_units(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg0 as u256) * 9950 * (arg1 as u256) / 10000 * (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision() as u256);
        if (v0 > (18446744073709551615 as u256)) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun bolt_sell_base<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = &mut arg2;
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return (0x2::balance::zero<T1>(), split_over_cap<T0>(v0, bolt_sell_cap<T0, T1>(arg0, arg1, arg3)))
        };
        let (v1, v2) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg3, arg2, 0x1::option::none<u64>(), arg4);
        0x2::balance::destroy_zero<T0>(v1);
        (v2, split_over_cap<T0>(v0, bolt_sell_cap<T0, T1>(arg0, arg1, arg3)))
    }

    fun bolt_sell_cap<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg1, arg2);
        bolt_cap_units(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0), v0)
    }

    fun cetus_buy_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579054, arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v3);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun cetus_buy_a_into<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return
        };
        0x2::balance::join<T0>(arg3, cetus_buy_a<T0, T1>(arg0, arg1, arg2, arg4));
    }

    fun cetus_price_in_db_frame_flip(arg0: u128) : u128 {
        let v0 = (arg0 as u256) * (arg0 as u256);
        if (v0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456000000000 / v0) as u128)
    }

    fun cetus_sell_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048017, arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun cetus_sell_a_into<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        0x2::balance::join<T1>(arg3, cetus_sell_a<T0, T1>(arg0, arg1, arg2, arg4));
    }

    fun dae28_sell_x<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_x_to_y_with_return<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T0>(arg2, arg3), 0, arg3))
    }

    fun dae28_sell_y<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_y_to_x_with_return<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T1>(arg2, arg3), 0, arg3))
    }

    fun db_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        payout<T1>(0x2::coin::into_balance<T1>(v1), arg3);
        payout<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2), arg3);
        0x2::coin::into_balance<T0>(v0)
    }

    fun db_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        payout<T0>(0x2::coin::into_balance<T0>(v0), arg3);
        payout<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2), arg3);
        0x2::coin::into_balance<T1>(v1)
    }

    fun db_sell_base_into<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        0x2::balance::join<T1>(arg2, db_sell_base<T0, T1>(arg0, arg1, arg3, arg4));
    }

    fun dlmm_buy_a<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, 0x2::balance::value<T1>(&arg3), arg1, arg2, arg4, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), arg3, v2, arg2);
        v0
    }

    fun dlmm_sell_a<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, true, 0x2::balance::value<T0>(&arg3), arg1, arg2, arg4, arg5);
        0x2::balance::destroy_zero<T0>(v0);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, arg3, 0x2::balance::zero<T1>(), v2, arg2);
        v1
    }

    fun fullsail_buy_a<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, 0x2::balance::value<T1>(&arg5), 79226673515401279992447579054, arg3, arg4, arg6);
        let v3 = v2;
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v3);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), arg5, v3);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun fullsail_sell_a<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, 0x2::balance::value<T0>(&arg5), 4295048017, arg3, arg4, arg6);
        let v3 = v2;
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v3);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, arg5, 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun join_leftover<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2::balance::join<T0>(arg0, arg1);
        };
    }

    fun mmt_buy_x<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579054, arg3, arg1, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, 0x2::balance::zero<T0>(), arg2, arg1, arg4);
        v0
    }

    fun mmt_sell_x<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::balance::value<T0>(&arg2), 4295048017, arg3, arg1, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, arg2, 0x2::balance::zero<T1>(), arg1, arg4);
        v1
    }

    fun payout<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    fun pqf1_push<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        if (0x1::vector::length<u8>(&arg4) > 0) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        };
    }

    fun pqf2_buy_base_chunked<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::zero<T0>();
        while (0x2::balance::value<T1>(&arg4) > 0) {
            let v1 = 0x2::balance::value<T1>(&arg4);
            let v2 = if (arg5 == 0 || arg5 >= v1) {
                v1
            } else {
                arg5
            };
            let (v3, v4) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", v2), 0x2::balance::split<T1>(&mut arg4, v2), arg6, arg7);
            let v5 = v4;
            0x2::balance::join<T0>(&mut v0, v3);
            0x2::balance::join<T1>(&mut arg4, v5);
            if (0x2::balance::value<T1>(&v5) == v2) {
                break
            };
        };
        (v0, arg4)
    }

    fun pqf2_push<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        if (0x1::vector::length<u8>(&arg4) > 0) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::update_quote_envelope_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        };
    }

    fun pqf2_sell_base_chunked<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::zero<T1>();
        while (0x2::balance::value<T0>(&arg4) > 0) {
            let v1 = 0x2::balance::value<T0>(&arg4);
            let v2 = if (arg5 == 0 || arg5 >= v1) {
                v1
            } else {
                arg5
            };
            let (v3, v4) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", v2), 0x2::balance::split<T0>(&mut arg4, v2), arg6, arg7);
            let v5 = v4;
            0x2::balance::join<T1>(&mut v0, v3);
            0x2::balance::join<T0>(&mut arg4, v5);
            if (0x2::balance::value<T0>(&v5) == v2) {
                break
            };
        };
        (v0, arg4)
    }

    fun pqf2_side_fresh<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg1: bool, arg2: &0x2::clock::Clock) : bool {
        if (arg1) {
            if (!0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_has_bid<T0, T1>(arg0)) {
                return false
            };
            0x2::clock::timestamp_ms(arg2) < 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::quote_sig_expiry_ms(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteEntryV2>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_bid<T0, T1>(arg0)))
        } else {
            if (!0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_has_ask<T0, T1>(arg0)) {
                return false
            };
            0x2::clock::timestamp_ms(arg2) < 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::quote_sig_expiry_ms(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteEntryV2>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_ask<T0, T1>(arg0)))
        }
    }

    fun pqf_buy_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", 0x2::balance::value<T1>(&arg4)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, x"0000000000000000000000000000000000000000000000000000000000000000", arg5, arg6);
        0x2::balance::destroy_zero<T1>(v2);
        v1
    }

    fun pqf_sell_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", 0x2::balance::value<T0>(&arg4)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, x"0000000000000000000000000000000000000000000000000000000000000000", arg5, arg6);
        0x2::balance::destroy_zero<T0>(v2);
        v1
    }

    fun pqf_side_fresh<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: bool, arg2: &0x2::clock::Clock) : bool {
        if (arg1) {
            if (!0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_has_bid<T0, T1>(arg0)) {
                return false
            };
            0x2::clock::timestamp_ms(arg2) < 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_sig_expiry_ms(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_bid<T0, T1>(arg0)))
        } else {
            if (!0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_has_ask<T0, T1>(arg0)) {
                return false
            };
            0x2::clock::timestamp_ms(arg2) < 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_sig_expiry_ms(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_ask<T0, T1>(arg0)))
        }
    }

    fun price_spread_bps(arg0: u128, arg1: u128) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = arg0 / 2 + arg1 / 2;
        if (v1 == 0) {
            return 0
        };
        ((v0 * 10000 / v1) as u64)
    }

    public fun run_bluefin_deepbook_flash<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg2, arg6) as u128);
        let v3 = price_spread_bps(v1, v2);
        let v4 = if (v3 < arg4) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v4) {
            return 0
        };
        let v5 = v1 < v2;
        let (v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg2, arg3, arg7);
        let v8 = if (v5) {
            let v9 = bluefin_buy_a<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(v6), arg6);
            db_sell_base<T0, T1>(arg2, v9, arg6, arg7)
        } else {
            let v10 = db_buy_base<T0, T1>(arg2, 0x2::coin::into_balance<T1>(v6), arg6, arg7);
            bluefin_sell_a<T0, T1>(arg0, arg1, v10, arg6)
        };
        let v11 = v8;
        assert!(0x2::balance::value<T1>(&v11) >= arg3 + arg5, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v11, arg3), arg7), v7);
        let v12 = 0x2::balance::value<T1>(&v11);
        payout<T1>(v11, arg7);
        let v13 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : v5,
            spread_bps   : v3,
            size_b       : arg3,
            profit_b     : v12,
        };
        0x2::event::emit<FiredFlash>(v13);
        v12
    }

    public fun run_bluefin_momentum_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg6, arg9);
        let v2 = if (arg5) {
            let v3 = bluefin_buy_a<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v0), arg8);
            mmt_sell_x<T0, T1>(arg3, arg4, v3, arg8, arg9)
        } else {
            let v4 = mmt_buy_x<T0, T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v0), arg8, arg9);
            bluefin_sell_a<T0, T1>(arg1, arg2, v4, arg8)
        };
        let v5 = v2;
        assert!(0x2::balance::value<T1>(&v5) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, arg6), arg9), v1);
        let v6 = 0x2::balance::value<T1>(&v5);
        payout<T1>(v5, arg9);
        let v7 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            pair_bluefin : 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v6,
        };
        0x2::event::emit<FiredFlash>(v7);
        v6
    }

    public fun run_bluefin_pqf_v2_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg6: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg11 == 0) {
            return 0
        };
        pqf2_push<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg8, arg13, arg14);
        if (!pqf2_side_fresh<T0, T1>(arg6, arg10, arg13)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg11, arg14);
        let v2 = if (arg10) {
            let v3 = bluefin_buy_a<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v0), arg13);
            let (v4, v5) = pqf2_sell_base_chunked<T0, T1>(arg3, arg4, arg5, arg6, v3, arg9, arg13, arg14);
            let v6 = v4;
            let v7 = &mut v6;
            db_sell_base_into<T0, T1>(arg0, v5, v7, arg13, arg14);
            v6
        } else {
            let (v8, v9) = pqf2_buy_base_chunked<T0, T1>(arg3, arg4, arg5, arg6, 0x2::coin::into_balance<T1>(v0), arg9, arg13, arg14);
            let v10 = v8;
            let v11 = if (0x2::balance::value<T0>(&v10) > 0) {
                bluefin_sell_a<T0, T1>(arg1, arg2, v10, arg13)
            } else {
                0x2::balance::destroy_zero<T0>(v10);
                0x2::balance::zero<T1>()
            };
            let v12 = v11;
            let v13 = &mut v12;
            join_leftover<T1>(v13, v9);
            v12
        };
        let v14 = v2;
        assert!(0x2::balance::value<T1>(&v14) >= arg11 + arg12, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v14, arg11), arg14), v1);
        let v15 = 0x2::balance::value<T1>(&v14);
        payout<T1>(v14, arg14);
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>>(arg6),
            buy_on_cetus : arg10,
            spread_bps   : 0,
            size_b       : arg11,
            profit_b     : v15,
        };
        0x2::event::emit<FiredFlash>(v16);
        v15
    }

    public fun run_bolt_bluefin_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg6, arg9);
        let v2 = if (arg5) {
            let (v3, v4) = bolt_buy_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v0), arg8, arg9);
            let v5 = 0x2::balance::zero<T1>();
            let v6 = &mut v5;
            bluefin_sell_a_into<T0, T1>(arg3, arg4, v3, v6, arg8);
            let v7 = &mut v5;
            join_leftover<T1>(v7, v4);
            v5
        } else {
            let v8 = bluefin_buy_a<T0, T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v0), arg8);
            let (v9, v10) = bolt_sell_base<T0, T1>(arg1, arg2, v8, arg8, arg9);
            let v11 = v9;
            let v12 = &mut v11;
            bluefin_sell_a_into<T0, T1>(arg3, arg4, v10, v12, arg8);
            v11
        };
        let v13 = v2;
        assert!(0x2::balance::value<T1>(&v13) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13, arg6), arg9), v1);
        let v14 = 0x2::balance::value<T1>(&v13);
        payout<T1>(v13, arg9);
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v14,
        };
        0x2::event::emit<FiredFlash>(v15);
        v14
    }

    public fun run_bolt_bluefin_flash_flip<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg6, arg9);
        let v2 = if (arg5) {
            let (v3, v4) = bolt_sell_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T1>(v0), arg8, arg9);
            let v5 = 0x2::balance::zero<T1>();
            let v6 = &mut v5;
            bluefin_sell_a_into<T0, T1>(arg3, arg4, v3, v6, arg8);
            let v7 = &mut v5;
            join_leftover<T1>(v7, v4);
            v5
        } else {
            let v8 = bluefin_buy_a<T0, T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v0), arg8);
            let (v9, v10) = bolt_buy_base<T1, T0>(arg1, arg2, v8, arg8, arg9);
            let v11 = v9;
            let v12 = &mut v11;
            bluefin_sell_a_into<T0, T1>(arg3, arg4, v10, v12, arg8);
            v11
        };
        let v13 = v2;
        assert!(0x2::balance::value<T1>(&v13) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13, arg6), arg9), v1);
        let v14 = 0x2::balance::value<T1>(&v13);
        payout<T1>(v13, arg9);
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v14,
        };
        0x2::event::emit<FiredFlash>(v15);
        v14
    }

    public fun run_bolt_dae28_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg4: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg6, arg9);
        let v2 = if (arg5) {
            let (v3, v4) = bolt_buy_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v0), arg8, arg9);
            let v5 = dae28_sell_x<T0, T1>(arg3, arg4, v3, arg9);
            let v6 = &mut v5;
            join_leftover<T1>(v6, v4);
            v5
        } else {
            let v7 = dae28_sell_y<T0, T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v0), arg9);
            let (v8, v9) = bolt_sell_base<T0, T1>(arg1, arg2, v7, arg8, arg9);
            let v10 = v9;
            let v11 = v8;
            if (0x2::balance::value<T0>(&v10) > 0) {
                let v12 = dae28_sell_x<T0, T1>(arg3, arg4, v10, arg9);
                0x2::balance::join<T1>(&mut v11, v12);
            } else {
                0x2::balance::destroy_zero<T0>(v10);
            };
            v11
        };
        let v13 = v2;
        assert!(0x2::balance::value<T1>(&v13) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13, arg6), arg9), v1);
        let v14 = 0x2::balance::value<T1>(&v13);
        payout<T1>(v13, arg9);
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pair_bluefin : 0x2::object::id_address<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg4),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v14,
        };
        0x2::event::emit<FiredFlash>(v15);
        v14
    }

    public fun run_bolt_deepbook_flash<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg2, arg4, arg7);
        let v2 = if (arg3) {
            let (v3, v4) = bolt_buy_base<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(v0), arg6, arg7);
            let v5 = 0x2::balance::zero<T1>();
            let v6 = &mut v5;
            db_sell_base_into<T0, T1>(arg2, v3, v6, arg6, arg7);
            let v7 = &mut v5;
            join_leftover<T1>(v7, v4);
            v5
        } else {
            let v8 = db_buy_base<T0, T1>(arg2, 0x2::coin::into_balance<T1>(v0), arg6, arg7);
            let (v9, v10) = bolt_sell_base<T0, T1>(arg0, arg1, v8, arg6, arg7);
            let v11 = v9;
            let v12 = &mut v11;
            db_sell_base_into<T0, T1>(arg2, v10, v12, arg6, arg7);
            v11
        };
        let v13 = v2;
        assert!(0x2::balance::value<T1>(&v13) >= arg4 + arg5, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13, arg4), arg7), v1);
        let v14 = 0x2::balance::value<T1>(&v13);
        payout<T1>(v13, arg7);
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : arg3,
            spread_bps   : 0,
            size_b       : arg4,
            profit_b     : v14,
        };
        0x2::event::emit<FiredFlash>(v15);
        v14
    }

    public fun run_bolt_deepbook_flash_flip<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg2, arg4, arg7);
        let v2 = if (arg3) {
            let (v3, v4) = bolt_sell_base<T1, T0>(arg0, arg1, 0x2::coin::into_balance<T1>(v0), arg6, arg7);
            let v5 = 0x2::balance::zero<T1>();
            let v6 = &mut v5;
            db_sell_base_into<T0, T1>(arg2, v3, v6, arg6, arg7);
            let v7 = &mut v5;
            join_leftover<T1>(v7, v4);
            v5
        } else {
            let v8 = db_buy_base<T0, T1>(arg2, 0x2::coin::into_balance<T1>(v0), arg6, arg7);
            let (v9, v10) = bolt_buy_base<T1, T0>(arg0, arg1, v8, arg6, arg7);
            let v11 = v9;
            let v12 = &mut v11;
            db_sell_base_into<T0, T1>(arg2, v10, v12, arg6, arg7);
            v11
        };
        let v13 = v2;
        assert!(0x2::balance::value<T1>(&v13) >= arg4 + arg5, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13, arg4), arg7), v1);
        let v14 = 0x2::balance::value<T1>(&v13);
        payout<T1>(v13, arg7);
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : arg3,
            spread_bps   : 0,
            size_b       : arg4,
            profit_b     : v14,
        };
        0x2::event::emit<FiredFlash>(v15);
        v14
    }

    public fun run_bolt_momentum_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg6, arg9);
        let v2 = if (arg5) {
            let (v3, v4) = bolt_buy_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v0), arg8, arg9);
            let v5 = mmt_sell_x<T0, T1>(arg3, arg4, v3, arg8, arg9);
            let v6 = &mut v5;
            join_leftover<T1>(v6, v4);
            v5
        } else {
            let v7 = mmt_buy_x<T0, T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v0), arg8, arg9);
            let (v8, v9) = bolt_sell_base<T0, T1>(arg1, arg2, v7, arg8, arg9);
            let v10 = v9;
            let v11 = v8;
            if (0x2::balance::value<T0>(&v10) > 0) {
                let v12 = mmt_sell_x<T0, T1>(arg3, arg4, v10, arg8, arg9);
                0x2::balance::join<T1>(&mut v11, v12);
            } else {
                0x2::balance::destroy_zero<T0>(v10);
            };
            v11
        };
        let v13 = v2;
        assert!(0x2::balance::value<T1>(&v13) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13, arg6), arg9), v1);
        let v14 = 0x2::balance::value<T1>(&v13);
        payout<T1>(v13, arg9);
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v14,
        };
        0x2::event::emit<FiredFlash>(v15);
        v14
    }

    public fun run_bolt_pqf_v2_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg6: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg11 == 0) {
            return 0
        };
        pqf2_push<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg8, arg13, arg14);
        if (!pqf2_side_fresh<T0, T1>(arg6, arg10, arg13)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg11, arg14);
        let v2 = if (arg10) {
            let (v3, v4) = bolt_buy_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v0), arg13, arg14);
            let (v5, v6) = pqf2_sell_base_chunked<T0, T1>(arg3, arg4, arg5, arg6, v3, arg9, arg13, arg14);
            let v7 = v5;
            let v8 = &mut v7;
            db_sell_base_into<T0, T1>(arg0, v6, v8, arg13, arg14);
            let v9 = &mut v7;
            join_leftover<T1>(v9, v4);
            v7
        } else {
            let (v10, v11) = pqf2_buy_base_chunked<T0, T1>(arg3, arg4, arg5, arg6, 0x2::coin::into_balance<T1>(v0), arg9, arg13, arg14);
            let (v12, v13) = bolt_sell_base<T0, T1>(arg1, arg2, v10, arg13, arg14);
            let v14 = v12;
            let v15 = &mut v14;
            db_sell_base_into<T0, T1>(arg0, v13, v15, arg13, arg14);
            let v16 = &mut v14;
            join_leftover<T1>(v16, v11);
            v14
        };
        let v17 = v2;
        assert!(0x2::balance::value<T1>(&v17) >= arg11 + arg12, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v17, arg11), arg14), v1);
        let v18 = 0x2::balance::value<T1>(&v17);
        payout<T1>(v17, arg14);
        let v19 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>>(arg6),
            buy_on_cetus : arg10,
            spread_bps   : 0,
            size_b       : arg11,
            profit_b     : v18,
        };
        0x2::event::emit<FiredFlash>(v19);
        v18
    }

    public fun run_bolt_pqf_v2_flash_flip<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg6: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg11 == 0) {
            return 0
        };
        pqf2_push<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg8, arg13, arg14);
        if (!pqf2_side_fresh<T0, T1>(arg6, arg10, arg13)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg11, arg14);
        let v2 = if (arg10) {
            let (v3, v4) = bolt_sell_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T1>(v0), arg13, arg14);
            let (v5, v6) = pqf2_sell_base_chunked<T0, T1>(arg3, arg4, arg5, arg6, v3, arg9, arg13, arg14);
            let v7 = v5;
            let v8 = &mut v7;
            db_sell_base_into<T0, T1>(arg0, v6, v8, arg13, arg14);
            let v9 = &mut v7;
            join_leftover<T1>(v9, v4);
            v7
        } else {
            let (v10, v11) = pqf2_buy_base_chunked<T0, T1>(arg3, arg4, arg5, arg6, 0x2::coin::into_balance<T1>(v0), arg9, arg13, arg14);
            let (v12, v13) = bolt_buy_base<T1, T0>(arg1, arg2, v10, arg13, arg14);
            let v14 = v12;
            let v15 = &mut v14;
            db_sell_base_into<T0, T1>(arg0, v13, v15, arg13, arg14);
            let v16 = &mut v14;
            join_leftover<T1>(v16, v11);
            v14
        };
        let v17 = v2;
        assert!(0x2::balance::value<T1>(&v17) >= arg11 + arg12, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v17, arg11), arg14), v1);
        let v18 = 0x2::balance::value<T1>(&v17);
        payout<T1>(v17, arg14);
        let v19 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>>(arg6),
            buy_on_cetus : arg10,
            spread_bps   : 0,
            size_b       : arg11,
            profit_b     : v18,
        };
        0x2::event::emit<FiredFlash>(v19);
        v18
    }

    public fun run_cetus_bluefin<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::Vault<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let v2 = spread_bps(v0, v1);
        let v3 = if (v2 < arg6) {
            true
        } else if (0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::value<T1>(arg4) < arg5) {
            true
        } else {
            arg5 == 0
        };
        if (v3) {
            return 0
        };
        let v4 = 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::borrow_mut<T1>(arg4);
        let v5 = v0 < v1;
        let v6 = if (v5) {
            let v7 = cetus_buy_a<T0, T1>(arg0, arg1, 0x2::balance::split<T1>(v4, arg5), arg8);
            bluefin_sell_a<T0, T1>(arg2, arg3, v7, arg8)
        } else {
            let v8 = bluefin_buy_a<T0, T1>(arg2, arg3, 0x2::balance::split<T1>(v4, arg5), arg8);
            cetus_sell_a<T0, T1>(arg0, arg1, v8, arg8)
        };
        let v9 = v6;
        let v10 = 0x2::balance::value<T1>(&v9);
        assert!(v10 >= arg5 + arg7, 910);
        0x2::balance::join<T1>(v4, v9);
        let v11 = Fired{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : v5,
            spread_bps   : v2,
            size_b       : arg5,
            profit_b     : v10 - arg5,
        };
        0x2::event::emit<Fired>(v11);
        v10 - arg5
    }

    public fun run_cetus_bluefin_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let v2 = spread_bps(v0, v1);
        if (v2 < arg5 || arg4 == 0) {
            return 0
        };
        let v3 = v0 < v1;
        let v4 = if (v3) {
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v6);
            let v8 = bluefin_sell_a<T0, T1>(arg2, arg3, v5, arg7);
            assert!(0x2::balance::value<T1>(&v8) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v8, arg4), v7);
            payout<T1>(v8, arg8);
            0x2::balance::value<T1>(&v8)
        } else {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg4, 4295048017, arg7);
            let v12 = v11;
            0x2::balance::destroy_zero<T0>(v9);
            let v13 = bluefin_buy_a<T0, T1>(arg2, arg3, v10, arg7);
            let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
            assert!(0x2::balance::value<T0>(&v13) >= v14 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v13, v14), 0x2::balance::zero<T1>(), v12);
            payout<T0>(v13, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v13), v0)
        };
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : v3,
            spread_bps   : v2,
            size_b       : arg4,
            profit_b     : v4,
        };
        0x2::event::emit<FiredFlash>(v15);
        v4
    }

    public fun run_cetus_bluefin_flash_flip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg3);
        let v2 = if (v1 == 0) {
            0
        } else {
            ((340282366920938463463374607431768211456 / (v1 as u256)) as u128)
        };
        let v3 = spread_bps(v0, v2);
        if (v3 < arg5 || arg4 == 0) {
            return 0
        };
        let v4 = v0 < v2;
        let v5 = if (v4) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v7);
            let v9 = bluefin_sell_second<T1, T0>(arg2, arg3, v6, arg7);
            assert!(0x2::balance::value<T1>(&v9) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v9, arg4), v8);
            payout<T1>(v9, arg8);
            0x2::balance::value<T1>(&v9)
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg4, 4295048017, arg7);
            let v13 = v12;
            0x2::balance::destroy_zero<T0>(v10);
            let v14 = bluefin_buy_second<T1, T0>(arg2, arg3, v11, arg7);
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
            assert!(0x2::balance::value<T0>(&v14) >= v15 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v14, v15), 0x2::balance::zero<T1>(), v13);
            payout<T0>(v14, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v14), v0)
        };
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg3),
            buy_on_cetus : v4,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v5,
        };
        0x2::event::emit<FiredFlash>(v16);
        v5
    }

    public fun run_cetus_bluefin_flip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &mut 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::Vault<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg3);
        let v2 = if (v1 == 0) {
            0
        } else {
            ((340282366920938463463374607431768211456 / (v1 as u256)) as u128)
        };
        let v3 = spread_bps(v0, v2);
        let v4 = if (v3 < arg6) {
            true
        } else if (0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::value<T1>(arg4) < arg5) {
            true
        } else {
            arg5 == 0
        };
        if (v4) {
            return 0
        };
        let v5 = 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::borrow_mut<T1>(arg4);
        let v6 = v0 < v2;
        let v7 = if (v6) {
            let v8 = cetus_buy_a<T0, T1>(arg0, arg1, 0x2::balance::split<T1>(v5, arg5), arg8);
            bluefin_sell_second<T1, T0>(arg2, arg3, v8, arg8)
        } else {
            let v9 = bluefin_buy_second<T1, T0>(arg2, arg3, 0x2::balance::split<T1>(v5, arg5), arg8);
            cetus_sell_a<T0, T1>(arg0, arg1, v9, arg8)
        };
        let v10 = v7;
        let v11 = 0x2::balance::value<T1>(&v10);
        assert!(v11 >= arg5 + arg7, 910);
        0x2::balance::join<T1>(v5, v10);
        let v12 = Fired{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg3),
            buy_on_cetus : v6,
            spread_bps   : v3,
            size_b       : arg5,
            profit_b     : v11 - arg5,
        };
        0x2::event::emit<Fired>(v12);
        v11 - arg5
    }

    public fun run_cetus_bolt_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, v2) = if (arg4) {
            let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg5, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v4);
            let (v6, v7) = bolt_sell_base<T0, T1>(arg2, arg3, v3, arg7, arg8);
            let v8 = v6;
            let v9 = &mut v8;
            cetus_sell_a_into<T0, T1>(arg0, arg1, v7, v9, arg7);
            assert!(0x2::balance::value<T1>(&v8) >= arg5 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v8, arg5), v5);
            payout<T1>(v8, arg8);
            (0x2::balance::value<T1>(&v8), arg5)
        } else {
            let v10 = bolt_buy_cap<T0, T1>(arg2, arg3, arg7);
            let v11 = if (arg5 > v10) {
                v10
            } else {
                arg5
            };
            assert!(v11 > 0, 910);
            let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v11, 4295048017, arg7);
            let v15 = v14;
            0x2::balance::destroy_zero<T0>(v12);
            let (v16, v17) = bolt_buy_base<T0, T1>(arg2, arg3, v13, arg7, arg8);
            let v18 = v16;
            let v19 = &mut v18;
            cetus_buy_a_into<T0, T1>(arg0, arg1, v17, v19, arg7);
            let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v15);
            assert!(0x2::balance::value<T0>(&v18) >= v20 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v18, v20), 0x2::balance::zero<T1>(), v15);
            payout<T0>(v18, arg8);
            (a_to_b_units(0x2::balance::value<T0>(&v18), v0), v11)
        };
        let v21 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg2),
            buy_on_cetus : arg4,
            spread_bps   : 0,
            size_b       : v2,
            profit_b     : v1,
        };
        0x2::event::emit<FiredFlash>(v21);
        v1
    }

    public fun run_cetus_bolt_flash_flip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, v2) = if (arg4) {
            let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg5, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v4);
            let (v6, v7) = bolt_buy_base<T1, T0>(arg2, arg3, v3, arg7, arg8);
            let v8 = v6;
            let v9 = &mut v8;
            cetus_sell_a_into<T0, T1>(arg0, arg1, v7, v9, arg7);
            assert!(0x2::balance::value<T1>(&v8) >= arg5 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v8, arg5), v5);
            payout<T1>(v8, arg8);
            (0x2::balance::value<T1>(&v8), arg5)
        } else {
            let v10 = bolt_sell_cap<T1, T0>(arg2, arg3, arg7);
            let v11 = if (arg5 > v10) {
                v10
            } else {
                arg5
            };
            assert!(v11 > 0, 910);
            let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v11, 4295048017, arg7);
            let v15 = v14;
            0x2::balance::destroy_zero<T0>(v12);
            let (v16, v17) = bolt_sell_base<T1, T0>(arg2, arg3, v13, arg7, arg8);
            let v18 = v16;
            let v19 = &mut v18;
            cetus_buy_a_into<T0, T1>(arg0, arg1, v17, v19, arg7);
            let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v15);
            assert!(0x2::balance::value<T0>(&v18) >= v20 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v18, v20), 0x2::balance::zero<T1>(), v15);
            payout<T0>(v18, arg8);
            (a_to_b_units(0x2::balance::value<T0>(&v18), v0), v11)
        };
        let v21 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg2),
            buy_on_cetus : arg4,
            spread_bps   : 0,
            size_b       : v2,
            profit_b     : v1,
        };
        0x2::event::emit<FiredFlash>(v21);
        v1
    }

    public fun run_cetus_cetus_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let v2 = spread_bps(v0, v1);
        if (v2 < arg4 || arg3 == 0) {
            return 0
        };
        let v3 = v0 < v1;
        let v4 = if (v3) {
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, 79226673515401279992447579054, arg6);
            0x2::balance::destroy_zero<T1>(v6);
            let v8 = cetus_sell_a<T0, T1>(arg0, arg2, v5, arg6);
            assert!(0x2::balance::value<T1>(&v8) >= arg3 + arg5, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v8, arg3), v7);
            payout<T1>(v8, arg7);
            0x2::balance::value<T1>(&v8)
        } else {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg3, 4295048017, arg6);
            let v12 = v11;
            0x2::balance::destroy_zero<T0>(v9);
            let v13 = cetus_buy_a<T0, T1>(arg0, arg2, v10, arg6);
            let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
            assert!(0x2::balance::value<T0>(&v13) >= v14 + b_to_a_units(arg5, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v13, v14), 0x2::balance::zero<T1>(), v12);
            payout<T0>(v13, arg7);
            a_to_b_units(0x2::balance::value<T0>(&v13), v0)
        };
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : v3,
            spread_bps   : v2,
            size_b       : arg3,
            profit_b     : v4,
        };
        0x2::event::emit<FiredFlash>(v15);
        v4
    }

    public fun run_cetus_dae28_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg3: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T1, T0>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = if (arg4) {
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg5, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v3);
            let v5 = dae28_sell_y<T1, T0>(arg2, arg3, v2, arg8);
            assert!(0x2::balance::value<T1>(&v5) >= arg5 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, arg5), v4);
            payout<T1>(v5, arg8);
            0x2::balance::value<T1>(&v5)
        } else {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg5, 4295048017, arg7);
            let v9 = v8;
            0x2::balance::destroy_zero<T0>(v6);
            let v10 = dae28_sell_x<T1, T0>(arg2, arg3, v7, arg8);
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
            assert!(0x2::balance::value<T0>(&v10) >= v11 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v10, v11), 0x2::balance::zero<T1>(), v9);
            payout<T0>(v10, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v10), v0)
        };
        let v12 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T1, T0>>(arg3),
            buy_on_cetus : arg4,
            spread_bps   : 0,
            size_b       : arg5,
            profit_b     : v1,
        };
        0x2::event::emit<FiredFlash>(v12);
        v1
    }

    public fun run_cetus_deepbook_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg2, arg6) as u128);
        let v3 = price_spread_bps(v1, v2);
        let v4 = if (v3 < arg4) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v4) {
            return 0
        };
        let v5 = v1 < v2;
        let v6 = if (v5) {
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, 79226673515401279992447579054, arg6);
            0x2::balance::destroy_zero<T1>(v8);
            let v10 = db_sell_base<T0, T1>(arg2, v7, arg6, arg7);
            assert!(0x2::balance::value<T1>(&v10) >= arg3 + arg5, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, arg3), v9);
            payout<T1>(v10, arg7);
            0x2::balance::value<T1>(&v10)
        } else {
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg3, 4295048017, arg6);
            let v14 = v13;
            0x2::balance::destroy_zero<T0>(v11);
            let v15 = db_buy_base<T0, T1>(arg2, v12, arg6, arg7);
            let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14);
            assert!(0x2::balance::value<T0>(&v15) >= v16 + b_to_a_units(arg5, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v15, v16), 0x2::balance::zero<T1>(), v14);
            payout<T0>(v15, arg7);
            a_to_b_units(0x2::balance::value<T0>(&v15), v0)
        };
        let v17 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : v5,
            spread_bps   : v3,
            size_b       : arg3,
            profit_b     : v6,
        };
        0x2::event::emit<FiredFlash>(v17);
        v6
    }

    public fun run_cetus_deepbook_flash_flip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = cetus_price_in_db_frame_flip(v0);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T1, T0>(arg2, arg6) as u128);
        let v3 = price_spread_bps(v1, v2);
        if (v3 < arg4 || v2 == 0) {
            return 0
        };
        let v4 = v1 < v2;
        let v5 = if (v4) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg3, 4295048017, arg6);
            let v9 = v8;
            0x2::balance::destroy_zero<T0>(v6);
            let v10 = db_sell_base<T1, T0>(arg2, v7, arg6, arg7);
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
            assert!(0x2::balance::value<T0>(&v10) >= v11 + b_to_a_units(arg5, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v10, v11), 0x2::balance::zero<T1>(), v9);
            payout<T0>(v10, arg7);
            a_to_b_units(0x2::balance::value<T0>(&v10), v0)
        } else {
            let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, 79226673515401279992447579054, arg6);
            0x2::balance::destroy_zero<T1>(v13);
            let v15 = db_buy_base<T1, T0>(arg2, v12, arg6, arg7);
            assert!(0x2::balance::value<T1>(&v15) >= arg3 + arg5, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v15, arg3), v14);
            payout<T1>(v15, arg7);
            0x2::balance::value<T1>(&v15)
        };
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg2),
            buy_on_cetus : v4,
            spread_bps   : v3,
            size_b       : arg3,
            profit_b     : v5,
        };
        0x2::event::emit<FiredFlash>(v16);
        v5
    }

    public fun run_cetus_momentum_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = if (arg4) {
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg5, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v3);
            let v5 = mmt_buy_x<T1, T0>(arg2, arg3, v2, arg7, arg8);
            assert!(0x2::balance::value<T1>(&v5) >= arg5 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, arg5), v4);
            payout<T1>(v5, arg8);
            0x2::balance::value<T1>(&v5)
        } else {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg5, 4295048017, arg7);
            let v9 = v8;
            0x2::balance::destroy_zero<T0>(v6);
            let v10 = mmt_sell_x<T1, T0>(arg2, arg3, v7, arg7, arg8);
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
            assert!(0x2::balance::value<T0>(&v10) >= v11 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v10, v11), 0x2::balance::zero<T1>(), v9);
            payout<T0>(v10, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v10), v0)
        };
        let v12 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg2),
            buy_on_cetus : arg4,
            spread_bps   : 0,
            size_b       : arg5,
            profit_b     : v1,
        };
        0x2::event::emit<FiredFlash>(v12);
        v1
    }

    public fun run_cetus_pqf_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T1, T0>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = if (arg6) {
            if (!pqf_side_fresh<T1, T0>(arg5, false, arg9)) {
                return 0
            };
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg7, 79226673515401279992447579054, arg9);
            0x2::balance::destroy_zero<T1>(v3);
            let v5 = pqf_buy_base<T1, T0>(arg2, arg3, arg4, arg5, v2, arg9, arg10);
            assert!(0x2::balance::value<T1>(&v5) >= arg7 + arg8, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, arg7), v4);
            payout<T1>(v5, arg10);
            0x2::balance::value<T1>(&v5)
        } else {
            if (!pqf_side_fresh<T1, T0>(arg5, true, arg9)) {
                return 0
            };
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg7, 4295048017, arg9);
            let v9 = v8;
            0x2::balance::destroy_zero<T0>(v6);
            let v10 = pqf_sell_base<T1, T0>(arg2, arg3, arg4, arg5, v7, arg9, arg10);
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
            assert!(0x2::balance::value<T0>(&v10) >= v11 + b_to_a_units(arg8, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v10, v11), 0x2::balance::zero<T1>(), v9);
            payout<T0>(v10, arg10);
            a_to_b_units(0x2::balance::value<T0>(&v10), v0)
        };
        let v12 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T1, T0>>(arg5),
            buy_on_cetus : arg6,
            spread_bps   : 0,
            size_b       : arg7,
            profit_b     : v1,
        };
        0x2::event::emit<FiredFlash>(v12);
        v1
    }

    public fun run_cetus_pqf_flash_env<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T1, T0>, arg6: bool, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        pqf1_push<T1, T0>(arg2, arg3, arg4, arg5, arg9, arg10, arg11, arg12);
        run_cetus_pqf_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12)
    }

    public fun run_cetus_pqf_v2_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T1, T0>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg10 == 0) {
            return 0
        };
        pqf2_push<T1, T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = if (arg9) {
            if (!pqf2_side_fresh<T1, T0>(arg5, false, arg12)) {
                return 0
            };
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg10, 79226673515401279992447579054, arg12);
            0x2::balance::destroy_zero<T1>(v3);
            let (v5, v6) = pqf2_buy_base_chunked<T1, T0>(arg2, arg3, arg4, arg5, v2, arg8, arg12, arg13);
            let v7 = v6;
            let v8 = v5;
            assert!(0x2::balance::value<T0>(&v7) == 0, 911);
            0x2::balance::destroy_zero<T0>(v7);
            assert!(0x2::balance::value<T1>(&v8) >= arg10 + arg11, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v8, arg10), v4);
            payout<T1>(v8, arg13);
            0x2::balance::value<T1>(&v8)
        } else {
            if (!pqf2_side_fresh<T1, T0>(arg5, true, arg12)) {
                return 0
            };
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg10, 4295048017, arg12);
            let v12 = v11;
            0x2::balance::destroy_zero<T0>(v9);
            let (v13, v14) = pqf2_sell_base_chunked<T1, T0>(arg2, arg3, arg4, arg5, v10, arg8, arg12, arg13);
            let v15 = v14;
            let v16 = v13;
            assert!(0x2::balance::value<T1>(&v15) == 0, 911);
            0x2::balance::destroy_zero<T1>(v15);
            let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
            assert!(0x2::balance::value<T0>(&v16) >= v17 + b_to_a_units(arg11, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v16, v17), 0x2::balance::zero<T1>(), v12);
            payout<T0>(v16, arg13);
            a_to_b_units(0x2::balance::value<T0>(&v16), v0)
        };
        let v18 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T1, T0>>(arg5),
            buy_on_cetus : arg9,
            spread_bps   : 0,
            size_b       : arg10,
            profit_b     : v1,
        };
        0x2::event::emit<FiredFlash>(v18);
        v1
    }

    public fun run_cetus_turbos_flash_flip<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T1, T0, T2>(arg2);
        let v2 = if (v1 == 0) {
            0
        } else {
            ((340282366920938463463374607431768211456 / (v1 as u256)) as u128)
        };
        let v3 = spread_bps(v0, v2);
        if (v3 < arg5 || arg4 == 0) {
            return 0
        };
        let v4 = v0 < v2;
        let v5 = if (v4) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v7);
            let v9 = turbos_sell_second<T1, T0, T2>(arg2, arg3, v6, arg7, arg8);
            assert!(0x2::balance::value<T1>(&v9) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v9, arg4), v8);
            payout<T1>(v9, arg8);
            0x2::balance::value<T1>(&v9)
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg4, 4295048017, arg7);
            let v13 = v12;
            0x2::balance::destroy_zero<T0>(v10);
            let v14 = turbos_buy_second<T1, T0, T2>(arg2, arg3, v11, arg7, arg8);
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
            assert!(0x2::balance::value<T0>(&v14) >= v15 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v14, v15), 0x2::balance::zero<T1>(), v13);
            payout<T0>(v14, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v14), v0)
        };
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>>(arg2),
            buy_on_cetus : v4,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v5,
        };
        0x2::event::emit<FiredFlash>(v16);
        v5
    }

    public fun run_cetus_turbos_flash_same<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2);
        let v2 = spread_bps(v0, v1);
        let v3 = if (v2 < arg5) {
            true
        } else if (arg4 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v3) {
            return 0
        };
        let v4 = v0 < v1;
        let v5 = if (v4) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v7);
            let v9 = turbos_buy_second<T0, T1, T2>(arg2, arg3, v6, arg7, arg8);
            assert!(0x2::balance::value<T1>(&v9) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v9, arg4), v8);
            payout<T1>(v9, arg8);
            0x2::balance::value<T1>(&v9)
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg4, 4295048017, arg7);
            let v13 = v12;
            0x2::balance::destroy_zero<T0>(v10);
            let v14 = turbos_sell_second<T0, T1, T2>(arg2, arg3, v11, arg7, arg8);
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
            assert!(0x2::balance::value<T0>(&v14) >= v15 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v14, v15), 0x2::balance::zero<T1>(), v13);
            payout<T0>(v14, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v14), v0)
        };
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2),
            buy_on_cetus : v4,
            spread_bps   : v2,
            size_b       : arg4,
            profit_b     : v5,
        };
        0x2::event::emit<FiredFlash>(v16);
        v5
    }

    public fun run_dae28_pqf_v2_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg6: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg11 == 0) {
            return 0
        };
        pqf2_push<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg8, arg13, arg14);
        if (!pqf2_side_fresh<T0, T1>(arg6, arg10, arg13)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg11, arg14);
        let v2 = if (arg10) {
            let v3 = dae28_sell_y<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v0), arg14);
            let (v4, v5) = pqf2_sell_base_chunked<T0, T1>(arg3, arg4, arg5, arg6, v3, arg9, arg13, arg14);
            let v6 = v5;
            let v7 = v4;
            if (0x2::balance::value<T0>(&v6) > 0) {
                let v8 = dae28_sell_x<T0, T1>(arg1, arg2, v6, arg14);
                0x2::balance::join<T1>(&mut v7, v8);
            } else {
                0x2::balance::destroy_zero<T0>(v6);
            };
            v7
        } else {
            let (v9, v10) = pqf2_buy_base_chunked<T0, T1>(arg3, arg4, arg5, arg6, 0x2::coin::into_balance<T1>(v0), arg9, arg13, arg14);
            let v11 = dae28_sell_x<T0, T1>(arg1, arg2, v9, arg14);
            let v12 = &mut v11;
            join_leftover<T1>(v12, v10);
            v11
        };
        let v13 = v2;
        assert!(0x2::balance::value<T1>(&v13) >= arg11 + arg12, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13, arg11), arg14), v1);
        let v14 = 0x2::balance::value<T1>(&v13);
        payout<T1>(v13, arg14);
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg2),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>>(arg6),
            buy_on_cetus : arg10,
            spread_bps   : 0,
            size_b       : arg11,
            profit_b     : v14,
        };
        0x2::event::emit<FiredFlash>(v15);
        v14
    }

    public fun run_deepbook_fullsail_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg3);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg9) as u128);
        let v3 = price_spread_bps(v1, v2);
        let v4 = if (v3 < arg7) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v4) {
            return 0
        };
        let v5 = v1 < v2;
        let (v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg6, arg10);
        let v8 = if (v5) {
            let v9 = fullsail_buy_a<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T1>(v6), arg9);
            db_sell_base<T0, T1>(arg0, v9, arg9, arg10)
        } else {
            let v10 = db_buy_base<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v6), arg9, arg10);
            fullsail_sell_a<T0, T1>(arg1, arg2, arg3, arg4, arg5, v10, arg9)
        };
        let v11 = v8;
        assert!(0x2::balance::value<T1>(&v11) >= arg6 + arg8, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v11, arg6), arg10), v7);
        let v12 = 0x2::balance::value<T1>(&v11);
        payout<T1>(v11, arg10);
        let v13 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg3),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            buy_on_cetus : v5,
            spread_bps   : v3,
            size_b       : arg6,
            profit_b     : v12,
        };
        0x2::event::emit<FiredFlash>(v13);
        v12
    }

    public fun run_deepbook_fullsail_flash_flip<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T0>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let v0 = cetus_price_in_db_frame_flip(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T1, T0>(arg3));
        let v1 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg9) as u128);
        let v2 = price_spread_bps(v0, v1);
        let v3 = if (v2 < arg7) {
            true
        } else if (v1 == 0) {
            true
        } else {
            v0 == 0
        };
        if (v3) {
            return 0
        };
        let v4 = v0 < v1;
        let (v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg6, arg10);
        let v7 = if (v4) {
            let v8 = fullsail_sell_a<T1, T0>(arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T1>(v5), arg9);
            db_sell_base<T0, T1>(arg0, v8, arg9, arg10)
        } else {
            let v9 = db_buy_base<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v5), arg9, arg10);
            fullsail_buy_a<T1, T0>(arg1, arg2, arg3, arg4, arg5, v9, arg9)
        };
        let v10 = v7;
        assert!(0x2::balance::value<T1>(&v10) >= arg6 + arg8, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v10, arg6), arg10), v6);
        let v11 = 0x2::balance::value<T1>(&v10);
        payout<T1>(v10, arg10);
        let v12 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T0>>(arg3),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            buy_on_cetus : v4,
            spread_bps   : v2,
            size_b       : arg6,
            profit_b     : v11,
        };
        0x2::event::emit<FiredFlash>(v12);
        v11
    }

    public fun run_deepbook_pqf_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        if (!pqf_side_fresh<T0, T1>(arg4, arg5, arg8)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg6, arg9);
        let v2 = if (arg5) {
            let v3 = db_buy_base<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v0), arg8, arg9);
            pqf_sell_base<T0, T1>(arg1, arg2, arg3, arg4, v3, arg8, arg9)
        } else {
            let v4 = pqf_buy_base<T0, T1>(arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T1>(v0), arg8, arg9);
            db_sell_base<T0, T1>(arg0, v4, arg8, arg9)
        };
        let v5 = v2;
        assert!(0x2::balance::value<T1>(&v5) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, arg6), arg9), v1);
        let v6 = 0x2::balance::value<T1>(&v5);
        payout<T1>(v5, arg9);
        let v7 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg4),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v6,
        };
        0x2::event::emit<FiredFlash>(v7);
        v6
    }

    public fun run_deepbook_pqf_flash_env<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg5: bool, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        pqf1_push<T0, T1>(arg1, arg2, arg3, arg4, arg8, arg9, arg10, arg11);
        run_deepbook_pqf_flash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11)
    }

    public fun run_deepbook_pqf_v2_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg9 == 0) {
            return 0
        };
        pqf2_push<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg11, arg12);
        if (!pqf2_side_fresh<T0, T1>(arg4, arg8, arg11)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg9, arg12);
        let v2 = if (arg8) {
            let v3 = db_buy_base<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v0), arg11, arg12);
            let (v4, v5) = pqf2_sell_base_chunked<T0, T1>(arg1, arg2, arg3, arg4, v3, arg7, arg11, arg12);
            let v6 = v5;
            let v7 = v4;
            if (0x2::balance::value<T0>(&v6) > 0) {
                let v8 = db_sell_base<T0, T1>(arg0, v6, arg11, arg12);
                0x2::balance::join<T1>(&mut v7, v8);
            } else {
                0x2::balance::destroy_zero<T0>(v6);
            };
            v7
        } else {
            let (v9, v10) = pqf2_buy_base_chunked<T0, T1>(arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T1>(v0), arg7, arg11, arg12);
            let v11 = v9;
            let v12 = if (0x2::balance::value<T0>(&v11) > 0) {
                db_sell_base<T0, T1>(arg0, v11, arg11, arg12)
            } else {
                0x2::balance::destroy_zero<T0>(v11);
                0x2::balance::zero<T1>()
            };
            let v13 = v12;
            0x2::balance::join<T1>(&mut v13, v10);
            v13
        };
        let v14 = v2;
        assert!(0x2::balance::value<T1>(&v14) >= arg9 + arg10, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v14, arg9), arg12), v1);
        let v15 = 0x2::balance::value<T1>(&v14);
        payout<T1>(v14, arg12);
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>>(arg4),
            buy_on_cetus : arg8,
            spread_bps   : 0,
            size_b       : arg9,
            profit_b     : v15,
        };
        0x2::event::emit<FiredFlash>(v16);
        v15
    }

    public fun run_dlmm_bluefin_flash_flip<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let v0 = if (arg5) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, arg6, arg1, arg2, arg8, arg9);
            0x2::balance::destroy_zero<T1>(v2);
            let v4 = bluefin_buy_a<T1, T0>(arg3, arg4, v1, arg8);
            assert!(0x2::balance::value<T1>(&v4) >= arg6 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, arg6), v3, arg2);
            payout<T1>(v4, arg9);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, false, arg6, arg1, arg2, arg8, arg9);
            let v8 = v7;
            0x2::balance::destroy_zero<T0>(v5);
            let v9 = bluefin_sell_a<T1, T0>(arg3, arg4, v6, arg8);
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v8);
            assert!(0x2::balance::value<T0>(&v9) >= v10 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v9, v10), 0x2::balance::zero<T1>(), v8, arg2);
            payout<T0>(v9, arg9);
            0x2::balance::value<T0>(&v9)
        };
        let v11 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg4),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v11);
        v0
    }

    public fun run_dlmm_bolt_flash<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg4: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let v0 = if (arg5) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, arg6, arg1, arg2, arg8, arg9);
            0x2::balance::destroy_zero<T1>(v2);
            let (v4, v5) = bolt_sell_base<T0, T1>(arg3, arg4, v1, arg8, arg9);
            let v6 = v5;
            let v7 = v4;
            if (0x2::balance::value<T0>(&v6) > 0) {
                let v8 = dlmm_sell_a<T0, T1>(arg0, arg1, arg2, v6, arg8, arg9);
                0x2::balance::join<T1>(&mut v7, v8);
            } else {
                0x2::balance::destroy_zero<T0>(v6);
            };
            assert!(0x2::balance::value<T1>(&v7) >= arg6 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, arg6), v3, arg2);
            payout<T1>(v7, arg9);
            0x2::balance::value<T1>(&v7)
        } else {
            let (v9, v10, v11) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, false, arg6, arg1, arg2, arg8, arg9);
            let v12 = v11;
            0x2::balance::destroy_zero<T0>(v9);
            let (v13, v14) = bolt_buy_base<T0, T1>(arg3, arg4, v10, arg8, arg9);
            let v15 = v14;
            let v16 = v13;
            if (0x2::balance::value<T1>(&v15) > 0) {
                let v17 = dlmm_buy_a<T0, T1>(arg0, arg1, arg2, v15, arg8, arg9);
                0x2::balance::join<T0>(&mut v16, v17);
            } else {
                0x2::balance::destroy_zero<T1>(v15);
            };
            let v18 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v12);
            assert!(0x2::balance::value<T0>(&v16) >= v18 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v16, v18), 0x2::balance::zero<T1>(), v12, arg2);
            payout<T0>(v16, arg9);
            0x2::balance::value<T0>(&v16)
        };
        let v19 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg3),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v19);
        v0
    }

    public fun run_dlmm_bolt_flash_flip<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg4: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let v0 = if (arg5) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, arg6, arg1, arg2, arg8, arg9);
            0x2::balance::destroy_zero<T1>(v2);
            let (v4, v5) = bolt_buy_base<T1, T0>(arg3, arg4, v1, arg8, arg9);
            let v6 = v5;
            let v7 = v4;
            if (0x2::balance::value<T0>(&v6) > 0) {
                let v8 = dlmm_sell_a<T0, T1>(arg0, arg1, arg2, v6, arg8, arg9);
                0x2::balance::join<T1>(&mut v7, v8);
            } else {
                0x2::balance::destroy_zero<T0>(v6);
            };
            assert!(0x2::balance::value<T1>(&v7) >= arg6 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, arg6), v3, arg2);
            payout<T1>(v7, arg9);
            0x2::balance::value<T1>(&v7)
        } else {
            let (v9, v10, v11) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, false, arg6, arg1, arg2, arg8, arg9);
            let v12 = v11;
            0x2::balance::destroy_zero<T0>(v9);
            let (v13, v14) = bolt_sell_base<T1, T0>(arg3, arg4, v10, arg8, arg9);
            let v15 = v14;
            let v16 = v13;
            if (0x2::balance::value<T1>(&v15) > 0) {
                let v17 = dlmm_buy_a<T0, T1>(arg0, arg1, arg2, v15, arg8, arg9);
                0x2::balance::join<T0>(&mut v16, v17);
            } else {
                0x2::balance::destroy_zero<T1>(v15);
            };
            let v18 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v12);
            assert!(0x2::balance::value<T0>(&v16) >= v18 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v16, v18), 0x2::balance::zero<T1>(), v12, arg2);
            payout<T0>(v16, arg9);
            0x2::balance::value<T0>(&v16)
        };
        let v19 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg3),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v19);
        v0
    }

    public fun run_dlmm_cetus_flash<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let v0 = if (arg5) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, arg6, arg1, arg2, arg8, arg9);
            0x2::balance::destroy_zero<T1>(v2);
            let v4 = cetus_sell_a<T0, T1>(arg3, arg4, v1, arg8);
            assert!(0x2::balance::value<T1>(&v4) >= arg6 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, arg6), v3, arg2);
            payout<T1>(v4, arg9);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, false, arg6, arg1, arg2, arg8, arg9);
            let v8 = v7;
            0x2::balance::destroy_zero<T0>(v5);
            let v9 = cetus_buy_a<T0, T1>(arg3, arg4, v6, arg8);
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v8);
            assert!(0x2::balance::value<T0>(&v9) >= v10 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v9, v10), 0x2::balance::zero<T1>(), v8, arg2);
            payout<T0>(v9, arg9);
            0x2::balance::value<T0>(&v9)
        };
        let v11 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v11);
        v0
    }

    public fun run_dlmm_dae28_flash<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg4: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T1, T0>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let v0 = if (arg5) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, arg6, arg1, arg2, arg8, arg9);
            0x2::balance::destroy_zero<T1>(v2);
            let v4 = dae28_sell_y<T1, T0>(arg3, arg4, v1, arg9);
            assert!(0x2::balance::value<T1>(&v4) >= arg6 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, arg6), v3, arg2);
            payout<T1>(v4, arg9);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, false, arg6, arg1, arg2, arg8, arg9);
            let v8 = v7;
            0x2::balance::destroy_zero<T0>(v5);
            let v9 = dae28_sell_x<T1, T0>(arg3, arg4, v6, arg9);
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v8);
            assert!(0x2::balance::value<T0>(&v9) >= v10 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v9, v10), 0x2::balance::zero<T1>(), v8, arg2);
            payout<T0>(v9, arg9);
            0x2::balance::value<T0>(&v9)
        };
        let v11 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T1, T0>>(arg4),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v11);
        v0
    }

    public fun run_dlmm_deepbook_flash<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = if (arg4) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, arg5, arg1, arg2, arg7, arg8);
            0x2::balance::destroy_zero<T1>(v2);
            let v4 = db_sell_base<T0, T1>(arg3, v1, arg7, arg8);
            assert!(0x2::balance::value<T1>(&v4) >= arg5 + arg6, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, arg5), v3, arg2);
            payout<T1>(v4, arg8);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, false, arg5, arg1, arg2, arg7, arg8);
            let v8 = v7;
            0x2::balance::destroy_zero<T0>(v5);
            let v9 = db_buy_base<T0, T1>(arg3, v6, arg7, arg8);
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v8);
            assert!(0x2::balance::value<T0>(&v9) >= v10 + arg6, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v9, v10), 0x2::balance::zero<T1>(), v8, arg2);
            payout<T0>(v9, arg8);
            0x2::balance::value<T0>(&v9)
        };
        let v11 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : arg4,
            spread_bps   : 0,
            size_b       : arg5,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v11);
        v0
    }

    public fun run_dlmm_deepbook_flash_flip<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = if (arg4) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, arg5, arg1, arg2, arg7, arg8);
            0x2::balance::destroy_zero<T1>(v2);
            let v4 = db_buy_base<T1, T0>(arg3, v1, arg7, arg8);
            assert!(0x2::balance::value<T1>(&v4) >= arg5 + arg6, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, arg5), v3, arg2);
            payout<T1>(v4, arg8);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, false, arg5, arg1, arg2, arg7, arg8);
            let v8 = v7;
            0x2::balance::destroy_zero<T0>(v5);
            let v9 = db_sell_base<T1, T0>(arg3, v6, arg7, arg8);
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v8);
            assert!(0x2::balance::value<T0>(&v9) >= v10 + arg6, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v9, v10), 0x2::balance::zero<T1>(), v8, arg2);
            payout<T0>(v9, arg8);
            0x2::balance::value<T0>(&v9)
        };
        let v11 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg3),
            buy_on_cetus : arg4,
            spread_bps   : 0,
            size_b       : arg5,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v11);
        v0
    }

    public fun run_dlmm_momentum_flash<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let v0 = if (arg5) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, arg6, arg1, arg2, arg8, arg9);
            0x2::balance::destroy_zero<T1>(v2);
            let v4 = mmt_buy_x<T1, T0>(arg3, arg4, v1, arg8, arg9);
            assert!(0x2::balance::value<T1>(&v4) >= arg6 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, arg6), v3, arg2);
            payout<T1>(v4, arg9);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, false, arg6, arg1, arg2, arg8, arg9);
            let v8 = v7;
            0x2::balance::destroy_zero<T0>(v5);
            let v9 = mmt_sell_x<T1, T0>(arg3, arg4, v6, arg8, arg9);
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v8);
            assert!(0x2::balance::value<T0>(&v9) >= v10 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v9, v10), 0x2::balance::zero<T1>(), v8, arg2);
            payout<T0>(v9, arg9);
            0x2::balance::value<T0>(&v9)
        };
        let v11 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg3),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v11);
        v0
    }

    public fun run_dlmm_pqf_v2_flash<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg6: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T1, T0>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg11 == 0) {
            return 0
        };
        pqf2_push<T1, T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg13, arg14);
        if (!pqf2_side_fresh<T1, T0>(arg6, arg10, arg13)) {
            return 0
        };
        let v0 = if (arg10) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, arg11, arg1, arg2, arg13, arg14);
            0x2::balance::destroy_zero<T1>(v2);
            let (v4, v5) = pqf2_buy_base_chunked<T1, T0>(arg3, arg4, arg5, arg6, v1, arg9, arg13, arg14);
            let v6 = v5;
            assert!(0x2::balance::value<T0>(&v6) == 0, 911);
            0x2::balance::destroy_zero<T0>(v6);
            let v7 = v4;
            assert!(0x2::balance::value<T1>(&v7) >= arg11 + arg12, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, arg11), v3, arg2);
            payout<T1>(v7, arg14);
            0x2::balance::value<T1>(&v7)
        } else {
            let (v8, v9, v10) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, false, arg11, arg1, arg2, arg13, arg14);
            let v11 = v10;
            0x2::balance::destroy_zero<T0>(v8);
            let (v12, v13) = pqf2_sell_base_chunked<T1, T0>(arg3, arg4, arg5, arg6, v9, arg9, arg13, arg14);
            let v14 = v13;
            assert!(0x2::balance::value<T1>(&v14) == 0, 911);
            0x2::balance::destroy_zero<T1>(v14);
            let v15 = v12;
            let v16 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v11);
            assert!(0x2::balance::value<T0>(&v15) >= v16 + arg12, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v15, v16), 0x2::balance::zero<T1>(), v11, arg2);
            payout<T0>(v15, arg14);
            0x2::balance::value<T0>(&v15)
        };
        let v17 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T1, T0>>(arg6),
            buy_on_cetus : arg10,
            spread_bps   : 0,
            size_b       : arg11,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v17);
        v0
    }

    public fun run_dlmm_turbos_flash_flip<T0, T1, T2>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let v0 = if (arg5) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, arg6, arg1, arg2, arg8, arg9);
            0x2::balance::destroy_zero<T1>(v2);
            let v4 = turbos_sell_second<T1, T0, T2>(arg3, arg4, v1, arg8, arg9);
            assert!(0x2::balance::value<T1>(&v4) >= arg6 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, arg6), v3, arg2);
            payout<T1>(v4, arg9);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, false, arg6, arg1, arg2, arg8, arg9);
            let v8 = v7;
            0x2::balance::destroy_zero<T0>(v5);
            let v9 = turbos_buy_second<T1, T0, T2>(arg3, arg4, v6, arg8, arg9);
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v8);
            assert!(0x2::balance::value<T0>(&v9) >= v10 + arg7, 910);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v9, v10), 0x2::balance::zero<T1>(), v8, arg2);
            payout<T0>(v9, arg9);
            0x2::balance::value<T0>(&v9)
        };
        let v11 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>>(arg3),
            buy_on_cetus : arg5,
            spread_bps   : 0,
            size_b       : arg6,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v11);
        v0
    }

    public fun run_momentum_deepbook_flash<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = if (arg3) {
            let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, arg4, 79226673515401279992447579054, arg6, arg1, arg7);
            0x2::balance::destroy_zero<T1>(v2);
            let v4 = db_sell_base<T0, T1>(arg2, v1, arg6, arg7);
            assert!(0x2::balance::value<T1>(&v4) >= arg4 + arg5, 910);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, arg4), arg1, arg7);
            payout<T1>(v4, arg7);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, arg4, 4295048017, arg6, arg1, arg7);
            0x2::balance::destroy_zero<T0>(v5);
            let v8 = db_buy_base<T0, T1>(arg2, v6, arg6, arg7);
            assert!(0x2::balance::value<T0>(&v8) >= arg4 + arg5, 910);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v7, 0x2::balance::split<T0>(&mut v8, arg4), 0x2::balance::zero<T1>(), arg1, arg7);
            payout<T0>(v8, arg7);
            0x2::balance::value<T0>(&v8)
        };
        let v9 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : arg3,
            spread_bps   : 0,
            size_b       : arg4,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v9);
        v0
    }

    public fun run_momentum_pqf_flash<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        let v0 = if (arg6) {
            if (!pqf_side_fresh<T0, T1>(arg5, true, arg9)) {
                return 0
            };
            let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, arg7, 79226673515401279992447579054, arg9, arg1, arg10);
            0x2::balance::destroy_zero<T1>(v2);
            let v4 = pqf_sell_base<T0, T1>(arg2, arg3, arg4, arg5, v1, arg9, arg10);
            assert!(0x2::balance::value<T1>(&v4) >= arg7 + arg8, 910);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, arg7), arg1, arg10);
            payout<T1>(v4, arg10);
            0x2::balance::value<T1>(&v4)
        } else {
            if (!pqf_side_fresh<T0, T1>(arg5, false, arg9)) {
                return 0
            };
            let (v5, v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, arg7, 4295048017, arg9, arg1, arg10);
            0x2::balance::destroy_zero<T0>(v5);
            let v8 = pqf_buy_base<T0, T1>(arg2, arg3, arg4, arg5, v6, arg9, arg10);
            assert!(0x2::balance::value<T0>(&v8) >= arg7 + arg8, 910);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v7, 0x2::balance::split<T0>(&mut v8, arg7), 0x2::balance::zero<T1>(), arg1, arg10);
            payout<T0>(v8, arg10);
            0x2::balance::value<T0>(&v8)
        };
        let v9 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg5),
            buy_on_cetus : arg6,
            spread_bps   : 0,
            size_b       : arg7,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v9);
        v0
    }

    public fun run_momentum_pqf_v2_flash<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg10 == 0) {
            return 0
        };
        pqf2_push<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13);
        if (!pqf2_side_fresh<T0, T1>(arg5, arg9, arg12)) {
            return 0
        };
        let v0 = if (arg9) {
            let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, arg10, 79226673515401279992447579054, arg12, arg1, arg13);
            0x2::balance::destroy_zero<T1>(v2);
            let (v4, v5) = pqf2_sell_base_chunked<T0, T1>(arg2, arg3, arg4, arg5, v1, arg8, arg12, arg13);
            let v6 = v5;
            let v7 = v4;
            assert!(0x2::balance::value<T0>(&v6) == 0, 911);
            0x2::balance::destroy_zero<T0>(v6);
            assert!(0x2::balance::value<T1>(&v7) >= arg10 + arg11, 910);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, arg10), arg1, arg13);
            payout<T1>(v7, arg13);
            0x2::balance::value<T1>(&v7)
        } else {
            let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, arg10, 4295048017, arg12, arg1, arg13);
            0x2::balance::destroy_zero<T0>(v8);
            let (v11, v12) = pqf2_buy_base_chunked<T0, T1>(arg2, arg3, arg4, arg5, v9, arg8, arg12, arg13);
            let v13 = v12;
            let v14 = v11;
            assert!(0x2::balance::value<T1>(&v13) == 0, 911);
            0x2::balance::destroy_zero<T1>(v13);
            assert!(0x2::balance::value<T0>(&v14) >= arg10 + arg11, 910);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v10, 0x2::balance::split<T0>(&mut v14, arg10), 0x2::balance::zero<T1>(), arg1, arg13);
            payout<T0>(v14, arg13);
            0x2::balance::value<T0>(&v14)
        };
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>>(arg5),
            buy_on_cetus : arg9,
            spread_bps   : 0,
            size_b       : arg10,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v15);
        v0
    }

    public fun run_obric_pqf_flash<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg6: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg7: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg8: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg9: bool, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg10 == 0) {
            return 0
        };
        if (!pqf_side_fresh<T0, T1>(arg8, arg9, arg12)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg10, arg13);
        let v2 = if (arg9) {
            let v3 = 0x2::coin::into_balance<T0>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg1, arg12, arg2, arg3, arg4, v0, arg13));
            pqf_sell_base<T0, T1>(arg5, arg6, arg7, arg8, v3, arg12, arg13)
        } else {
            let v4 = pqf_buy_base<T0, T1>(arg5, arg6, arg7, arg8, 0x2::coin::into_balance<T1>(v0), arg12, arg13);
            0x2::coin::into_balance<T1>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg1, arg12, arg2, arg3, arg4, 0x2::coin::from_balance<T0>(v4, arg13), arg13))
        };
        let v5 = v2;
        assert!(0x2::balance::value<T1>(&v5) >= arg10 + arg11, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, arg10), arg13), v1);
        let v6 = 0x2::balance::value<T1>(&v5);
        payout<T1>(v5, arg13);
        let v7 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg8),
            buy_on_cetus : arg9,
            spread_bps   : 0,
            size_b       : arg10,
            profit_b     : v6,
        };
        0x2::event::emit<FiredFlash>(v7);
        v6
    }

    public fun run_tri_bf_bf_db<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg3, arg5, arg8);
        let v2 = if (arg4) {
            let v3 = bluefin_buy_a<T1, T0>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg7);
            let v4 = bluefin_buy_a<T2, T1>(arg0, arg2, v3, arg7);
            db_sell_base<T2, T0>(arg3, v4, arg7, arg8)
        } else {
            let v5 = db_buy_base<T2, T0>(arg3, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v6 = bluefin_sell_a<T2, T1>(arg0, arg2, v5, arg7);
            bluefin_sell_a<T1, T0>(arg0, arg1, v6, arg7)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg5 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg5), arg8), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg8);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg1),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg2),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg3),
            forward  : arg4,
            size_s   : arg5,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bf_cetus_db<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg4, arg6, arg9);
        let v2 = if (arg5) {
            let v3 = bluefin_buy_a<T1, T0>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg8);
            let v4 = cetus_sell_a<T1, T2>(arg2, arg3, v3, arg8);
            db_sell_base<T2, T0>(arg4, v4, arg8, arg9)
        } else {
            let v5 = db_buy_base<T2, T0>(arg4, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
            let v6 = cetus_buy_a<T1, T2>(arg2, arg3, v5, arg8);
            bluefin_sell_a<T1, T0>(arg0, arg1, v6, arg8)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg4),
            forward  : arg5,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bf_fullsail_db<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg6: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg9 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg7, arg9, arg12);
        let v2 = if (arg8) {
            let v3 = bluefin_buy_a<T1, T0>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg11);
            let v4 = fullsail_sell_a<T1, T2>(arg2, arg3, arg4, arg5, arg6, v3, arg11);
            db_sell_base<T2, T0>(arg7, v4, arg11, arg12)
        } else {
            let v5 = db_buy_base<T2, T0>(arg7, 0x2::coin::into_balance<T0>(v0), arg11, arg12);
            let v6 = fullsail_buy_a<T1, T2>(arg2, arg3, arg4, arg5, arg6, v5, arg11);
            bluefin_sell_a<T1, T0>(arg0, arg1, v6, arg11)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg9 + arg10, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg7, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg9), arg12), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg12);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg1),
            pool_2   : 0x2::object::id_address<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>>(arg4),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg7),
            forward  : arg8,
            size_s   : arg9,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_bf_bf<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg6, arg9);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = bluefin_sell_a<T1, T2>(arg3, arg4, v4, arg8);
        let v6 = bluefin_buy_a<T0, T2>(arg3, arg5, v5, arg8);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4),
            pool_3   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg5),
            forward  : true,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_bf_c<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg7, arg10);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg9, arg10);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = bluefin_sell_a<T1, T2>(arg3, arg4, v4, arg9);
        let v6 = cetus_buy_a<T0, T2>(arg5, arg6, v5, arg9);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg7 + arg8, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg7), arg10), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg10);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4),
            pool_3   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg6),
            forward  : true,
            size_s   : arg7,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_bf_pqf2<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg6: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg7: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg8: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 == 0) {
            return 0
        };
        pqf2_push<T2, T0>(arg5, arg6, arg7, arg8, arg9, arg10, arg14, arg15);
        if (!pqf2_side_fresh<T2, T0>(arg8, true, arg14)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg12, arg15);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg14, arg15);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = bluefin_buy_a<T2, T1>(arg3, arg4, v4, arg14);
        let (v6, v7) = pqf2_sell_base_chunked<T2, T0>(arg5, arg6, arg7, arg8, v5, arg11, arg14, arg15);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::balance::value<T2>(&v8) == 0, 911);
        0x2::balance::destroy_zero<T2>(v8);
        let v10 = &mut v9;
        join_leftover<T0>(v10, v3);
        assert!(0x2::balance::value<T0>(&v9) >= arg12 + arg13, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9, arg12), arg15), v1);
        let v11 = 0x2::balance::value<T0>(&v9);
        payout<T0>(v9, arg15);
        let v12 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg4),
            pool_3   : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>>(arg8),
            forward  : true,
            size_s   : arg12,
            profit_b : v11,
        };
        0x2::event::emit<FiredTri>(v12);
        v11
    }

    public fun run_tri_bolt_bf_pqf2_flip<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg6: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg7: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg8: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 == 0) {
            return 0
        };
        pqf2_push<T2, T0>(arg5, arg6, arg7, arg8, arg9, arg10, arg14, arg15);
        if (!pqf2_side_fresh<T2, T0>(arg8, true, arg14)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg12, arg15);
        let (v2, v3) = bolt_sell_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg14, arg15);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = bluefin_buy_a<T2, T1>(arg3, arg4, v4, arg14);
        let (v6, v7) = pqf2_sell_base_chunked<T2, T0>(arg5, arg6, arg7, arg8, v5, arg11, arg14, arg15);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::balance::value<T2>(&v8) == 0, 911);
        0x2::balance::destroy_zero<T2>(v8);
        let v10 = &mut v9;
        join_leftover<T0>(v10, v3);
        assert!(0x2::balance::value<T0>(&v9) >= arg12 + arg13, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9, arg12), arg15), v1);
        let v11 = 0x2::balance::value<T0>(&v9);
        payout<T0>(v9, arg15);
        let v12 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg4),
            pool_3   : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>>(arg8),
            forward  : false,
            size_s   : arg12,
            profit_b : v11,
        };
        0x2::event::emit<FiredTri>(v12);
        v11
    }

    public fun run_tri_bolt_bf_tb<T0, T1, T2, T3, T4>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg7, arg10);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg9, arg10);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = bluefin_buy_a<T2, T1>(arg3, arg4, v4, arg9);
        let v6 = turbos_buy_second<T2, T0, T4>(arg5, arg6, v5, arg9, arg10);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg7 + arg8, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg7), arg10), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg10);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg4),
            pool_3   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>>(arg5),
            forward  : true,
            size_s   : arg7,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_bf_tb_flip<T0, T1, T2, T3, T4>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg7, arg10);
        let (v2, v3) = bolt_sell_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg9, arg10);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = bluefin_buy_a<T2, T1>(arg3, arg4, v4, arg9);
        let v6 = turbos_buy_second<T2, T0, T4>(arg5, arg6, v5, arg9, arg10);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg7 + arg8, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg7), arg10), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg10);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg4),
            pool_3   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>>(arg5),
            forward  : false,
            size_s   : arg7,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_c_db<T0, T1, T2>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg4, arg5, arg8);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = cetus_buy_a<T2, T1>(arg2, arg3, v4, arg7);
        let v6 = db_sell_base<T2, T0>(arg4, v5, arg7, arg8);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg5 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg5), arg8), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg8);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg0),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg4),
            forward  : true,
            size_s   : arg5,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_c_db_flip<T0, T1, T2>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg4, arg5, arg8);
        let (v2, v3) = bolt_sell_base<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = cetus_buy_a<T2, T1>(arg2, arg3, v4, arg7);
        let v6 = db_sell_base<T2, T0>(arg4, v5, arg7, arg8);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg5 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg5), arg8), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg8);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg0),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg4),
            forward  : false,
            size_s   : arg5,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_c_pqf2<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg6: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg7: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg8: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 == 0) {
            return 0
        };
        pqf2_push<T2, T0>(arg5, arg6, arg7, arg8, arg9, arg10, arg14, arg15);
        if (!pqf2_side_fresh<T2, T0>(arg8, true, arg14)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg12, arg15);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg14, arg15);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = cetus_buy_a<T2, T1>(arg3, arg4, v4, arg14);
        let (v6, v7) = pqf2_sell_base_chunked<T2, T0>(arg5, arg6, arg7, arg8, v5, arg11, arg14, arg15);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::balance::value<T2>(&v8) == 0, 911);
        0x2::balance::destroy_zero<T2>(v8);
        let v10 = &mut v9;
        join_leftover<T0>(v10, v3);
        assert!(0x2::balance::value<T0>(&v9) >= arg12 + arg13, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9, arg12), arg15), v1);
        let v11 = 0x2::balance::value<T0>(&v9);
        payout<T0>(v9, arg15);
        let v12 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4),
            pool_3   : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>>(arg8),
            forward  : true,
            size_s   : arg12,
            profit_b : v11,
        };
        0x2::event::emit<FiredTri>(v12);
        v11
    }

    public fun run_tri_bolt_c_pqf2_flip<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg6: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg7: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg8: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 == 0) {
            return 0
        };
        pqf2_push<T2, T0>(arg5, arg6, arg7, arg8, arg9, arg10, arg14, arg15);
        if (!pqf2_side_fresh<T2, T0>(arg8, true, arg14)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg12, arg15);
        let (v2, v3) = bolt_sell_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg14, arg15);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = cetus_buy_a<T2, T1>(arg3, arg4, v4, arg14);
        let (v6, v7) = pqf2_sell_base_chunked<T2, T0>(arg5, arg6, arg7, arg8, v5, arg11, arg14, arg15);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::balance::value<T2>(&v8) == 0, 911);
        0x2::balance::destroy_zero<T2>(v8);
        let v10 = &mut v9;
        join_leftover<T0>(v10, v3);
        assert!(0x2::balance::value<T0>(&v9) >= arg12 + arg13, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9, arg12), arg15), v1);
        let v11 = 0x2::balance::value<T0>(&v9);
        payout<T0>(v9, arg15);
        let v12 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4),
            pool_3   : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>>(arg8),
            forward  : false,
            size_s   : arg12,
            profit_b : v11,
        };
        0x2::event::emit<FiredTri>(v12);
        v11
    }

    public fun run_tri_bolt_c_tb<T0, T1, T2, T3, T4>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg7, arg10);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg9, arg10);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = cetus_buy_a<T2, T1>(arg3, arg4, v4, arg9);
        let v6 = turbos_buy_second<T2, T0, T4>(arg5, arg6, v5, arg9, arg10);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg7 + arg8, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg7), arg10), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg10);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4),
            pool_3   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>>(arg5),
            forward  : true,
            size_s   : arg7,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_c_tb_flip<T0, T1, T2, T3, T4>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg7, arg10);
        let (v2, v3) = bolt_sell_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg9, arg10);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = cetus_buy_a<T2, T1>(arg3, arg4, v4, arg9);
        let v6 = turbos_buy_second<T2, T0, T4>(arg5, arg6, v5, arg9, arg10);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg7 + arg8, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg7), arg10), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg10);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4),
            pool_3   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>>(arg5),
            forward  : false,
            size_s   : arg7,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_cc_a<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg6, arg9);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = cetus_buy_a<T2, T1>(arg3, arg4, v4, arg8);
        let v6 = cetus_buy_a<T0, T2>(arg3, arg5, v5, arg8);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4),
            pool_3   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg5),
            forward  : true,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_cc_a_flip<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg6, arg9);
        let (v2, v3) = bolt_sell_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = cetus_buy_a<T2, T1>(arg3, arg4, v4, arg8);
        let v6 = cetus_buy_a<T0, T2>(arg3, arg5, v5, arg8);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4),
            pool_3   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg5),
            forward  : false,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_cc_b<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg6, arg9);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = cetus_sell_a<T1, T2>(arg3, arg4, v4, arg8);
        let v6 = cetus_sell_a<T2, T0>(arg3, arg5, v5, arg8);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg4),
            pool_3   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg5),
            forward  : true,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_cc_b_flip<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg6, arg9);
        let (v2, v3) = bolt_sell_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = cetus_sell_a<T1, T2>(arg3, arg4, v4, arg8);
        let v6 = cetus_sell_a<T2, T0>(arg3, arg5, v5, arg8);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg4),
            pool_3   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg5),
            forward  : false,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_db_tb<T0, T1, T2, T3, T4>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg6, arg9);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = db_buy_base<T2, T1>(arg3, v4, arg8, arg9);
        let v6 = turbos_buy_second<T2, T0, T4>(arg4, arg5, v5, arg8, arg9);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>>(arg3),
            pool_3   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>>(arg4),
            forward  : true,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_db_tb_flip<T0, T1, T2, T3, T4>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg6, arg9);
        let (v2, v3) = bolt_sell_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = db_buy_base<T2, T1>(arg3, v4, arg8, arg9);
        let v6 = turbos_buy_second<T2, T0, T4>(arg4, arg5, v5, arg8, arg9);
        let v7 = &mut v6;
        join_leftover<T0>(v7, v3);
        assert!(0x2::balance::value<T0>(&v6) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        payout<T0>(v6, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pool_2   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>>(arg3),
            pool_3   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T4>>(arg4),
            forward  : false,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_bolt_tb_pqf2<T0, T1, T2, T3, T4>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T1, T4>, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg6: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg7: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg8: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 == 0) {
            return 0
        };
        pqf2_push<T2, T0>(arg5, arg6, arg7, arg8, arg9, arg10, arg14, arg15);
        if (!pqf2_side_fresh<T2, T0>(arg8, true, arg14)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg12, arg15);
        let (v2, v3) = bolt_buy_base<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg14, arg15);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = turbos_sell_second<T2, T1, T4>(arg4, arg3, v4, arg14, arg15);
        let (v6, v7) = pqf2_sell_base_chunked<T2, T0>(arg5, arg6, arg7, arg8, v5, arg11, arg14, arg15);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::balance::value<T2>(&v8) == 0, 911);
        0x2::balance::destroy_zero<T2>(v8);
        let v10 = &mut v9;
        join_leftover<T0>(v10, v3);
        assert!(0x2::balance::value<T0>(&v9) >= arg12 + arg13, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9, arg12), arg15), v1);
        let v11 = 0x2::balance::value<T0>(&v9);
        payout<T0>(v9, arg15);
        let v12 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T1, T4>>(arg4),
            pool_3   : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>>(arg8),
            forward  : true,
            size_s   : arg12,
            profit_b : v11,
        };
        0x2::event::emit<FiredTri>(v12);
        v11
    }

    public fun run_tri_bolt_tb_pqf2_flip<T0, T1, T2, T3, T4>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T1, T4>, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg6: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg7: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg8: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 == 0) {
            return 0
        };
        pqf2_push<T2, T0>(arg5, arg6, arg7, arg8, arg9, arg10, arg14, arg15);
        if (!pqf2_side_fresh<T2, T0>(arg8, true, arg14)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg0, arg12, arg15);
        let (v2, v3) = bolt_sell_base<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), arg14, arg15);
        let v4 = v2;
        assert!(0x2::balance::value<T1>(&v4) > 0, 910);
        let v5 = turbos_sell_second<T2, T1, T4>(arg4, arg3, v4, arg14, arg15);
        let (v6, v7) = pqf2_sell_base_chunked<T2, T0>(arg5, arg6, arg7, arg8, v5, arg11, arg14, arg15);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::balance::value<T2>(&v8) == 0, 911);
        0x2::balance::destroy_zero<T2>(v8);
        let v10 = &mut v9;
        join_leftover<T0>(v10, v3);
        assert!(0x2::balance::value<T0>(&v9) >= arg12 + arg13, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9, arg12), arg15), v1);
        let v11 = 0x2::balance::value<T0>(&v9);
        payout<T0>(v9, arg15);
        let v12 = FiredTri{
            pool_1   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1),
            pool_2   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T1, T4>>(arg4),
            pool_3   : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T2, T0>>(arg8),
            forward  : false,
            size_s   : arg12,
            profit_b : v11,
        };
        0x2::event::emit<FiredTri>(v12);
        v11
    }

    public fun run_tri_cetus3<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = if (arg4) {
            let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg5, 4295048017, arg7);
            0x2::balance::destroy_zero<T0>(v1);
            let v4 = cetus_sell_a<T1, T2>(arg0, arg2, v2, arg7);
            let v5 = cetus_buy_a<T0, T2>(arg0, arg3, v4, arg7);
            assert!(0x2::balance::value<T0>(&v5) >= arg5 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v5, arg5), 0x2::balance::zero<T1>(), v3);
            payout<T0>(v5, arg8);
            0x2::balance::value<T0>(&v5)
        } else {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg3, true, true, arg5, 4295048017, arg7);
            0x2::balance::destroy_zero<T0>(v6);
            let v9 = cetus_buy_a<T1, T2>(arg0, arg2, v7, arg7);
            let v10 = cetus_buy_a<T0, T1>(arg0, arg1, v9, arg7);
            assert!(0x2::balance::value<T0>(&v10) >= arg5 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg3, 0x2::balance::split<T0>(&mut v10, arg5), 0x2::balance::zero<T2>(), v8);
            payout<T0>(v10, arg8);
            0x2::balance::value<T0>(&v10)
        };
        let v11 = FiredTri{
            pool_1   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2),
            pool_3   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg3),
            forward  : arg4,
            size_s   : arg5,
            profit_b : v0,
        };
        0x2::event::emit<FiredTri>(v11);
        v0
    }

    public fun run_tri_cetus_bf_db<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg4, arg6, arg9);
        let v2 = if (arg5) {
            let v3 = cetus_sell_a<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg8);
            let v4 = bluefin_buy_a<T2, T1>(arg2, arg3, v3, arg8);
            db_sell_base<T2, T0>(arg4, v4, arg8, arg9)
        } else {
            let v5 = db_buy_base<T2, T0>(arg4, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
            let v6 = bluefin_sell_a<T2, T1>(arg2, arg3, v5, arg8);
            cetus_buy_a<T0, T1>(arg0, arg1, v6, arg8)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg4),
            forward  : arg5,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_cetus_cetus_db<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg3, arg5, arg8);
        let v2 = if (arg4) {
            let v3 = cetus_sell_a<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg7);
            let v4 = cetus_sell_a<T1, T2>(arg0, arg2, v3, arg7);
            db_sell_base<T2, T0>(arg3, v4, arg7, arg8)
        } else {
            let v5 = db_buy_base<T2, T0>(arg3, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v6 = cetus_buy_a<T1, T2>(arg0, arg2, v5, arg7);
            cetus_buy_a<T0, T1>(arg0, arg1, v6, arg7)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg5 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg5), arg8), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg8);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg3),
            forward  : arg4,
            size_s   : arg5,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_db_bf_db<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T0>(arg0, arg5, arg8);
        let v2 = if (arg4) {
            let v3 = db_buy_base<T1, T0>(arg0, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v4 = bluefin_buy_a<T2, T1>(arg1, arg2, v3, arg7);
            db_sell_base<T2, T0>(arg3, v4, arg7, arg8)
        } else {
            let v5 = db_buy_base<T2, T0>(arg3, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v6 = bluefin_sell_a<T2, T1>(arg1, arg2, v5, arg7);
            db_sell_base<T1, T0>(arg0, v6, arg7, arg8)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg5 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg5), arg8), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg8);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg0),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg2),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg3),
            forward  : arg4,
            size_s   : arg5,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_db_bf_db_b<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg3, arg5, arg8);
        let v2 = if (arg4) {
            let v3 = db_sell_base<T0, T1>(arg0, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v4 = bluefin_buy_a<T2, T1>(arg1, arg2, v3, arg7);
            db_sell_base<T2, T0>(arg3, v4, arg7, arg8)
        } else {
            let v5 = db_buy_base<T2, T0>(arg3, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v6 = bluefin_sell_a<T2, T1>(arg1, arg2, v5, arg7);
            db_buy_base<T0, T1>(arg0, v6, arg7, arg8)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg5 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg5), arg8), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg8);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg2),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg3),
            forward  : arg4,
            size_s   : arg5,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_db_bf_db_bb<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg5, arg8);
        let v2 = if (arg4) {
            let v3 = db_sell_base<T0, T1>(arg0, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v4 = bluefin_buy_a<T2, T1>(arg1, arg2, v3, arg7);
            db_buy_base<T0, T2>(arg3, v4, arg7, arg8)
        } else {
            let v5 = db_sell_base<T0, T2>(arg3, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v6 = bluefin_sell_a<T2, T1>(arg1, arg2, v5, arg7);
            db_buy_base<T0, T1>(arg0, v6, arg7, arg8)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg5 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg5), arg8), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg8);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg2),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>>(arg3),
            forward  : arg4,
            size_s   : arg5,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_db_cetus_db<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T0>(arg0, arg5, arg8);
        let v2 = if (arg4) {
            let v3 = db_buy_base<T1, T0>(arg0, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v4 = cetus_sell_a<T1, T2>(arg1, arg2, v3, arg7);
            db_sell_base<T2, T0>(arg3, v4, arg7, arg8)
        } else {
            let v5 = db_buy_base<T2, T0>(arg3, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v6 = cetus_buy_a<T1, T2>(arg1, arg2, v5, arg7);
            db_sell_base<T1, T0>(arg0, v6, arg7, arg8)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg5 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg5), arg8), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg8);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg0),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg3),
            forward  : arg4,
            size_s   : arg5,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_db_cetus_db_bb<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg5, arg8);
        let v2 = if (arg4) {
            let v3 = db_sell_base<T0, T1>(arg0, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v4 = cetus_sell_a<T1, T2>(arg1, arg2, v3, arg7);
            db_buy_base<T0, T2>(arg3, v4, arg7, arg8)
        } else {
            let v5 = db_sell_base<T0, T2>(arg3, 0x2::coin::into_balance<T0>(v0), arg7, arg8);
            let v6 = cetus_buy_a<T1, T2>(arg1, arg2, v5, arg7);
            db_buy_base<T0, T1>(arg0, v6, arg7, arg8)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg5 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg5), arg8), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg8);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>>(arg3),
            forward  : arg4,
            size_s   : arg5,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_db_cetus_pqf<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg6: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T2, T0>, arg7: bool, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 == 0) {
            return 0
        };
        if (!pqf_side_fresh<T2, T0>(arg6, arg7, arg10)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T0>(arg0, arg8, arg11);
        let v2 = if (arg7) {
            let v3 = db_buy_base<T1, T0>(arg0, 0x2::coin::into_balance<T0>(v0), arg10, arg11);
            let v4 = cetus_buy_a<T2, T1>(arg1, arg2, v3, arg10);
            pqf_sell_base<T2, T0>(arg3, arg4, arg5, arg6, v4, arg10, arg11)
        } else {
            let v5 = pqf_buy_base<T2, T0>(arg3, arg4, arg5, arg6, 0x2::coin::into_balance<T0>(v0), arg10, arg11);
            let v6 = cetus_sell_a<T2, T1>(arg1, arg2, v5, arg10);
            db_sell_base<T1, T0>(arg0, v6, arg10, arg11)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg8 + arg9, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg8), arg11), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg11);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg0),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg2),
            pool_3   : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T2, T0>>(arg6),
            forward  : arg7,
            size_s   : arg8,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_db_fullsail_bf<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg9 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T0>(arg0, arg9, arg12);
        let v2 = if (arg8) {
            let v3 = db_buy_base<T1, T0>(arg0, 0x2::coin::into_balance<T0>(v0), arg11, arg12);
            let v4 = fullsail_sell_a<T1, T2>(arg1, arg2, arg3, arg4, arg5, v3, arg11);
            bluefin_sell_a<T2, T0>(arg6, arg7, v4, arg11)
        } else {
            let v5 = bluefin_buy_a<T2, T0>(arg6, arg7, 0x2::coin::into_balance<T0>(v0), arg11);
            let v6 = fullsail_buy_a<T1, T2>(arg1, arg2, arg3, arg4, arg5, v5, arg11);
            db_sell_base<T1, T0>(arg0, v6, arg11, arg12)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg9 + arg10, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg9), arg12), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg12);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg0),
            pool_2   : 0x2::object::id_address<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>>(arg3),
            pool_3   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg7),
            forward  : arg8,
            size_s   : arg9,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_tb_bf_db<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T3>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg4, arg6, arg9);
        let v2 = if (arg5) {
            let v3 = turbos_sell_second<T1, T0, T3>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
            let v4 = bluefin_buy_a<T2, T1>(arg2, arg3, v3, arg8);
            db_sell_base<T2, T0>(arg4, v4, arg8, arg9)
        } else {
            let v5 = db_buy_base<T2, T0>(arg4, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
            let v6 = bluefin_sell_a<T2, T1>(arg2, arg3, v5, arg8);
            turbos_buy_second<T1, T0, T3>(arg0, arg1, v6, arg8, arg9)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T3>>(arg0),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg4),
            forward  : arg5,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_tb_bf_db_b<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg4, arg6, arg9);
        let v2 = if (arg5) {
            let v3 = turbos_buy_second<T0, T1, T3>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
            let v4 = bluefin_buy_a<T2, T1>(arg2, arg3, v3, arg8);
            db_sell_base<T2, T0>(arg4, v4, arg8, arg9)
        } else {
            let v5 = db_buy_base<T2, T0>(arg4, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
            let v6 = bluefin_sell_a<T2, T1>(arg2, arg3, v5, arg8);
            turbos_sell_second<T0, T1, T3>(arg0, arg1, v6, arg8, arg9)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>>(arg0),
            pool_2   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg3),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg4),
            forward  : arg5,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_tb_cetus_db<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T3>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg6 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg4, arg6, arg9);
        let v2 = if (arg5) {
            let v3 = turbos_sell_second<T1, T0, T3>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
            let v4 = cetus_sell_a<T1, T2>(arg2, arg3, v3, arg8);
            db_sell_base<T2, T0>(arg4, v4, arg8, arg9)
        } else {
            let v5 = db_buy_base<T2, T0>(arg4, 0x2::coin::into_balance<T0>(v0), arg8, arg9);
            let v6 = cetus_buy_a<T1, T2>(arg2, arg3, v5, arg8);
            turbos_buy_second<T1, T0, T3>(arg0, arg1, v6, arg8, arg9)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg6 + arg7, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg6), arg9), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg9);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T3>>(arg0),
            pool_2   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg4),
            forward  : arg5,
            size_s   : arg6,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_tri_tb_fullsail_db<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T3>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg6: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg9 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg7, arg9, arg12);
        let v2 = if (arg8) {
            let v3 = turbos_sell_second<T1, T0, T3>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), arg11, arg12);
            let v4 = fullsail_sell_a<T1, T2>(arg2, arg3, arg4, arg5, arg6, v3, arg11);
            db_sell_base<T2, T0>(arg7, v4, arg11, arg12)
        } else {
            let v5 = db_buy_base<T2, T0>(arg7, 0x2::coin::into_balance<T0>(v0), arg11, arg12);
            let v6 = fullsail_buy_a<T1, T2>(arg2, arg3, arg4, arg5, arg6, v5, arg11);
            turbos_buy_second<T1, T0, T3>(arg0, arg1, v6, arg11, arg12)
        };
        let v7 = v2;
        assert!(0x2::balance::value<T0>(&v7) >= arg9 + arg10, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg7, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, arg9), arg12), v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        payout<T0>(v7, arg12);
        let v9 = FiredTri{
            pool_1   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T3>>(arg0),
            pool_2   : 0x2::object::id_address<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>>(arg4),
            pool_3   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg7),
            forward  : arg8,
            size_s   : arg9,
            profit_b : v8,
        };
        0x2::event::emit<FiredTri>(v9);
        v8
    }

    public fun run_turbos_aftermath_flash<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>, arg3: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg4: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg5: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg6: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg7: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg9 == 0) {
            return 0
        };
        let v0 = if (arg8) {
            let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg9 as u128), true, 79226673515401279992447579054, arg11, arg1, arg12);
            0x2::coin::destroy_zero<T1>(v2);
            let v4 = af_swap_exact<T3, T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::into_balance<T0>(v1), arg12);
            assert!(0x2::balance::value<T1>(&v4) >= arg9 + arg10, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg12), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, arg9), arg12), v3, arg1);
            payout<T1>(v4, arg12);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg9 as u128), true, 4295048017, arg11, arg1, arg12);
            0x2::coin::destroy_zero<T0>(v5);
            let v8 = af_swap_exact<T3, T1, T0>(arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::into_balance<T1>(v6), arg12);
            assert!(0x2::balance::value<T0>(&v8) >= arg9 + arg10, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, arg9), arg12), 0x2::coin::zero<T1>(arg12), v7, arg1);
            payout<T0>(v8, arg12);
            0x2::balance::value<T0>(&v8)
        };
        let v9 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>>(arg2),
            buy_on_cetus : arg8,
            spread_bps   : 0,
            size_b       : arg9,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v9);
        v0
    }

    public fun run_turbos_bluefin_flash<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let v2 = spread_bps(v0, v1);
        if (v2 < arg6 || v1 == 0) {
            return 0
        };
        if (v0 < v1 != arg4 && v2 > 100) {
            return 0
        };
        let v3 = if (arg4) {
            let (v4, v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg5 as u128), true, 79226673515401279992447579054, arg8, arg1, arg9);
            0x2::coin::destroy_zero<T1>(v5);
            let v7 = bluefin_sell_a<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(v4), arg8);
            assert!(0x2::balance::value<T1>(&v7) >= arg5 + arg7, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg9), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v7, arg5), arg9), v6, arg1);
            payout<T1>(v7, arg9);
            0x2::balance::value<T1>(&v7)
        } else {
            let (v8, v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg5 as u128), true, 4295048017, arg8, arg1, arg9);
            0x2::coin::destroy_zero<T0>(v8);
            let v11 = bluefin_buy_a<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T1>(v9), arg8);
            assert!(0x2::balance::value<T0>(&v11) >= arg5 + arg7, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v11, arg5), arg9), 0x2::coin::zero<T1>(arg9), v10, arg1);
            payout<T0>(v11, arg9);
            0x2::balance::value<T0>(&v11)
        };
        let v12 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : arg4,
            spread_bps   : v2,
            size_b       : arg5,
            profit_b     : v3,
        };
        0x2::event::emit<FiredFlash>(v12);
        v3
    }

    public fun run_turbos_bolt_flash<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = if (arg4) {
            let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg5 as u128), true, 79226673515401279992447579054, arg7, arg1, arg8);
            0x2::coin::destroy_zero<T1>(v2);
            let (v4, v5) = bolt_sell_base<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(v1), arg7, arg8);
            let v6 = v4;
            let v7 = &mut v6;
            turbos_sell_x_into<T0, T1, T2>(arg0, arg1, v5, v7, arg7, arg8);
            assert!(0x2::balance::value<T1>(&v6) >= arg5 + arg6, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v6, arg5), arg8), v3, arg1);
            payout<T1>(v6, arg8);
            0x2::balance::value<T1>(&v6)
        } else {
            let (v8, v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg5 as u128), true, 4295048017, arg7, arg1, arg8);
            0x2::coin::destroy_zero<T0>(v8);
            let (v11, v12) = bolt_buy_base<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T1>(v9), arg7, arg8);
            let v13 = v11;
            let v14 = &mut v13;
            turbos_sell_y_into<T0, T1, T2>(arg0, arg1, v12, v14, arg7, arg8);
            assert!(0x2::balance::value<T0>(&v13) >= arg5 + arg6, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v13, arg5), arg8), 0x2::coin::zero<T1>(arg8), v10, arg1);
            payout<T0>(v13, arg8);
            0x2::balance::value<T0>(&v13)
        };
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg2),
            buy_on_cetus : arg4,
            spread_bps   : 0,
            size_b       : arg5,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v15);
        v0
    }

    public fun run_turbos_bolt_flash_flip<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = if (arg4) {
            let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg5 as u128), true, 79226673515401279992447579054, arg7, arg1, arg8);
            0x2::coin::destroy_zero<T1>(v2);
            let (v4, v5) = bolt_buy_base<T1, T0>(arg2, arg3, 0x2::coin::into_balance<T0>(v1), arg7, arg8);
            let v6 = v4;
            let v7 = &mut v6;
            turbos_sell_x_into<T0, T1, T2>(arg0, arg1, v5, v7, arg7, arg8);
            assert!(0x2::balance::value<T1>(&v6) >= arg5 + arg6, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v6, arg5), arg8), v3, arg1);
            payout<T1>(v6, arg8);
            0x2::balance::value<T1>(&v6)
        } else {
            let (v8, v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg5 as u128), true, 4295048017, arg7, arg1, arg8);
            0x2::coin::destroy_zero<T0>(v8);
            let (v11, v12) = bolt_sell_base<T1, T0>(arg2, arg3, 0x2::coin::into_balance<T1>(v9), arg7, arg8);
            let v13 = v11;
            let v14 = &mut v13;
            turbos_sell_y_into<T0, T1, T2>(arg0, arg1, v12, v14, arg7, arg8);
            assert!(0x2::balance::value<T0>(&v13) >= arg5 + arg6, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v13, arg5), arg8), 0x2::coin::zero<T1>(arg8), v10, arg1);
            payout<T0>(v13, arg8);
            0x2::balance::value<T0>(&v13)
        };
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg2),
            buy_on_cetus : arg4,
            spread_bps   : 0,
            size_b       : arg5,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v15);
        v0
    }

    public fun run_turbos_dae28_flash<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg3: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = if (arg4) {
            let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg5 as u128), true, 79226673515401279992447579054, arg7, arg1, arg8);
            0x2::coin::destroy_zero<T1>(v2);
            let v4 = dae28_sell_x<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(v1), arg8);
            assert!(0x2::balance::value<T1>(&v4) >= arg5 + arg6, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, arg5), arg8), v3, arg1);
            payout<T1>(v4, arg8);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg5 as u128), true, 4295048017, arg7, arg1, arg8);
            0x2::coin::destroy_zero<T0>(v5);
            let v8 = dae28_sell_y<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T1>(v6), arg8);
            assert!(0x2::balance::value<T0>(&v8) >= arg5 + arg6, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, arg5), arg8), 0x2::coin::zero<T1>(arg8), v7, arg1);
            payout<T0>(v8, arg8);
            0x2::balance::value<T0>(&v8)
        };
        let v9 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg3),
            buy_on_cetus : arg4,
            spread_bps   : 0,
            size_b       : arg5,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v9);
        v0
    }

    public fun run_turbos_deepbook_flash<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg2, arg7) as u128);
        let v3 = price_spread_bps(v1, v2);
        if (v3 < arg5 || v2 == 0) {
            return 0
        };
        if (v1 < v2 != arg3 && v3 > 100) {
            return 0
        };
        let v4 = if (arg3) {
            let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg4 as u128), true, 79226673515401279992447579054, arg7, arg1, arg8);
            0x2::coin::destroy_zero<T1>(v6);
            let v8 = db_sell_base<T0, T1>(arg2, 0x2::coin::into_balance<T0>(v5), arg7, arg8);
            assert!(0x2::balance::value<T1>(&v8) >= arg4 + arg6, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v8, arg4), arg8), v7, arg1);
            payout<T1>(v8, arg8);
            0x2::balance::value<T1>(&v8)
        } else {
            let (v9, v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg4 as u128), true, 4295048017, arg7, arg1, arg8);
            0x2::coin::destroy_zero<T0>(v9);
            let v12 = db_buy_base<T0, T1>(arg2, 0x2::coin::into_balance<T1>(v10), arg7, arg8);
            assert!(0x2::balance::value<T0>(&v12) >= arg4 + arg6, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, arg4), arg8), 0x2::coin::zero<T1>(arg8), v11, arg1);
            payout<T0>(v12, arg8);
            0x2::balance::value<T0>(&v12)
        };
        let v13 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : arg3,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v4,
        };
        0x2::event::emit<FiredFlash>(v13);
        v4
    }

    public fun run_turbos_pqf_flash<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        let v0 = if (arg6) {
            if (!pqf_side_fresh<T0, T1>(arg5, true, arg9)) {
                return 0
            };
            let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg7 as u128), true, 79226673515401279992447579054, arg9, arg1, arg10);
            0x2::coin::destroy_zero<T1>(v2);
            let v4 = pqf_sell_base<T0, T1>(arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T0>(v1), arg9, arg10);
            assert!(0x2::balance::value<T1>(&v4) >= arg7 + arg8, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg10), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, arg7), arg10), v3, arg1);
            payout<T1>(v4, arg10);
            0x2::balance::value<T1>(&v4)
        } else {
            if (!pqf_side_fresh<T0, T1>(arg5, false, arg9)) {
                return 0
            };
            let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg7 as u128), true, 4295048017, arg9, arg1, arg10);
            0x2::coin::destroy_zero<T0>(v5);
            let v8 = pqf_buy_base<T0, T1>(arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T1>(v6), arg9, arg10);
            assert!(0x2::balance::value<T0>(&v8) >= arg7 + arg8, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, arg7), arg10), 0x2::coin::zero<T1>(arg10), v7, arg1);
            payout<T0>(v8, arg10);
            0x2::balance::value<T0>(&v8)
        };
        let v9 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg5),
            buy_on_cetus : arg6,
            spread_bps   : 0,
            size_b       : arg7,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v9);
        v0
    }

    public fun run_turbos_pqf_flash_env<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg6: bool, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        pqf1_push<T0, T1>(arg2, arg3, arg4, arg5, arg9, arg10, arg11, arg12);
        run_turbos_pqf_flash<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12)
    }

    public fun run_turbos_pqf_v2_flash<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg10 == 0) {
            return 0
        };
        pqf2_push<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13);
        let v0 = if (arg9) {
            if (!pqf2_side_fresh<T0, T1>(arg5, true, arg12)) {
                return 0
            };
            let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg10 as u128), true, 79226673515401279992447579054, arg12, arg1, arg13);
            0x2::coin::destroy_zero<T1>(v2);
            let (v4, v5) = pqf2_sell_base_chunked<T0, T1>(arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T0>(v1), arg8, arg12, arg13);
            let v6 = v5;
            let v7 = v4;
            assert!(0x2::balance::value<T0>(&v6) == 0, 911);
            0x2::balance::destroy_zero<T0>(v6);
            assert!(0x2::balance::value<T1>(&v7) >= arg10 + arg11, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg13), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v7, arg10), arg13), v3, arg1);
            payout<T1>(v7, arg13);
            0x2::balance::value<T1>(&v7)
        } else {
            if (!pqf2_side_fresh<T0, T1>(arg5, false, arg12)) {
                return 0
            };
            let (v8, v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg10 as u128), true, 4295048017, arg12, arg1, arg13);
            0x2::coin::destroy_zero<T0>(v8);
            let (v11, v12) = pqf2_buy_base_chunked<T0, T1>(arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T1>(v9), arg8, arg12, arg13);
            let v13 = v12;
            let v14 = v11;
            assert!(0x2::balance::value<T1>(&v13) == 0, 911);
            0x2::balance::destroy_zero<T1>(v13);
            assert!(0x2::balance::value<T0>(&v14) >= arg10 + arg11, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v14, arg10), arg13), 0x2::coin::zero<T1>(arg13), v10, arg1);
            payout<T0>(v14, arg13);
            0x2::balance::value<T0>(&v14)
        };
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>>(arg5),
            buy_on_cetus : arg9,
            spread_bps   : 0,
            size_b       : arg10,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v15);
        v0
    }

    public fun run_turbos_turbos_flash<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = if (arg3) {
            let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg4 as u128), true, 79226673515401279992447579054, arg6, arg2, arg7);
            0x2::coin::destroy_zero<T1>(v2);
            let v4 = turbos_buy_second<T0, T1, T3>(arg1, arg2, 0x2::coin::into_balance<T0>(v1), arg6, arg7);
            assert!(0x2::balance::value<T1>(&v4) >= arg4 + arg5, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg7), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, arg4), arg7), v3, arg2);
            payout<T1>(v4, arg7);
            0x2::balance::value<T1>(&v4)
        } else {
            let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg4 as u128), true, 4295048017, arg6, arg2, arg7);
            0x2::coin::destroy_zero<T0>(v5);
            let v8 = turbos_sell_second<T0, T1, T3>(arg1, arg2, 0x2::coin::into_balance<T1>(v6), arg6, arg7);
            assert!(0x2::balance::value<T0>(&v8) >= arg4 + arg5, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, arg4), arg7), 0x2::coin::zero<T1>(arg7), v7, arg2);
            payout<T0>(v8, arg7);
            0x2::balance::value<T0>(&v8)
        };
        let v9 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>>(arg1),
            buy_on_cetus : arg3,
            spread_bps   : 0,
            size_b       : arg4,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v9);
        v0
    }

    fun split_over_cap<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 > arg1) {
            0x2::balance::split<T0>(arg0, v0 - arg1)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    fun spread_bps(arg0: u128, arg1: u128) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = arg0 / 2 + arg1 / 2;
        if (v1 == 0) {
            return 0
        };
        ((v0 * 20000 / v1) as u64)
    }

    fun turbos_buy_second<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T0>(arg2, arg4);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (0x2::coin::value<T0>(&v0) as u128), true, 4295048017, arg3, arg1, arg4);
        0x2::coin::destroy_zero<T0>(v1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v0, 0x2::coin::zero<T1>(arg4), v3, arg1);
        0x2::coin::into_balance<T1>(v2)
    }

    fun turbos_sell_second<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::from_balance<T1>(arg2, arg4);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (0x2::coin::value<T1>(&v0) as u128), true, 79226673515401279992447579054, arg3, arg1, arg4);
        0x2::coin::destroy_zero<T1>(v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg4), v0, v3, arg1);
        0x2::coin::into_balance<T0>(v1)
    }

    fun turbos_sell_x_into<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        0x2::balance::join<T1>(arg3, turbos_buy_second<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5));
    }

    fun turbos_sell_y_into<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return
        };
        0x2::balance::join<T0>(arg3, turbos_sell_second<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5));
    }

    // decompiled from Move bytecode v7
}

