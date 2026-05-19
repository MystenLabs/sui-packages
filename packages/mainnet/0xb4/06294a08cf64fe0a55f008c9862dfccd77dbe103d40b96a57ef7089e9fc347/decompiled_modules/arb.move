module 0xb406294a08cf64fe0a55f008c9862dfccd77dbe103d40b96a57ef7089e9fc347::arb {
    struct TriangleArb has copy, drop {
        route: u8,
        loan_usdc: u64,
        profit: u64,
        leg1_bps: u64,
        leg2_bps: u64,
        leg3_bps: u64,
        recipient: address,
        ts: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TriConfig has key {
        id: 0x2::object::UID,
        profit_recipient: address,
        min_profit: u64,
        max_loan: u64,
        paused: bool,
        total_profit: u64,
        total_triangles: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = TriConfig{
            id               : 0x2::object::new(arg0),
            profit_recipient : 0x2::tx_context::sender(arg0),
            min_profit       : 5000000,
            max_loan         : 100000000000,
            paused           : false,
            total_profit     : 0,
            total_triangles  : 0,
        };
        0x2::transfer::share_object<TriConfig>(v1);
    }

    entry fun set_max_loan(arg0: &AdminCap, arg1: &mut TriConfig, arg2: u64) {
        arg1.max_loan = arg2;
    }

    entry fun set_min_profit(arg0: &AdminCap, arg1: &mut TriConfig, arg2: u64) {
        arg1.min_profit = arg2;
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut TriConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    entry fun set_recipient(arg0: &AdminCap, arg1: &mut TriConfig, arg2: address) {
        arg1.profit_recipient = arg2;
    }

    entry fun triangle_route0<T0, T1, T2>(arg0: &mut TriConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg7 + arg8 + arg9 >= 8, 2);
        let v0 = arg0.profit_recipient;
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg3, arg6, arg11);
        let v3 = v1;
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&v3), 0, arg10);
        let v7 = v5;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v3), v6);
        if (0x2::balance::value<T1>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg11), v0);
        } else {
            0x2::balance::destroy_zero<T1>(v7);
        };
        let (v8, v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T2, T0>(arg4, 0x2::coin::from_balance<T0>(v4, arg11), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg11), 0, arg10, arg11);
        let v11 = v10;
        let v12 = v9;
        if (0x2::coin::value<T0>(&v12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v12);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v11, v0);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v11);
        };
        let (v13, v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T2, T1>(arg5, v8, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg11), arg6, arg10, arg11);
        let v16 = v15;
        let v17 = v14;
        let v18 = v13;
        if (0x2::coin::value<T2>(&v18) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v18, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v18);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v16) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v16, v0);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v16);
        };
        let v19 = 0x2::coin::value<T1>(&v17);
        let v20 = if (v19 > arg6) {
            v19 - arg6
        } else {
            0
        };
        assert!(v20 >= arg0.min_profit, 2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg3, 0x2::coin::split<T1>(&mut v17, arg6, arg11), v2);
        let v21 = TriangleArb{
            route     : 0,
            loan_usdc : arg6,
            profit    : v20,
            leg1_bps  : arg7,
            leg2_bps  : arg8,
            leg3_bps  : arg9,
            recipient : v0,
            ts        : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<TriangleArb>(v21);
        arg0.total_triangles = arg0.total_triangles + 1;
        arg0.total_profit = arg0.total_profit + v20;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v17, v0);
    }

    entry fun triangle_route1<T0, T1, T2>(arg0: &mut TriConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg6 + arg7 + arg8 >= 8, 2);
        let v0 = arg0.profit_recipient;
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg2, arg5, arg10);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, v1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10), 0, arg9, arg10);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        if (0x2::coin::value<T1>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, v0);
        } else {
            0x2::coin::destroy_zero<T1>(v7);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v6, v0);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        };
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg1, arg3, false, true, 0x2::coin::value<T0>(&v8), 0, arg9);
        let v12 = v10;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg1, arg3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T0>(v8), v11);
        if (0x2::balance::value<T0>(&v12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg10), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v12);
        };
        let (v13, v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T2, T1>(arg4, 0x2::coin::from_balance<T2>(v9, arg10), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10), arg5, arg9, arg10);
        let v16 = v15;
        let v17 = v14;
        let v18 = v13;
        if (0x2::coin::value<T2>(&v18) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v18, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v18);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v16) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v16, v0);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v16);
        };
        let v19 = 0x2::coin::value<T1>(&v17);
        let v20 = if (v19 > arg5) {
            v19 - arg5
        } else {
            0
        };
        assert!(v20 >= arg0.min_profit, 2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg2, 0x2::coin::split<T1>(&mut v17, arg5, arg10), v2);
        let v21 = TriangleArb{
            route     : 1,
            loan_usdc : arg5,
            profit    : v20,
            leg1_bps  : arg6,
            leg2_bps  : arg7,
            leg3_bps  : arg8,
            recipient : v0,
            ts        : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<TriangleArb>(v21);
        arg0.total_triangles = arg0.total_triangles + 1;
        arg0.total_profit = arg0.total_profit + v20;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v17, v0);
    }

    // decompiled from Move bytecode v7
}

