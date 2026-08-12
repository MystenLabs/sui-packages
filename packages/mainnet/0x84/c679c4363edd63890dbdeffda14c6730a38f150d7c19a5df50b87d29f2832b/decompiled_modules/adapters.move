module 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::adapters {
    fun flush_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    fun flush_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun leg_bluefin_ab<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T0>(&arg0, arg1, b"bluefin", v0);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::route_swap<T0, T1>(arg5, arg2, arg3, arg4, 0x2::coin::zero<T1>(arg6), true, true, false, v0, 1, 4295048017, arg6);
        let v3 = v2;
        flush_coin<T0>(v1, 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0));
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"bluefin", 0x2::coin::value<T1>(&v3));
        (arg0, v3)
    }

    public fun leg_bluefin_ba<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T1>(&arg0, arg1, b"bluefin", v0);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::route_swap<T0, T1>(arg5, arg2, arg3, 0x2::coin::zero<T0>(arg6), arg4, false, true, false, v0, 1, 79226673515401279992447579054, arg6);
        let v3 = v1;
        flush_coin<T1>(v2, 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0));
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T0>(&mut arg0, b"bluefin", 0x2::coin::value<T0>(&v3));
        (arg0, v3)
    }

    public fun leg_cetus_ab<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T0>(&arg0, arg1, b"cetus", v0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, true, true, v0, 4295048017, arg5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::balance::zero<T1>(), v3);
        flush_balance<T0>(v1, 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0), arg6);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg6);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"cetus", 0x2::coin::value<T1>(&v4));
        (arg0, v4)
    }

    public fun leg_cetus_ba<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T1>(&arg0, arg1, b"cetus", v0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, false, true, v0, 79226673515401279992447579054, arg5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg4), v3);
        flush_balance<T1>(v2, 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0), arg6);
        let v4 = 0x2::coin::from_balance<T0>(v1, arg6);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T0>(&mut arg0, b"cetus", 0x2::coin::value<T0>(&v4));
        (arg0, v4)
    }

    public fun leg_ferra_xy<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg3: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T0>(&arg0, arg1, b"ferra-dlmm", 0x2::coin::value<T0>(&arg4));
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg2, arg3, true, 1, arg4, 0x2::coin::zero<T1>(arg6), arg5, arg6);
        let v2 = v1;
        flush_coin<T0>(v0, 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0));
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"ferra-dlmm", 0x2::coin::value<T1>(&v2));
        (arg0, v2)
    }

    public fun leg_ferra_yx<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg3: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T0>) {
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T1>(&arg0, arg1, b"ferra-dlmm", 0x2::coin::value<T1>(&arg4));
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg2, arg3, false, 1, 0x2::coin::zero<T0>(arg6), arg4, arg5, arg6);
        let v2 = v0;
        flush_coin<T1>(v1, 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0));
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T0>(&mut arg0, b"ferra-dlmm", 0x2::coin::value<T0>(&v2));
        (arg0, v2)
    }

    public fun leg_flowx_amm<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T0>(&arg0, arg1, b"flow-x", 0x2::coin::value<T0>(&arg3));
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg2, arg3, arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"flow-x", 0x2::coin::value<T1>(&v0));
        (arg0, v0)
    }

    public fun leg_flowx_clmm<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: u64, arg5: bool, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T0>(&arg0, arg1, b"flowx-clmm", 0x2::coin::value<T0>(&arg6));
        let v0 = if (arg5) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg2, arg4, arg6, 1, v0, 0x2::clock::timestamp_ms(arg7) + 3600000, arg3, arg7, arg8);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"flowx-clmm", 0x2::coin::value<T1>(&v1));
        (arg0, v1)
    }

    public fun leg_fullsail_ab<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg6: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg7);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T0>(&arg0, arg1, b"fullsail-finance", v0);
        let (v1, v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg2, arg3, arg4, true, true, v0, 4295048017, arg5, arg6, arg8);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg2, arg4, 0x2::coin::into_balance<T0>(arg7), 0x2::balance::zero<T1>(), v3);
        flush_balance<T0>(v1, 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0), arg9);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg9);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"fullsail-finance", 0x2::coin::value<T1>(&v4));
        (arg0, v4)
    }

    public fun leg_fullsail_ba<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg6: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg7);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T1>(&arg0, arg1, b"fullsail-finance", v0);
        let (v1, v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg2, arg3, arg4, false, true, v0, 79226673515401279992447579054, arg5, arg6, arg8);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg2, arg4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg7), v3);
        flush_balance<T1>(v2, 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0), arg9);
        let v4 = 0x2::coin::from_balance<T0>(v1, arg9);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T0>(&mut arg0, b"fullsail-finance", 0x2::coin::value<T0>(&v4));
        (arg0, v4)
    }

    public fun leg_kriya_xy<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T0>(&arg0, arg1, b"kriya-dex", v0);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg2, arg3, v0, 1, arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"kriya-dex", 0x2::coin::value<T1>(&v1));
        (arg0, v1)
    }

    public fun leg_kriya_yx<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg3);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T1>(&arg0, arg1, b"kriya-dex", v0);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg2, arg3, v0, 1, arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T0>(&mut arg0, b"kriya-dex", 0x2::coin::value<T0>(&v1));
        (arg0, v1)
    }

    public fun leg_momentum_ab<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T0>(&arg0, arg1, b"momentum", v0);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, true, true, v0, 4295048017, arg5, arg3, arg6);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v3, 0x2::coin::into_balance<T0>(arg4), 0x2::balance::zero<T1>(), arg3, arg6);
        flush_balance<T0>(v1, 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0), arg6);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg6);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"momentum", 0x2::coin::value<T1>(&v4));
        (arg0, v4)
    }

    public fun leg_momentum_ba<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T1>(&arg0, arg1, b"momentum", v0);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, true, v0, 79226673515401279992447579054, arg5, arg3, arg6);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg4), arg3, arg6);
        flush_balance<T1>(v2, 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0), arg6);
        let v4 = 0x2::coin::from_balance<T0>(v1, arg6);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T0>(&mut arg0, b"momentum", 0x2::coin::value<T0>(&v4));
        (arg0, v4)
    }

    public fun leg_steamm_ab<T0, T1, T2, T3, T4, T5: drop>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T2>) {
        let v0 = 0x2::coin::value<T1>(&arg6);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T1>(&arg0, arg1, b"steamm", v0);
        let v1 = 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0);
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T1, T3>(arg2, arg4, &mut arg6, v0, arg7, arg8);
        flush_coin<T1>(arg6, v1);
        let v3 = 0x2::coin::zero<T4>(arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg5, &mut v2, &mut v3, true, 0x2::coin::value<T3>(&v2), 1, arg8);
        flush_coin<T3>(v2, v1);
        let v4 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T2, T4>(arg3, arg4, &mut v3, 0x2::coin::value<T4>(&v3), arg7, arg8);
        flush_coin<T4>(v3, v1);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T2>(&mut arg0, b"steamm", 0x2::coin::value<T2>(&v4));
        (arg0, v4)
    }

    public fun leg_steamm_ba<T0, T1, T2, T3, T4, T5: drop>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg6: 0x2::coin::Coin<T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T2>(&arg6);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T2>(&arg0, arg1, b"steamm", v0);
        let v1 = 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0);
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T2, T4>(arg3, arg4, &mut arg6, v0, arg7, arg8);
        flush_coin<T2>(arg6, v1);
        let v3 = 0x2::coin::zero<T3>(arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg5, &mut v3, &mut v2, false, 0x2::coin::value<T4>(&v2), 1, arg8);
        flush_coin<T4>(v2, v1);
        let v4 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T1, T3>(arg2, arg4, &mut v3, 0x2::coin::value<T3>(&v3), arg7, arg8);
        flush_coin<T3>(v3, v1);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"steamm", 0x2::coin::value<T1>(&v4));
        (arg0, v4)
    }

    public fun leg_suidex_01<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg3: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg4: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T0>(&arg0, arg1, b"suidex", 0x2::coin::value<T0>(&arg5));
        let v0 = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens0_for_tokens1_composable<T0, T1>(arg2, arg3, arg4, arg5, (1 as u256), arg6, arg7);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"suidex", 0x2::coin::value<T1>(&v0));
        (arg0, v0)
    }

    public fun leg_suidex_10<T0, T1>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg3: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg4: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T0>) {
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T1>(&arg0, arg1, b"suidex", 0x2::coin::value<T1>(&arg5));
        let v0 = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens1_for_tokens0_composable<T0, T1>(arg2, arg3, arg4, arg5, (1 as u256), arg6, arg7);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T0>(&mut arg0, b"suidex", 0x2::coin::value<T0>(&v0));
        (arg0, v0)
    }

    public fun leg_turbos_ab<T0, T1, T2>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T0>(&arg0, arg1, b"turbos-finance", v0);
        let v1 = 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, arg4);
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, v2, v0, 1, 4295048017, true, v1, 0x2::clock::timestamp_ms(arg5) + 3600000, arg5, arg3, arg6);
        let v5 = v3;
        flush_coin<T0>(v4, v1);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T1>(&mut arg0, b"turbos-finance", 0x2::coin::value<T1>(&v5));
        (arg0, v5)
    }

    public fun leg_turbos_ba<T0, T1, T2>(arg0: 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, arg1: &0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Config, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::Ticket, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg4);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_check<T1>(&arg0, arg1, b"turbos-finance", v0);
        let v1 = 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::ticket_sender(&arg0);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, arg4);
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, v2, v0, 1, 79226673515401279992447579054, true, v1, 0x2::clock::timestamp_ms(arg5) + 3600000, arg5, arg3, arg6);
        let v5 = v3;
        flush_coin<T1>(v4, v1);
        0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router::leg_advance<T0>(&mut arg0, b"turbos-finance", 0x2::coin::value<T0>(&v5));
        (arg0, v5)
    }

    // decompiled from Move bytecode v7
}

