module 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::bolt_unwind {
    public fun bluefin_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            return (0x2::coin::zero<T1>(arg4), arg2)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::bluefin_start_a2b<T0, T1>(arg0, arg1, v0, arg3, arg4);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::bluefin_finish_a2b<T0, T1>(arg0, arg1, arg2, v2, 0, arg4))
    }

    public fun bluefin_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        if (v0 == 0) {
            return (0x2::coin::zero<T0>(arg4), arg2)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::bluefin_start_b2a<T0, T1>(arg0, arg1, v0, arg3, arg4);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::bluefin_finish_b2a<T0, T1>(arg0, arg1, arg2, v2, 0, arg4))
    }

    public fun cetus_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            return (0x2::coin::zero<T1>(arg4), arg2)
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 4295048016, arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg4)), 0x2::balance::zero<T1>(), v4);
        (0x2::coin::from_balance<T1>(v2, arg4), arg2)
    }

    public fun cetus_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        if (v0 == 0) {
            return (0x2::coin::zero<T0>(arg4), arg2)
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 79226673515401279992447579055, arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg4)), v4);
        (0x2::coin::from_balance<T0>(v1, arg4), arg2)
    }

    public fun deepbook_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            return (0x2::coin::zero<T1>(arg3), arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3))
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        (v1, v0, v2)
    }

    public fun deepbook_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        if (0x2::coin::value<T1>(&arg1) == 0) {
            return (0x2::coin::zero<T0>(arg3), arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3))
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3)
    }

    public fun dlmm_a2b<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            return (0x2::coin::zero<T1>(arg5), arg1)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::dlmm_start_a2b<T0, T1>(arg0, v0, arg2, arg3, arg4, arg5);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::dlmm_finish_a2b<T0, T1>(arg0, arg1, v2, 0, arg3, arg5))
    }

    public fun dlmm_b2a<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        if (v0 == 0) {
            return (0x2::coin::zero<T0>(arg5), arg1)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::dlmm_start_b2a<T0, T1>(arg0, v0, arg2, arg3, arg4, arg5);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::dlmm_finish_b2a<T0, T1>(arg0, arg1, v2, 0, arg3, arg5))
    }

    public fun ferra_a2b<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            return (0x2::coin::zero<T1>(arg4), arg2)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::ferra_start_a2b<T0, T1>(arg0, arg1, v0, arg3, arg4);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::ferra_finish_a2b<T0, T1>(arg0, arg1, arg2, v2, 0, arg4))
    }

    public fun ferra_b2a<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        if (v0 == 0) {
            return (0x2::coin::zero<T0>(arg4), arg2)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::ferra_start_b2a<T0, T1>(arg0, arg1, v0, arg3, arg4);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::ferra_finish_b2a<T0, T1>(arg0, arg1, arg2, v2, 0, arg4))
    }

    public fun fullsail_a2b<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        if (v0 == 0) {
            return (0x2::coin::zero<T1>(arg7), arg3)
        };
        let (v1, v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, v0, 4295048016, arg4, arg5, arg6);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v4), arg7)), 0x2::balance::zero<T1>(), v4);
        (0x2::coin::from_balance<T1>(v2, arg7), arg3)
    }

    public fun fullsail_b2a<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg3);
        if (v0 == 0) {
            return (0x2::coin::zero<T0>(arg7), arg3)
        };
        let (v1, v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, v0, 79226673515401279992447579055, arg4, arg5, arg6);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v4), arg7)), v4);
        (0x2::coin::from_balance<T0>(v1, arg7), arg3)
    }

    public fun magma_a2b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            return (0x2::coin::zero<T1>(arg4), arg2)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::magma_start_a2b<T0, T1>(arg0, arg1, v0, arg3, arg4);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::magma_finish_a2b<T0, T1>(arg0, arg1, arg2, v2, 0, arg4))
    }

    public fun magma_b2a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        if (v0 == 0) {
            return (0x2::coin::zero<T0>(arg4), arg2)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::magma_start_b2a<T0, T1>(arg0, arg1, v0, arg3, arg4);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::magma_finish_b2a<T0, T1>(arg0, arg1, arg2, v2, 0, arg4))
    }

    public fun momentum_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            return (0x2::coin::zero<T1>(arg4), arg1)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::momentum_start_a2b<T0, T1>(arg0, v0, arg2, arg3, arg4);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::momentum_finish_a2b<T0, T1>(arg0, arg1, v2, 0, arg3, arg4))
    }

    public fun momentum_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        if (v0 == 0) {
            return (0x2::coin::zero<T0>(arg4), arg1)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::momentum_start_b2a<T0, T1>(arg0, v0, arg2, arg3, arg4);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::momentum_finish_b2a<T0, T1>(arg0, arg1, v2, 0, arg3, arg4))
    }

    public fun suidex_a2b<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg2: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg3) == 0) {
            return (0x2::coin::zero<T1>(arg5), arg3)
        };
        (0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens0_for_tokens1_composable<T0, T1>(arg0, arg1, arg2, arg3, 0, arg4, arg5), 0x2::coin::zero<T0>(arg5))
    }

    public fun suidex_b2a<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg2: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T1>(&arg3) == 0) {
            return (0x2::coin::zero<T0>(arg5), arg3)
        };
        (0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens1_for_tokens0_composable<T0, T1>(arg0, arg1, arg2, arg3, 0, arg4, arg5), 0x2::coin::zero<T1>(arg5))
    }

    public fun suidex_v3_a2b<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            return (0x2::coin::zero<T1>(arg4), arg1)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::suidex_v3_start_a2b<T0, T1>(arg0, v0, arg2, arg3, arg4);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::suidex_v3_finish_a2b<T0, T1>(arg0, arg1, v2, 0, arg3, arg4))
    }

    public fun suidex_v3_b2a<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        if (v0 == 0) {
            return (0x2::coin::zero<T0>(arg4), arg1)
        };
        let (v1, v2) = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::suidex_v3_start_b2a<T0, T1>(arg0, v0, arg2, arg3, arg4);
        (v1, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::lend::suidex_v3_finish_b2a<T0, T1>(arg0, arg1, v2, 0, arg3, arg4))
    }

    public fun tide_a2b<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        if (v0 == 0) {
            return (0x2::coin::zero<T1>(arg8), arg4)
        };
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        let v1 = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::tide::live_hash<T0, T1>(arg3, true);
        let v2 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v2, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(v1, v0));
        let (v3, v4) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, v2, 0x2::coin::into_balance<T0>(arg4), v1, arg7, arg8);
        (0x2::coin::from_balance<T1>(v3, arg8), 0x2::coin::from_balance<T0>(v4, arg8))
    }

    public fun tide_b2a<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg4);
        if (v0 == 0) {
            return (0x2::coin::zero<T0>(arg8), arg4)
        };
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        let v1 = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::tide::live_hash<T0, T1>(arg3, false);
        let v2 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v2, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(v1, v0));
        let (v3, v4) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, v2, 0x2::coin::into_balance<T1>(arg4), v1, arg7, arg8);
        (0x2::coin::from_balance<T0>(v3, arg8), 0x2::coin::from_balance<T1>(v4, arg8))
    }

    public fun turbos_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            return (0x2::coin::zero<T1>(arg4), arg1)
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), true, (v0 as u128), true, 4295048017, arg2, arg3, arg4);
        let v4 = v3;
        0x2::coin::destroy_zero<T0>(v1);
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::split<T0>(&mut arg1, v7, arg4), 0x2::coin::zero<T1>(arg4), v4, arg3);
        (v2, arg1)
    }

    public fun turbos_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        if (v0 == 0) {
            return (0x2::coin::zero<T0>(arg4), arg1)
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), false, (v0 as u128), true, 79226673515401279992447579054, arg2, arg3, arg4);
        let v4 = v3;
        0x2::coin::destroy_zero<T1>(v2);
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg4), 0x2::coin::split<T1>(&mut arg1, v7, arg4), v4, arg3);
        (v1, arg1)
    }

    // decompiled from Move bytecode v7
}

