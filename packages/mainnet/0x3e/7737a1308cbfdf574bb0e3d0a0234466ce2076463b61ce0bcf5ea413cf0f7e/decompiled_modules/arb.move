module 0x3e7737a1308cbfdf574bb0e3d0a0234466ce2076463b61ce0bcf5ea413cf0f7e::arb {
    struct WhaleArb has copy, drop {
        pair: vector<u8>,
        direction: u8,
        loan: u64,
        profit: u64,
        spread_bps: u64,
        recipient: address,
        ts: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ArbConfig has key {
        id: 0x2::object::UID,
        profit_recipient: address,
        min_profit: u64,
        max_loan: u64,
        paused: bool,
        total_profit: u64,
        total_arbs: u64,
    }

    fun exec_cetus_to_db<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg2, arg3, arg7);
        let v2 = v0;
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v2), 0, arg6);
        let v6 = v4;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v2), v5);
        if (0x2::balance::value<T1>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg7), arg5);
        } else {
            0x2::balance::destroy_zero<T1>(v6);
        };
        let (v7, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg2, 0x2::coin::from_balance<T0>(v3, arg7), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), arg3, arg6, arg7);
        let v10 = v9;
        let v11 = v8;
        0x2::coin::destroy_zero<T0>(v7);
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v10, arg5);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v10);
        };
        let v12 = 0x2::coin::value<T1>(&v11);
        let v13 = if (v12 > arg3) {
            v12 - arg3
        } else {
            0
        };
        assert!(v13 >= arg4, 2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg2, 0x2::coin::split<T1>(&mut v11, arg3, arg7), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, arg5);
        v13
    }

    fun exec_db_to_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg2, arg3, arg7);
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, v0, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), 0, arg6, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        if (0x2::coin::value<T1>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, arg5);
        } else {
            0x2::coin::destroy_zero<T1>(v6);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v5, arg5);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v5);
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v7), 0, arg6);
        let v11 = v8;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v7), 0x2::balance::zero<T1>(), v10);
        if (0x2::balance::value<T0>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg7), arg5);
        } else {
            0x2::balance::destroy_zero<T0>(v11);
        };
        let v12 = 0x2::coin::from_balance<T1>(v9, arg7);
        let v13 = 0x2::coin::value<T1>(&v12);
        let v14 = if (v13 > arg3) {
            v13 - arg3
        } else {
            0
        };
        assert!(v14 >= arg4, 2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg2, 0x2::coin::split<T1>(&mut v12, arg3, arg7), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, arg5);
        v14
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ArbConfig{
            id               : 0x2::object::new(arg0),
            profit_recipient : 0x2::tx_context::sender(arg0),
            min_profit       : 25000000,
            max_loan         : 200000000000,
            paused           : false,
            total_profit     : 0,
            total_arbs       : 0,
        };
        0x2::transfer::share_object<ArbConfig>(v1);
    }

    fun optimal_loan_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        let v0 = if (arg0 < 15) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return (0, 0)
        };
        let v1 = 1000000000000000000 / 2 * (arg1 as u128) + 1000000000000000000 / 2 * (arg2 as u128);
        let v2 = (arg0 as u128) * 1000000000000000000 / 10000;
        let v3 = if (v1 > 0) {
            v2 * 1000000000000000000 / 2 * v1 / 1000000000
        } else {
            (arg5 as u128)
        };
        let v4 = if (arg1 < arg2) {
            arg1
        } else {
            arg2
        };
        let v5 = (v4 as u128) * (20 as u128) / 100;
        let v6 = v3;
        if (v5 < v3) {
            v6 = v5;
        };
        if ((arg5 as u128) < v6) {
            v6 = (arg5 as u128);
        };
        let v7 = (v6 as u64);
        if (v7 == 0) {
            return (0, 0)
        };
        let v8 = v2 * v6 / 1000000000000000000;
        let v9 = v1 * v6 * v6 / 1000000000000000000 / 1000000000 + v6 * (arg3 as u128) / 100000 + (arg4 as u128);
        let v10 = if (v8 > v9) {
            ((v8 - v9) as u64)
        } else {
            0
        };
        (v7, v10)
    }

    entry fun set_max_loan(arg0: &AdminCap, arg1: &mut ArbConfig, arg2: u64) {
        arg1.max_loan = arg2;
    }

    entry fun set_min_profit(arg0: &AdminCap, arg1: &mut ArbConfig, arg2: u64) {
        arg1.min_profit = arg2;
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut ArbConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    entry fun set_recipient(arg0: &AdminCap, arg1: &mut ArbConfig, arg2: address) {
        arg1.profit_recipient = arg2;
    }

    entry fun whale_arb<T0, T1>(arg0: &mut ArbConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg6 >= 15, 3);
        let v0 = arg0.profit_recipient;
        let (v1, v2) = optimal_loan_size(arg6, arg7, arg8, 35, 220000, arg0.max_loan);
        let v3 = if (arg5 < v1) {
            arg5
        } else {
            v1
        };
        assert!(v3 > 0, 2);
        assert!(v2 >= arg0.min_profit, 2);
        let v4 = if (arg4 == 0) {
            exec_cetus_to_db<T0, T1>(arg1, arg2, arg3, v3, arg0.min_profit, v0, arg10, arg11)
        } else {
            exec_db_to_cetus<T0, T1>(arg1, arg2, arg3, v3, arg0.min_profit, v0, arg10, arg11)
        };
        arg0.total_arbs = arg0.total_arbs + 1;
        arg0.total_profit = arg0.total_profit + v4;
        let v5 = WhaleArb{
            pair       : arg9,
            direction  : arg4,
            loan       : v3,
            profit     : v4,
            spread_bps : arg6,
            recipient  : v0,
            ts         : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<WhaleArb>(v5);
    }

    // decompiled from Move bytecode v7
}

