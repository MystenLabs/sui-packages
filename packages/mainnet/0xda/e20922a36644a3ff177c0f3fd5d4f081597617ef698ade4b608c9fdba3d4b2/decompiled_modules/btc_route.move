module 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::btc_route {
    struct Controls has copy, drop {
        seed: u64,
        min: u64,
        max: u64,
        rounds: u64,
        min_surplus: u64,
        max_deep: u64,
        margin_bps: u64,
        deadline: u64,
        gas_price: u64,
        epoch: u64,
        fee_allowance: u64,
    }

    struct Result has copy, drop {
        reverse: bool,
        owned_deep: bool,
        fixed_amount: bool,
        noop: bool,
        evaluations: u64,
        selected_input: u64,
        quoted_output: u64,
        conservative_deep: u64,
        actual_output: u64,
        repaid: u64,
        actual_deep: u64,
        deep_value_sui: u64,
        sui_surplus: u64,
        min_surplus: u64,
        gas_price: u64,
        epoch: u64,
        clock_ms: u64,
        fee_allowance_ppb: u64,
        fee_coin_cap: u64,
    }

    fun quote<T0, T1, T2>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg4: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: bool, arg8: bool, arg9: u64) : (u64, u64) {
        if (arg7) {
            let (v2, v3) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::quote<T1, T0>(arg1, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::quote<T1, T2>(arg2, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::quote<0x2::sui::SUI, T2>(arg3, arg6, true), false), true, arg8, arg9, arg5);
            (0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bolt::quote<T0>(arg0, arg4, arg5, v2, false), v3)
        } else {
            let (v4, v5) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::quote<T1, T0>(arg1, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bolt::quote<T0>(arg0, arg4, arg5, arg6, true), false, arg8, arg9, arg5);
            (0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::quote<0x2::sui::SUI, T2>(arg3, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::quote<T1, T2>(arg2, v4, true), false), v5)
        }
    }

    fun quote_sui_pool<T0, T1, T2>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg4: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: bool, arg8: bool, arg9: u64) : (u64, u64) {
        if (arg7) {
            let (v2, v3) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::quote<T1, T0>(arg1, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::quote<T1, T2>(arg2, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::quote<0x2::sui::SUI, T2>(arg3, arg6, true), false), true, arg8, arg9, arg5);
            (0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bolt::quote_sui_pool<T0>(arg0, arg4, arg5, v2, false), v3)
        } else {
            let (v4, v5) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::quote<T1, T0>(arg1, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bolt::quote_sui_pool<T0>(arg0, arg4, arg5, arg6, true), false, arg8, arg9, arg5);
            (0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::quote<0x2::sui::SUI, T2>(arg3, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::quote<T1, T2>(arg2, v4, true), false), v5)
        }
    }

    fun check_pools<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig) {
        assert!(0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>>(arg0) == @0x34f3a42e7348de2084406db7a725f9d9d132a56c68324713e6e623601fb4fd7, 2);
        assert!(0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1) == @0x34fcaa553f1185e1c3a05de37b6a4d10c39535d19f9c8581eeae826434602b58, 2);
        assert!(0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg2) == @0x20b9a3ec7a02d4f344aa1ebc5774b7b0ccafa9a5d76230662fdc0300bb215307, 2);
        assert!(0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg3) == @0x5989f1c33c5159a7bd4152e6407520c877845551a8aa9a8a5061e43023bb4d74, 2);
        assert!(0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>>(arg4) == @0xba7935fd7140fbb507c55321d425f783b24256d9cc23f522228253aef228e774, 2);
        assert!(0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>>(arg5) == @0xb663828d6217467c8a1838a03793da896cbe745b150ebd57d82f814ca579fc22, 2);
        assert!(0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle>(arg6) == @0xfa3975b98f3d0e3df18ed88ae6e69db31836b3f4212df02fae144b1e5a89ca8e, 2);
        assert!(0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg7) == @0x3db251ba509a8d5d8777b6338836082335d93eecbdd09a11e190a1cff51c352, 2);
    }

    fun check_pools_sui_pool<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig) {
        assert!(0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>>(arg0) == @0x34f3a42e7348de2084406db7a725f9d9d132a56c68324713e6e623601fb4fd7, 2);
        assert!(0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>>(arg1) == @0x21167b2e981e2c0a693afcfe882a3a827d663118e19afcb92e45bfe43fe56278, 2);
        assert!(0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg2) == @0x20b9a3ec7a02d4f344aa1ebc5774b7b0ccafa9a5d76230662fdc0300bb215307, 2);
        assert!(0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg3) == @0x5989f1c33c5159a7bd4152e6407520c877845551a8aa9a8a5061e43023bb4d74, 2);
        assert!(0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>>(arg4) == @0xba7935fd7140fbb507c55321d425f783b24256d9cc23f522228253aef228e774, 2);
        assert!(0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>>(arg5) == @0xb663828d6217467c8a1838a03793da896cbe745b150ebd57d82f814ca579fc22, 2);
        assert!(0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle>(arg6) == @0xfa3975b98f3d0e3df18ed88ae6e69db31836b3f4212df02fae144b1e5a89ca8e, 2);
        assert!(0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg7) == @0x3db251ba509a8d5d8777b6338836082335d93eecbdd09a11e190a1cff51c352, 2);
    }

    fun controls(arg0: vector<u64>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : Controls {
        assert!(0x1::vector::length<u64>(&arg0) == 11, 1);
        let v0 = Controls{
            seed          : *0x1::vector::borrow<u64>(&arg0, 0),
            min           : *0x1::vector::borrow<u64>(&arg0, 1),
            max           : *0x1::vector::borrow<u64>(&arg0, 2),
            rounds        : *0x1::vector::borrow<u64>(&arg0, 3),
            min_surplus   : *0x1::vector::borrow<u64>(&arg0, 4),
            max_deep      : *0x1::vector::borrow<u64>(&arg0, 5),
            margin_bps    : *0x1::vector::borrow<u64>(&arg0, 6),
            deadline      : *0x1::vector::borrow<u64>(&arg0, 7),
            gas_price     : *0x1::vector::borrow<u64>(&arg0, 8),
            epoch         : *0x1::vector::borrow<u64>(&arg0, 9),
            fee_allowance : *0x1::vector::borrow<u64>(&arg0, 10),
        };
        assert!(v0.fee_allowance <= 2000000, 1);
        0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::new(v0.min, v0.max, v0.seed, v0.rounds);
        let v1 = if (v0.min_surplus > 0) {
            if (v0.margin_bps <= 10000) {
                v0.max_deep <= 1000000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        assert!(v0.gas_price == 0x2::tx_context::gas_price(arg2) && v0.epoch == 0x2::tx_context::epoch(arg2), 1);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        assert!(v2 <= v0.deadline && v0.deadline - v2 <= 60000, 3);
        assert!(0x2::object::id_address<0x2::clock::Clock>(arg1) == @0x6, 5);
        v0
    }

    fun execute<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: &Controls, arg11: u64, arg12: bool, arg13: bool, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        assert!(arg14 <= arg10.max_deep && (arg13 || arg14 == 0), 4);
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9) >= arg14 && (!arg13 || arg14 > 0), 4);
        let (v0, v1) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::borrow<T3>(arg0, arg11, arg15);
        let (v2, v3) = if (arg12) {
            let (v4, v5) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::a2b<0x2::sui::SUI, T2>(arg4, arg7, arg8, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
            let (v6, v7) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::b2a<T1, T2>(arg3, arg7, arg8, v5);
            let (v8, v9, v10) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::sell<T1, T0>(arg2, 0x2::coin::from_balance<T1>(v6, arg15), 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9, arg14, arg15), arg8, arg15);
            let (v11, v12) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bolt::sell<T0>(arg1, arg6, arg8, 0x2::coin::into_balance<T0>(v9), arg15);
            let v13 = v12;
            0x2::balance::join<0x2::sui::SUI>(&mut v13, v4);
            return_balance<T2>(v7, arg15);
            return_coin<T1>(v8, arg15);
            return_balance<T0>(v11, arg15);
            (0x2::coin::from_balance<0x2::sui::SUI>(v13, arg15), v10)
        } else {
            let (v14, v15) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bolt::buy<T0>(arg1, arg6, arg8, 0x2::coin::into_balance<0x2::sui::SUI>(v0), arg15);
            let (v16, v17, v18) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::buy<T1, T0>(arg2, 0x2::coin::from_balance<T0>(v14, arg15), 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9, arg14, arg15), arg8, arg15);
            let (v19, v20) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::a2b<T1, T2>(arg3, arg7, arg8, 0x2::coin::into_balance<T1>(v16));
            let (v21, v22) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::b2a<0x2::sui::SUI, T2>(arg4, arg7, arg8, v20);
            let v23 = v21;
            0x2::balance::join<0x2::sui::SUI>(&mut v23, v15);
            return_coin<T0>(v17, arg15);
            return_balance<T1>(v19, arg15);
            return_balance<T2>(v22, arg15);
            (0x2::coin::from_balance<0x2::sui::SUI>(v23, arg15), v18)
        };
        let v24 = v3;
        let v25 = v2;
        let v26 = 0x2::coin::value<0x2::sui::SUI>(&v25);
        let v27 = arg14 - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v24);
        0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9, v24);
        assert!(v27 <= arg10.max_deep, 4);
        assert!(v26 >= arg11, 6);
        0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::repay<T3>(arg0, &mut v25, arg11, v1, arg15);
        let v28 = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::value_deep(arg5, v27, arg10.margin_bps, arg8);
        let v29 = 0x2::coin::value<0x2::sui::SUI>(&v25);
        0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::assert_repaid_surplus(v29, v28, arg10.min_surplus);
        return_coin<0x2::sui::SUI>(v25, arg15);
        (v26, v27, v28, v29)
    }

    fun execute_sui_pool<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: &Controls, arg11: u64, arg12: bool, arg13: bool, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        assert!(arg14 <= arg10.max_deep && (arg13 || arg14 == 0), 4);
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9) >= arg14 && (!arg13 || arg14 > 0), 4);
        let (v0, v1) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::borrow<T3>(arg0, arg11, arg15);
        let (v2, v3) = if (arg12) {
            let (v4, v5) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::a2b<0x2::sui::SUI, T2>(arg4, arg7, arg8, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
            let (v6, v7) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::b2a<T1, T2>(arg3, arg7, arg8, v5);
            let (v8, v9, v10) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::sell<T1, T0>(arg2, 0x2::coin::from_balance<T1>(v6, arg15), 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9, arg14, arg15), arg8, arg15);
            let (v11, v12) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bolt::buy_sui<T0>(arg1, arg6, arg8, 0x2::coin::into_balance<T0>(v9), arg15);
            let v13 = v11;
            0x2::balance::join<0x2::sui::SUI>(&mut v13, v4);
            return_balance<T2>(v7, arg15);
            return_coin<T1>(v8, arg15);
            return_balance<T0>(v12, arg15);
            (0x2::coin::from_balance<0x2::sui::SUI>(v13, arg15), v10)
        } else {
            let (v14, v15) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bolt::sell_sui<T0>(arg1, arg6, arg8, 0x2::coin::into_balance<0x2::sui::SUI>(v0), arg15);
            let (v16, v17, v18) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::buy<T1, T0>(arg2, 0x2::coin::from_balance<T0>(v15, arg15), 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9, arg14, arg15), arg8, arg15);
            let (v19, v20) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::a2b<T1, T2>(arg3, arg7, arg8, 0x2::coin::into_balance<T1>(v16));
            let (v21, v22) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::bluefin::b2a<0x2::sui::SUI, T2>(arg4, arg7, arg8, v20);
            let v23 = v21;
            0x2::balance::join<0x2::sui::SUI>(&mut v23, v14);
            return_coin<T0>(v17, arg15);
            return_balance<T1>(v19, arg15);
            return_balance<T2>(v22, arg15);
            (0x2::coin::from_balance<0x2::sui::SUI>(v23, arg15), v18)
        };
        let v24 = v3;
        let v25 = v2;
        let v26 = 0x2::coin::value<0x2::sui::SUI>(&v25);
        let v27 = arg14 - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v24);
        0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9, v24);
        assert!(v27 <= arg10.max_deep, 4);
        assert!(v26 >= arg11, 6);
        0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::repay<T3>(arg0, &mut v25, arg11, v1, arg15);
        let v28 = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::value_deep(arg5, v27, arg10.margin_bps, arg8);
        let v29 = 0x2::coin::value<0x2::sui::SUI>(&v25);
        0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::assert_repaid_surplus(v29, v28, arg10.min_surplus);
        return_coin<0x2::sui::SUI>(v25, arg15);
        (v26, v27, v28, v29)
    }

    public fun fixed_forward_deep<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        run<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, false, true, true, arg11);
    }

    public fun fixed_forward_input<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10);
        let v1 = &mut v0;
        run<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg9, false, false, true, arg10);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0);
    }

    public fun fixed_forward_input_sui_pool<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10);
        let v1 = &mut v0;
        run_sui_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg9, false, false, true, arg10);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0);
    }

    public fun fixed_reverse_deep<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        run<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, true, true, true, arg11);
    }

    public fun fixed_reverse_input<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10);
        let v1 = &mut v0;
        run<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg9, true, false, true, arg10);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0);
    }

    public fun fixed_reverse_input_sui_pool<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10);
        let v1 = &mut v0;
        run_sui_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg9, true, false, true, arg10);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0);
    }

    public fun forward_deep<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        run<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, false, true, false, arg11);
    }

    public fun forward_input<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10);
        let v1 = &mut v0;
        run<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg9, false, false, false, arg10);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0);
    }

    public fun forward_input_sui_pool<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10);
        let v1 = &mut v0;
        run_sui_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg9, false, false, false, arg10);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0);
    }

    fun return_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    fun return_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun reverse_deep<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        run<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, true, true, false, arg11);
    }

    public fun reverse_input<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10);
        let v1 = &mut v0;
        run<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg9, true, false, false, arg10);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0);
    }

    public fun reverse_input_sui_pool<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10);
        let v1 = &mut v0;
        run_sui_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg9, true, false, false, arg10);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0);
    }

    fun run<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: vector<u64>, arg11: bool, arg12: bool, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = controls(arg10, arg8, arg14);
        check_pools<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        assert!(arg12 || v0.max_deep == 0, 4);
        let (v1, v2, v3, v4) = if (arg13) {
            let (v5, v6) = quote<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6, arg8, v0.seed, arg11, arg12, v0.fee_allowance);
            (v6, 1, v0.seed, v5)
        } else {
            let v7 = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::new(v0.min, v0.max, v0.seed, v0.rounds);
            let v8 = 0;
            while (!0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::finished(&v7)) {
                let v9 = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::candidates(&v7);
                0x1::vector::reverse<u64>(&mut v9);
                let v10 = 0;
                while (v10 < 0x1::vector::length<u64>(&v9)) {
                    let v11 = 0x1::vector::pop_back<u64>(&mut v9);
                    let (v12, v13) = quote<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6, arg8, v11, arg11, arg12, v0.fee_allowance);
                    let v14 = if (v13 <= v0.max_deep) {
                        0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::value_deep(arg5, v13, v0.margin_bps, arg8)
                    } else {
                        0
                    };
                    let v15 = v12 > 0 && v13 <= v0.max_deep;
                    0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::record(&mut v7, v11, v12, v14, v15);
                    let (v16, _, _, _) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::result(&v7);
                    if (v16 == v11) {
                        v8 = v13;
                    };
                    v10 = v10 + 1;
                };
                0x1::vector::destroy_empty<u64>(v9);
                0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::advance(&mut v7);
            };
            let (v20, v21, _, v23) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::result(&v7);
            (v8, v23, v20, v21)
        };
        let v24 = !arg13 && (v3 == 0 || !0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::qualifies(v3, v4, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::value_deep(arg5, v1, v0.margin_bps, arg8), v0.min_surplus));
        let v25 = if (!arg12 || v24) {
            0
        } else if (arg13) {
            v0.max_deep
        } else {
            0x1::u64::max(v1, 1)
        };
        let (v26, v27, v28, v29) = if (v24) {
            (0, 0, 0, 0)
        } else {
            execute<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, &v0, v3, arg11, arg12, v25, arg14)
        };
        let v30 = if (v24) {
            0
        } else {
            v3
        };
        let v31 = Result{
            reverse           : arg11,
            owned_deep        : arg12,
            fixed_amount      : arg13,
            noop              : v24,
            evaluations       : v2,
            selected_input    : v3,
            quoted_output     : v4,
            conservative_deep : v1,
            actual_output     : v26,
            repaid            : v30,
            actual_deep       : v27,
            deep_value_sui    : v28,
            sui_surplus       : v29,
            min_surplus       : v0.min_surplus,
            gas_price         : v0.gas_price,
            epoch             : v0.epoch,
            clock_ms          : 0x2::clock::timestamp_ms(arg8),
            fee_allowance_ppb : v0.fee_allowance,
            fee_coin_cap      : v25,
        };
        0x2::event::emit<Result>(v31);
    }

    fun run_sui_pool<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T3>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: vector<u64>, arg11: bool, arg12: bool, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = controls(arg10, arg8, arg14);
        check_pools_sui_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        assert!(arg12 || v0.max_deep == 0, 4);
        let (v1, v2, v3, v4) = if (arg13) {
            let (v5, v6) = quote_sui_pool<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6, arg8, v0.seed, arg11, arg12, v0.fee_allowance);
            (v6, 1, v0.seed, v5)
        } else {
            let v7 = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::new(v0.min, v0.max, v0.seed, v0.rounds);
            let v8 = 0;
            while (!0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::finished(&v7)) {
                let v9 = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::candidates(&v7);
                0x1::vector::reverse<u64>(&mut v9);
                let v10 = 0;
                while (v10 < 0x1::vector::length<u64>(&v9)) {
                    let v11 = 0x1::vector::pop_back<u64>(&mut v9);
                    let (v12, v13) = quote_sui_pool<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6, arg8, v11, arg11, arg12, v0.fee_allowance);
                    let v14 = if (v13 <= v0.max_deep) {
                        0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::value_deep(arg5, v13, v0.margin_bps, arg8)
                    } else {
                        0
                    };
                    let v15 = v12 > 0 && v13 <= v0.max_deep;
                    0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::record(&mut v7, v11, v12, v14, v15);
                    let (v16, _, _, _) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::result(&v7);
                    if (v16 == v11) {
                        v8 = v13;
                    };
                    v10 = v10 + 1;
                };
                0x1::vector::destroy_empty<u64>(v9);
                0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::advance(&mut v7);
            };
            let (v20, v21, _, v23) = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::result(&v7);
            (v8, v23, v20, v21)
        };
        let v24 = !arg13 && (v3 == 0 || !0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::qualifies(v3, v4, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook::value_deep(arg5, v1, v0.margin_bps, arg8), v0.min_surplus));
        let v25 = if (!arg12 || v24) {
            0
        } else if (arg13) {
            v0.max_deep
        } else {
            0x1::u64::max(v1, 1)
        };
        let (v26, v27, v28, v29) = if (v24) {
            (0, 0, 0, 0)
        } else {
            execute_sui_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, &v0, v3, arg11, arg12, v25, arg14)
        };
        let v30 = if (v24) {
            0
        } else {
            v3
        };
        let v31 = Result{
            reverse           : arg11,
            owned_deep        : arg12,
            fixed_amount      : arg13,
            noop              : v24,
            evaluations       : v2,
            selected_input    : v3,
            quoted_output     : v4,
            conservative_deep : v1,
            actual_output     : v26,
            repaid            : v30,
            actual_deep       : v27,
            deep_value_sui    : v28,
            sui_surplus       : v29,
            min_surplus       : v0.min_surplus,
            gas_price         : v0.gas_price,
            epoch             : v0.epoch,
            clock_ms          : 0x2::clock::timestamp_ms(arg8),
            fee_allowance_ppb : v0.fee_allowance,
            fee_coin_cap      : v25,
        };
        0x2::event::emit<Result>(v31);
    }

    // decompiled from Move bytecode v7
}

