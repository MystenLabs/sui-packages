module 0xe36f05e90889fdf129f6a35af1aa3ee76ca64aeaff9cca781ea9df5f49463563::arb {
    struct DeepArb has copy, drop {
        pair: u8,
        direction: u8,
        loan: u64,
        profit: u64,
        spread_bps: u64,
        ts: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DeepConfig has key {
        id: 0x2::object::UID,
        profit_recipient: address,
        min_profit: u64,
        max_loan: u64,
        paused: bool,
        deep_sui_arbs: u64,
        deep_usdc_arbs: u64,
        total_profit: u64,
    }

    entry fun arb_deep_sui<T0, T1>(arg0: &mut DeepConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u8, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg6 >= 2, 2);
        assert!(arg5 > 0 && arg5 <= arg0.max_loan, 2);
        let v0 = arg0.profit_recipient;
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg3, arg5, arg8);
        let v3 = v1;
        let v4 = if (arg4 == 0) {
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&v3), 79226673515401279992447579055, arg7);
            let v8 = v6;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v3), v7);
            if (0x2::balance::value<T1>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg8), v0);
            } else {
                0x2::balance::destroy_zero<T1>(v8);
            };
            let (v9, v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg3, 0x2::coin::from_balance<T0>(v5, arg8), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg7, arg8);
            let v12 = v11;
            let v13 = v10;
            let v14 = v9;
            if (0x2::coin::value<T0>(&v14) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v0);
            } else {
                0x2::coin::destroy_zero<T0>(v14);
            };
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v12) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v12, v0);
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v12);
            };
            let v15 = 0x2::coin::value<T1>(&v13);
            let v16 = if (v15 > arg5) {
                v15 - arg5
            } else {
                0
            };
            assert!(v16 >= arg0.min_profit, 2);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg3, 0x2::coin::split<T1>(&mut v13, arg5, arg8), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, v0);
            v16
        } else {
            let (v17, v18, v19) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg3, v3, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg7, arg8);
            let v20 = v19;
            let v21 = v18;
            let v22 = v17;
            if (0x2::coin::value<T1>(&v21) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v21, v0);
            } else {
                0x2::coin::destroy_zero<T1>(v21);
            };
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v20) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v20, v0);
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v20);
            };
            let (v23, v24, v25) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&v22), 4295048016, arg7);
            let v26 = v23;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v22), 0x2::balance::zero<T1>(), v25);
            if (0x2::balance::value<T0>(&v26) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v26, arg8), v0);
            } else {
                0x2::balance::destroy_zero<T0>(v26);
            };
            let v27 = 0x2::coin::from_balance<T1>(v24, arg8);
            let v28 = 0x2::coin::value<T1>(&v27);
            let v29 = if (v28 > arg5) {
                v28 - arg5
            } else {
                0
            };
            assert!(v29 >= arg0.min_profit, 2);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg3, 0x2::coin::split<T1>(&mut v27, arg5, arg8), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v27, v0);
            v29
        };
        let v30 = DeepArb{
            pair       : 0,
            direction  : arg4,
            loan       : arg5,
            profit     : v4,
            spread_bps : arg6,
            ts         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<DeepArb>(v30);
        arg0.deep_sui_arbs = arg0.deep_sui_arbs + 1;
        arg0.total_profit = arg0.total_profit + v4;
    }

    entry fun arb_deep_usdc<T0, T1>(arg0: &mut DeepConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u8, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg6 >= 2, 2);
        assert!(arg5 > 0 && arg5 <= arg0.max_loan, 2);
        let v0 = arg0.profit_recipient;
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg3, arg5, arg8);
        let v3 = v1;
        let v4 = if (arg4 == 0) {
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&v3), 79226673515401279992447579055, arg7);
            let v8 = v6;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v3), v7);
            if (0x2::balance::value<T1>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg8), v0);
            } else {
                0x2::balance::destroy_zero<T1>(v8);
            };
            let (v9, v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg3, 0x2::coin::from_balance<T0>(v5, arg8), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg7, arg8);
            let v12 = v11;
            let v13 = v10;
            let v14 = v9;
            if (0x2::coin::value<T0>(&v14) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v0);
            } else {
                0x2::coin::destroy_zero<T0>(v14);
            };
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v12) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v12, v0);
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v12);
            };
            let v15 = 0x2::coin::value<T1>(&v13);
            let v16 = if (v15 > arg5) {
                v15 - arg5
            } else {
                0
            };
            assert!(v16 >= arg0.min_profit, 2);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg3, 0x2::coin::split<T1>(&mut v13, arg5, arg8), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, v0);
            v16
        } else {
            let (v17, v18, v19) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg3, v3, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg7, arg8);
            let v20 = v19;
            let v21 = v18;
            let v22 = v17;
            if (0x2::coin::value<T1>(&v21) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v21, v0);
            } else {
                0x2::coin::destroy_zero<T1>(v21);
            };
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v20) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v20, v0);
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v20);
            };
            let (v23, v24, v25) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&v22), 4295048016, arg7);
            let v26 = v23;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v22), 0x2::balance::zero<T1>(), v25);
            if (0x2::balance::value<T0>(&v26) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v26, arg8), v0);
            } else {
                0x2::balance::destroy_zero<T0>(v26);
            };
            let v27 = 0x2::coin::from_balance<T1>(v24, arg8);
            let v28 = 0x2::coin::value<T1>(&v27);
            let v29 = if (v28 > arg5) {
                v28 - arg5
            } else {
                0
            };
            assert!(v29 >= arg0.min_profit, 2);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg3, 0x2::coin::split<T1>(&mut v27, arg5, arg8), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v27, v0);
            v29
        };
        let v30 = DeepArb{
            pair       : 1,
            direction  : arg4,
            loan       : arg5,
            profit     : v4,
            spread_bps : arg6,
            ts         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<DeepArb>(v30);
        arg0.deep_usdc_arbs = arg0.deep_usdc_arbs + 1;
        arg0.total_profit = arg0.total_profit + v4;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DeepConfig{
            id               : 0x2::object::new(arg0),
            profit_recipient : 0x2::tx_context::sender(arg0),
            min_profit       : 50000,
            max_loan         : 50000000000,
            paused           : false,
            deep_sui_arbs    : 0,
            deep_usdc_arbs   : 0,
            total_profit     : 0,
        };
        0x2::transfer::share_object<DeepConfig>(v1);
    }

    entry fun set_max_loan(arg0: &AdminCap, arg1: &mut DeepConfig, arg2: u64) {
        arg1.max_loan = arg2;
    }

    entry fun set_min_profit(arg0: &AdminCap, arg1: &mut DeepConfig, arg2: u64) {
        arg1.min_profit = arg2;
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut DeepConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    entry fun set_recipient(arg0: &AdminCap, arg1: &mut DeepConfig, arg2: address) {
        arg1.profit_recipient = arg2;
    }

    // decompiled from Move bytecode v7
}

