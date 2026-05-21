module 0x28a4e87dc02a8b6bafb617e39db726f10fbc245773b0dd90bc8c2ce84eb053c6::arb {
    struct WalArb has copy, drop {
        direction: u8,
        loan: u64,
        profit: u64,
        spread_bps: u64,
        ts: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WalConfig has key {
        id: 0x2::object::UID,
        profit_recipient: address,
        min_profit: u64,
        max_loan: u64,
        paused: bool,
        wal_sui_arbs: u64,
        total_profit: u64,
    }

    entry fun arb_wal_sui<T0, T1, T2>(arg0: &mut WalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg6: u8, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg8 >= 5, 2);
        assert!(arg7 > 0 && arg7 <= arg0.max_loan, 2);
        let v0 = arg0.profit_recipient;
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T1>(arg5, arg7, arg10);
        let v3 = if (arg6 == 0) {
            let (v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg9, arg3, arg4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v1), false, true, arg7, 0, 79226673515401279992447579055);
            let v6 = v5;
            let v7 = v4;
            if (0x2::balance::value<T1>(&v6) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg10), v0);
            } else {
                0x2::balance::destroy_zero<T1>(v6);
            };
            let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048016, arg9);
            let v11 = v8;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
            if (0x2::balance::value<T0>(&v11) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg10), v0);
            } else {
                0x2::balance::destroy_zero<T0>(v11);
            };
            let v12 = 0x2::coin::from_balance<T1>(v9, arg10);
            let v13 = 0x2::coin::value<T1>(&v12);
            let v14 = if (v13 > arg7) {
                v13 - arg7
            } else {
                0
            };
            assert!(v14 >= arg0.min_profit, 2);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T1>(arg5, 0x2::coin::split<T1>(&mut v12, arg7, arg10), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, v0);
            v14
        } else {
            let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg7, 79226673515401279992447579055, arg9);
            let v18 = v16;
            let v19 = v15;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v1), v17);
            if (0x2::balance::value<T1>(&v18) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v18, arg10), v0);
            } else {
                0x2::balance::destroy_zero<T1>(v18);
            };
            let (v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg9, arg3, arg4, v19, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&v19), 0, 4295048016);
            let v22 = v20;
            if (0x2::balance::value<T0>(&v22) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v22, arg10), v0);
            } else {
                0x2::balance::destroy_zero<T0>(v22);
            };
            let v23 = 0x2::coin::from_balance<T1>(v21, arg10);
            let v24 = 0x2::coin::value<T1>(&v23);
            let v25 = if (v24 > arg7) {
                v24 - arg7
            } else {
                0
            };
            assert!(v25 >= arg0.min_profit, 2);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T1>(arg5, 0x2::coin::split<T1>(&mut v23, arg7, arg10), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v23, v0);
            v25
        };
        let v26 = WalArb{
            direction  : arg6,
            loan       : arg7,
            profit     : v3,
            spread_bps : arg8,
            ts         : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<WalArb>(v26);
        arg0.wal_sui_arbs = arg0.wal_sui_arbs + 1;
        arg0.total_profit = arg0.total_profit + v3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = WalConfig{
            id               : 0x2::object::new(arg0),
            profit_recipient : 0x2::tx_context::sender(arg0),
            min_profit       : 50000,
            max_loan         : 20000000000000,
            paused           : false,
            wal_sui_arbs     : 0,
            total_profit     : 0,
        };
        0x2::transfer::share_object<WalConfig>(v1);
    }

    entry fun set_max_loan(arg0: &AdminCap, arg1: &mut WalConfig, arg2: u64) {
        arg1.max_loan = arg2;
    }

    entry fun set_min_profit(arg0: &AdminCap, arg1: &mut WalConfig, arg2: u64) {
        arg1.min_profit = arg2;
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut WalConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    entry fun set_recipient(arg0: &AdminCap, arg1: &mut WalConfig, arg2: address) {
        arg1.profit_recipient = arg2;
    }

    // decompiled from Move bytecode v7
}

