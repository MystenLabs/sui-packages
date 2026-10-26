module 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::engine {
    public fun bluefin_flash_b2a_cetus_swap<T0, T1>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::flash_b2a<T0, T1>(arg6, arg2, arg3, arg7);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::swap_a2b<T0, T1>(arg4, arg5, arg6, v0);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::repay_b2a<T0, T1>(arg2, arg3, repay_floor<T1>(v5, v4, arg8), v2);
        let v6 = 0x2::balance::value<T1>(&v3);
        payout_profit<T1>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 2, 1, 0x2::clock::timestamp_ms(arg6));
    }

    public fun bluefin_flash_b2a_turbos_swap<T0, T1, T2>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::flash_b2a<T0, T1>(arg6, arg2, arg3, arg7);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::swap_a2b<T0, T1, T2>(arg4, v0, arg6, arg5, arg9);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::repay_b2a<T0, T1>(arg2, arg3, repay_floor<T1>(v5, v4, arg8), v2);
        let v6 = 0x2::balance::value<T1>(&v3);
        payout_profit<T1>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 2, 3, 0x2::clock::timestamp_ms(arg6));
    }

    public fun bluefin_flash_cetus_swap<T0, T1>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::flash_a2b<T0, T1>(arg6, arg2, arg3, arg7);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::swap_b2a<T0, T1>(arg4, arg5, arg6, v0);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::repay_a2b<T0, T1>(arg2, arg3, repay_floor<T0>(v5, v4, arg8), v2);
        let v6 = 0x2::balance::value<T0>(&v3);
        payout_profit<T0>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 2, 1, 0x2::clock::timestamp_ms(arg6));
    }

    public fun bluefin_flash_turbos_swap<T0, T1, T2>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::flash_a2b<T0, T1>(arg6, arg2, arg3, arg7);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::swap_b2a<T0, T1, T2>(arg4, v0, arg6, arg5, arg9);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::repay_a2b<T0, T1>(arg2, arg3, repay_floor<T0>(v5, v4, arg8), v2);
        let v6 = 0x2::balance::value<T0>(&v3);
        payout_profit<T0>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 2, 3, 0x2::clock::timestamp_ms(arg6));
    }

    public fun cetus_flash_b2a_bluefin_swap<T0, T1>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::flash_b2a<T0, T1>(arg2, arg3, arg6, arg7);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::swap_a2b<T0, T1>(arg6, arg4, arg5, v0);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::repay_b2a<T0, T1>(arg2, arg3, repay_floor<T1>(v5, v4, arg8), v2);
        let v6 = 0x2::balance::value<T1>(&v3);
        payout_profit<T1>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 1, 2, 0x2::clock::timestamp_ms(arg6));
    }

    public fun cetus_flash_b2a_turbos_swap<T0, T1, T2>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::flash_b2a<T0, T1>(arg2, arg3, arg6, arg7);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::swap_a2b<T0, T1, T2>(arg4, v0, arg6, arg5, arg9);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::repay_b2a<T0, T1>(arg2, arg3, repay_floor<T1>(v5, v4, arg8), v2);
        let v6 = 0x2::balance::value<T1>(&v3);
        payout_profit<T1>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 1, 3, 0x2::clock::timestamp_ms(arg6));
    }

    public fun cetus_flash_bluefin_swap<T0, T1>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::flash_a2b<T0, T1>(arg2, arg3, arg6, arg7);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::swap_b2a<T0, T1>(arg6, arg4, arg5, v0);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::repay_a2b<T0, T1>(arg2, arg3, repay_floor<T0>(v5, v4, arg8), v2);
        let v6 = 0x2::balance::value<T0>(&v3);
        payout_profit<T0>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 1, 2, 0x2::clock::timestamp_ms(arg6));
    }

    public fun cetus_flash_turbos_swap<T0, T1, T2>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::flash_a2b<T0, T1>(arg2, arg3, arg6, arg7);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::swap_b2a<T0, T1, T2>(arg4, v0, arg6, arg5, arg9);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::repay_a2b<T0, T1>(arg2, arg3, repay_floor<T0>(v5, v4, arg8), v2);
        let v6 = 0x2::balance::value<T0>(&v3);
        payout_profit<T0>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 1, 3, 0x2::clock::timestamp_ms(arg6));
    }

    fun payout_profit<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::get_treasury(arg1));
    }

    public fun repay_floor<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1 + arg2, 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::errors::profit_below_floor());
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun turbos_flash_b2a_bluefin_swap<T0, T1, T2>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::flash_b2a<T0, T1, T2>(arg2, arg6, arg3, arg7, arg9);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::swap_a2b<T0, T1>(arg6, arg4, arg5, v0);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::repay_b2a<T0, T1, T2>(arg2, repay_floor<T1>(v5, v4, arg8), v2, arg3, arg9);
        let v6 = 0x2::balance::value<T1>(&v3);
        payout_profit<T1>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 3, 2, 0x2::clock::timestamp_ms(arg6));
    }

    public fun turbos_flash_b2a_cetus_swap<T0, T1, T2>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::flash_b2a<T0, T1, T2>(arg2, arg6, arg3, arg7, arg9);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::swap_a2b<T0, T1>(arg4, arg5, arg6, v0);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::repay_b2a<T0, T1, T2>(arg2, repay_floor<T1>(v5, v4, arg8), v2, arg3, arg9);
        let v6 = 0x2::balance::value<T1>(&v3);
        payout_profit<T1>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 3, 1, 0x2::clock::timestamp_ms(arg6));
    }

    public fun turbos_flash_bluefin_swap<T0, T1, T2>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::flash_a2b<T0, T1, T2>(arg2, arg6, arg3, arg7, arg9);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::bluefin_adapter::swap_b2a<T0, T1>(arg6, arg4, arg5, v0);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::repay_a2b<T0, T1, T2>(arg2, repay_floor<T0>(v5, v4, arg8), v2, arg3, arg9);
        let v6 = 0x2::balance::value<T0>(&v3);
        payout_profit<T0>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 3, 2, 0x2::clock::timestamp_ms(arg6));
    }

    public fun turbos_flash_cetus_swap<T0, T1, T2>(arg0: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::CallerCap, arg1: &0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::State, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::assert_valid_execution(arg0, arg1, arg9);
        let (v0, v1) = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::flash_a2b<T0, T1, T2>(arg2, arg6, arg3, arg7, arg9);
        let v2 = v1;
        let v3 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::cetus_adapter::swap_b2a<T0, T1>(arg4, arg5, arg6, v0);
        let v4 = 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::get_pay_amount<T0, T1>(&v2);
        let v5 = &mut v3;
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::turbos_adapter::repay_a2b<T0, T1, T2>(arg2, repay_floor<T0>(v5, v4, arg8), v2, arg3, arg9);
        let v6 = 0x2::balance::value<T0>(&v3);
        payout_profit<T0>(v3, arg1, arg9);
        0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security::emit_success_event(b"ARBITRAGE_SUCCESS", arg7, v4 + v6, v6, 3, 1, 0x2::clock::timestamp_ms(arg6));
    }

    // decompiled from Move bytecode v7
}

