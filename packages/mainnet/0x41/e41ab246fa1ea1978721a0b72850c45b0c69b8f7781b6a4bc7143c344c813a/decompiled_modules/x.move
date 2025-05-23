module 0x41e41ab246fa1ea1978721a0b72850c45b0c69b8f7781b6a4bc7143c344c813a::x {
    public fun CCC<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, true, false, arg16, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg15, arg0, arg2, true, true, 0x2::balance::value<T1>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg2, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 13906864024366088191);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CC_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg15 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg14, arg0, arg2, true, false, arg15, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg14, arg4, arg6, arg7, arg8, v1, arg9, arg10, arg11, arg12, arg13, arg16);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg14, arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        0x2::balance::destroy_zero<T0>(v8);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg14, arg0, arg2, false, true, v13, 79226673515401279992447579054);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), v6, v16);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T1>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906854111581569023);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CCc<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, false, false, arg16, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T3>(arg15, arg0, arg2, true, true, 0x2::balance::value<T1>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T3>(arg0, arg2, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 13906863693653606399);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CG_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg3, true, false, arg16, 4295048017, arg15, arg1, arg17);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        0x2::balance::destroy_zero<T0>(v8);
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg3, false, true, v13, 79226673515401279992447579054, arg15, arg1, arg17);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg3, v16, 0x2::balance::zero<T1>(), v6, arg1, arg17);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T1>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg3, v3, 0x2::balance::split<T1>(&mut v11, v12), 0x2::balance::zero<T2>(), arg1, arg17);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906855468791234559);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun C__<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg0, arg1, true, false, arg14, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T1, T0>(arg13, arg3, arg5, arg6, arg7, v1, arg8, arg9, arg10, arg11, arg12, arg15);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
        let v9 = 0x2::balance::value<T1>(&v6);
        if (v9 == 0) {
            0x2::balance::destroy_zero<T1>(v6);
        } else if (0x2::balance::value<T0>(&v7) < v8) {
            let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg0, arg1, false, true, v9, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T1>(v11);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v6, v12);
            0x2::balance::join<T0>(&mut v7, v10);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, v8), 0x2::balance::zero<T1>(), v3);
        let v13 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v13 & 18446744073709551615) as u64) ^ ((v13 >> 192) as u64) == 3093055295260124999, 13906852788731641855);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CcC<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, true, false, arg16, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg15, arg0, arg2, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 13906863362941124607);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Cc_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg15 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg14, arg0, arg2, false, false, arg15, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg14, arg4, arg6, arg7, arg8, v0, arg9, arg10, arg11, arg12, arg13, arg16);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg14, arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        0x2::balance::destroy_zero<T0>(v8);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg14, arg0, arg2, true, true, v13, 4295048017);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg2, v6, 0x2::balance::zero<T1>(), v16);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T1>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906853780869087231);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Ccc<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, false, false, arg16, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T1>(arg15, arg0, arg2, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T1>(arg0, arg2, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 13906863032228642815);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Cg_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T1>(arg3, false, false, arg16, 79226673515401279992447579054, arg15, arg1, arg17);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        0x2::balance::destroy_zero<T0>(v8);
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T1>(arg3, true, true, v13, 4295048017, arg15, arg1, arg17);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T1>(arg3, v16, v6, 0x2::balance::zero<T1>(), arg1, arg17);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T1>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T1>(arg3, v3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, v12), arg1, arg17);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906855129488818175);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun EC_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg15, arg0, arg3, true, false, arg16, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v8, 0x2::coin::from_balance<T0>(v7, arg17));
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T3>(arg2, v8, 0x2::balance::value<T0>(&v7), 0, 4295048017, true, 0x2::tx_context::sender(arg17), 18446744073709551615, arg15, arg1, arg17);
        let v11 = 0x2::coin::into_balance<T1>(v9);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(v10));
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg15, arg0, arg3, false, true, v13, 79226673515401279992447579054);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::balance::zero<T1>(), v6, v16);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T1>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::balance::split<T1>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906857083698937855);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun EG_<T0, T1, T2, T3>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg3, true, false, arg16, 4295048017, arg15, arg1, arg17);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v8, 0x2::coin::from_balance<T0>(v7, arg17));
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T3>(arg2, v8, 0x2::balance::value<T0>(&v7), 0, 4295048017, true, 0x2::tx_context::sender(arg17), 18446744073709551615, arg15, arg0, arg17);
        let v11 = 0x2::coin::into_balance<T1>(v9);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(v10));
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg3, false, true, v13, 79226673515401279992447579054, arg15, arg1, arg17);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg3, v16, 0x2::balance::zero<T1>(), v6, arg1, arg17);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T1>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg3, v3, 0x2::balance::split<T1>(&mut v11, v12), 0x2::balance::zero<T2>(), arg1, arg17);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906858698606641151);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Ec_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg15, arg0, arg3, false, false, arg16, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v8, 0x2::coin::from_balance<T0>(v7, arg17));
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T3>(arg2, v8, 0x2::balance::value<T0>(&v7), 0, 4295048017, true, 0x2::tx_context::sender(arg17), 18446744073709551615, arg15, arg1, arg17);
        let v11 = 0x2::coin::into_balance<T1>(v9);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(v10));
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg15, arg0, arg3, true, true, v13, 4295048017);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg3, v6, 0x2::balance::zero<T1>(), v16);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T1>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906856679972012031);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Eg_<T0, T1, T2, T3>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T1>(arg3, false, false, arg16, 79226673515401279992447579054, arg15, arg1, arg17);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v8, 0x2::coin::from_balance<T0>(v7, arg17));
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T3>(arg2, v8, 0x2::balance::value<T0>(&v7), 0, 4295048017, true, 0x2::tx_context::sender(arg17), 18446744073709551615, arg15, arg0, arg17);
        let v11 = 0x2::coin::into_balance<T1>(v9);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(v10));
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T1>(arg3, true, true, v13, 4295048017, arg15, arg1, arg17);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T1>(arg3, v16, v6, 0x2::balance::zero<T1>(), arg1, arg17);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T1>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T1>(arg3, v3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, v12), arg1, arg17);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906858294879715327);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun GC_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg15, arg0, arg3, true, false, arg16, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg15, arg1, arg17);
        let v11 = v9;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v10, v7, 0x2::balance::zero<T1>(), arg1, arg17);
        0x2::balance::destroy_zero<T0>(v8);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg15, arg0, arg3, false, true, v13, 79226673515401279992447579054);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::balance::zero<T1>(), v6, v16);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T1>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::balance::split<T1>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906860055816306687);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun GG_<T0, T1, T2>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg15 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg2, true, false, arg15, 4295048017, arg14, arg0, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg14, arg4, arg6, arg7, arg8, v1, arg9, arg10, arg11, arg12, arg13, arg16);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg14, arg0, arg16);
        let v11 = v9;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v10, v7, 0x2::balance::zero<T1>(), arg0, arg16);
        0x2::balance::destroy_zero<T0>(v8);
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg2, false, true, v13, 79226673515401279992447579054, arg14, arg0, arg16);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg2, v16, 0x2::balance::zero<T1>(), v6, arg0, arg16);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T1>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg2, v3, 0x2::balance::split<T1>(&mut v11, v12), 0x2::balance::zero<T2>(), arg0, arg16);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906861378666233855);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Gc_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg15, arg0, arg3, false, false, arg16, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg15, arg1, arg17);
        let v11 = v9;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v10, v7, 0x2::balance::zero<T1>(), arg1, arg17);
        0x2::balance::destroy_zero<T0>(v8);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg15, arg0, arg3, true, true, v13, 4295048017);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg3, v6, 0x2::balance::zero<T1>(), v16);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T1>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906859716513890303);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Gg_<T0, T1, T2>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg15 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T1>(arg2, false, false, arg15, 79226673515401279992447579054, arg14, arg0, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg14, arg4, arg6, arg7, arg8, v0, arg9, arg10, arg11, arg12, arg13, arg16);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg14, arg0, arg16);
        let v11 = v9;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v10, v7, 0x2::balance::zero<T1>(), arg0, arg16);
        0x2::balance::destroy_zero<T0>(v8);
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T1>(arg2, true, true, v13, 4295048017, arg14, arg0, arg16);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T1>(arg2, v16, v6, 0x2::balance::zero<T1>(), arg0, arg16);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T1>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T1>(arg2, v3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, v12), arg0, arg16);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906861047953752063);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun b(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: vector<address>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg14);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg15), arg15);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906834651084750847);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg14));
        };
        arg8
    }

    public fun c(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: vector<address>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg15);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg16), arg16);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906835046221742079);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg15));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg15));
        };
        arg8
    }

    public fun cCC<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, true, false, arg16, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg15, arg0, arg2, true, true, 0x2::balance::value<T0>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg2, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 13906862701516161023);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cC_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg15 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg14, arg0, arg2, true, false, arg15, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg14, arg4, arg6, arg7, arg8, v1, arg9, arg10, arg11, arg12, arg13, arg16);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg14, arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        0x2::balance::destroy_zero<T1>(v9);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T2>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg14, arg0, arg2, false, true, v13, 79226673515401279992447579054);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::zero<T0>(), v6, v16);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T0>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906853450156605439);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cCc<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, false, false, arg16, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T3>(arg15, arg0, arg2, true, true, 0x2::balance::value<T0>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T3>(arg0, arg2, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 13906862370803679231);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cG_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T2>(arg3, true, false, arg16, 4295048017, arg15, arg1, arg17);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        0x2::balance::destroy_zero<T1>(v9);
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T2>(arg3, false, true, v13, 79226673515401279992447579054, arg15, arg1, arg17);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T2>(arg3, v16, 0x2::balance::zero<T0>(), v6, arg1, arg17);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T0>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T2>(arg3, v3, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), arg1, arg17);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906854790186401791);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun c__<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg0, arg1, false, false, arg14, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T0, T1>(arg13, arg3, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg15);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
        let v9 = 0x2::balance::value<T0>(&v6);
        if (v9 == 0) {
            0x2::balance::destroy_zero<T0>(v6);
        } else if (0x2::balance::value<T1>(&v7) < v8) {
            let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg0, arg1, true, true, v9, 4295048017);
            0x2::balance::destroy_zero<T0>(v10);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, 0x2::balance::zero<T1>(), v12);
            0x2::balance::join<T1>(&mut v7, v11);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, v8), v3);
        let v13 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v13 & 18446744073709551615) as u64) ^ ((v13 >> 192) as u64) == 3093055295260124999, 13906852509558767615);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ccC<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, true, false, arg16, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg15, arg0, arg2, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 13906862040091197439);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cc_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg15 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg14, arg0, arg2, false, false, arg15, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg14, arg4, arg6, arg7, arg8, v0, arg9, arg10, arg11, arg12, arg13, arg16);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg14, arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        0x2::balance::destroy_zero<T1>(v9);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T0>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg14, arg0, arg2, true, true, v13, 4295048017);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg2, v6, 0x2::balance::zero<T0>(), v16);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T0>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906853119444123647);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ccc<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, false, false, arg16, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T0>(arg15, arg0, arg2, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T0>(arg0, arg2, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg15, arg0, arg3, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 13906861709378715647);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cg_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T0>(arg3, false, false, arg16, 79226673515401279992447579054, arg15, arg1, arg17);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        0x2::balance::destroy_zero<T1>(v9);
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T0>(arg3, true, true, v13, 4295048017, arg15, arg1, arg17);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T0>(arg3, v16, v6, 0x2::balance::zero<T0>(), arg1, arg17);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T0>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T0>(arg3, v3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, v12), arg1, arg17);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906854450883985407);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun d(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: vector<address>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg16);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg17), arg17);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906835497193308159);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg16));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg16));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg16));
        };
        arg8
    }

    public fun e(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: vector<address>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg17);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg18), arg18);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906836003999449087);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg17));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg17));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg17));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg17));
        };
        arg8
    }

    public fun eC_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg15, arg0, arg3, true, false, arg16, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, 0x2::coin::from_balance<T1>(v7, arg17));
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T3>(arg2, v8, 0x2::balance::value<T1>(&v7), 0, 79226673515401279992447579054, true, 0x2::tx_context::sender(arg17), 18446744073709551615, arg15, arg1, arg17);
        let v11 = 0x2::coin::into_balance<T0>(v9);
        0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(v10));
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T2>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg15, arg0, arg3, false, true, v13, 79226673515401279992447579054);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg3, 0x2::balance::zero<T0>(), v6, v16);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T0>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg3, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906856276245086207);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun eG_<T0, T1, T2, T3>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T2>(arg3, true, false, arg16, 4295048017, arg15, arg1, arg17);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, 0x2::coin::from_balance<T1>(v7, arg17));
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T3>(arg2, v8, 0x2::balance::value<T1>(&v7), 0, 79226673515401279992447579054, true, 0x2::tx_context::sender(arg17), 18446744073709551615, arg15, arg0, arg17);
        let v11 = 0x2::coin::into_balance<T0>(v9);
        0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(v10));
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T2>(arg3, false, true, v13, 79226673515401279992447579054, arg15, arg1, arg17);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T2>(arg3, v16, 0x2::balance::zero<T0>(), v6, arg1, arg17);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T0>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T2>(arg3, v3, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), arg1, arg17);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906857891152789503);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ec_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg15, arg0, arg3, false, false, arg16, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, 0x2::coin::from_balance<T1>(v7, arg17));
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T3>(arg2, v8, 0x2::balance::value<T1>(&v7), 0, 79226673515401279992447579054, true, 0x2::tx_context::sender(arg17), 18446744073709551615, arg15, arg1, arg17);
        let v11 = 0x2::coin::into_balance<T0>(v9);
        0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(v10));
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T0>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg15, arg0, arg3, true, true, v13, 4295048017);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg3, v6, 0x2::balance::zero<T0>(), v16);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T0>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906855872518160383);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun eg_<T0, T1, T2, T3>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T0>(arg3, false, false, arg16, 79226673515401279992447579054, arg15, arg1, arg17);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, 0x2::coin::from_balance<T1>(v7, arg17));
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T3>(arg2, v8, 0x2::balance::value<T1>(&v7), 0, 79226673515401279992447579054, true, 0x2::tx_context::sender(arg17), 18446744073709551615, arg15, arg0, arg17);
        let v11 = 0x2::coin::into_balance<T0>(v9);
        0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(v10));
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T0>(arg3, true, true, v13, 4295048017, arg15, arg1, arg17);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T0>(arg3, v16, v6, 0x2::balance::zero<T0>(), arg1, arg17);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T0>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T0>(arg3, v3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, v12), arg1, arg17);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906857487425863679);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun f(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: vector<address>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg18);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg19), arg19);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg20));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906836566640164863);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg18));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg18));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg18));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg18));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg19, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg18));
        };
        arg8
    }

    public fun g(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: vector<address>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg19);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg20), arg20);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg21));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906837185115455487);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg19));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg19));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg19));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg19));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg19));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg20, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg19));
        };
        arg8
    }

    public fun gC_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg15, arg0, arg3, true, false, arg16, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg15, arg1, arg17);
        let v11 = v8;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v10, 0x2::balance::zero<T0>(), v7, arg1, arg17);
        0x2::balance::destroy_zero<T1>(v9);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T2>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg15, arg0, arg3, false, true, v13, 79226673515401279992447579054);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg3, 0x2::balance::zero<T0>(), v6, v16);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T0>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg3, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906859377211473919);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun gG_<T0, T1, T2>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg15 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T2>(arg2, true, false, arg15, 4295048017, arg14, arg0, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg14, arg4, arg6, arg7, arg8, v1, arg9, arg10, arg11, arg12, arg13, arg16);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg14, arg0, arg16);
        let v11 = v8;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v10, 0x2::balance::zero<T0>(), v7, arg0, arg16);
        0x2::balance::destroy_zero<T1>(v9);
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T2>(arg2, false, true, v13, 79226673515401279992447579054, arg14, arg0, arg16);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T2>(arg2, v16, 0x2::balance::zero<T0>(), v6, arg0, arg16);
            0x2::balance::destroy_zero<T2>(v15);
            0x2::balance::join<T0>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T2>(arg2, v3, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), arg0, arg16);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906860717241270271);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun gc_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg15, arg0, arg3, false, false, arg16, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg15, arg1, arg17);
        let v11 = v8;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v10, 0x2::balance::zero<T0>(), v7, arg1, arg17);
        0x2::balance::destroy_zero<T1>(v9);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T0>(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg15, arg0, arg3, true, true, v13, 4295048017);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg3, v6, 0x2::balance::zero<T0>(), v16);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T0>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906859037909057535);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun gg_<T0, T1, T2>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg15 == 0) {
            return
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T0>(arg2, false, false, arg15, 79226673515401279992447579054, arg14, arg0, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg14, arg4, arg6, arg7, arg8, v0, arg9, arg10, arg11, arg12, arg13, arg16);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg14, arg0, arg16);
        let v11 = v8;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v10, 0x2::balance::zero<T0>(), v7, arg0, arg16);
        0x2::balance::destroy_zero<T1>(v9);
        let v12 = mmt_swap_receipt_debts(&v3);
        let v13 = 0x2::balance::value<T2>(&v6);
        if (v13 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T0>(arg2, true, true, v13, 4295048017, arg14, arg0, arg16);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T0>(arg2, v16, v6, 0x2::balance::zero<T0>(), arg0, arg16);
            0x2::balance::destroy_zero<T2>(v14);
            0x2::balance::join<T0>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T0>(arg2, v3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, v12), arg0, arg16);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 3093055295260124999, 13906860386528788479);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun h(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: vector<address>, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg20);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg21), arg21);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg22));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906837859425320959);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg20));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg20));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg20));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg20));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg20));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg20));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg21, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg20));
        };
        arg8
    }

    public fun i(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: vector<address>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg21);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg22), arg22);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg23));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906838589569761279);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg21));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg21));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg21));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg21));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg21));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg21));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg21));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg22, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg21));
        };
        arg8
    }

    public fun j(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: vector<address>, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg22);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg23), arg23);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg24));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906839375548776447);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg22));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg22));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg22));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg22));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg22));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg22));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg22));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg22));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg23, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg22));
        };
        arg8
    }

    public fun k(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: vector<address>, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg23);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg24), arg24);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg25));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906840217362366463);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg23));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg23));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg23));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg23));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg23));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg23));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg23));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg23));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg23));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg24, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg23));
        };
        arg8
    }

    public fun l(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: vector<address>, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg24);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg25), arg25);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg26));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906841115010531327);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg24));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg24));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg24));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg24));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg24));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg24));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg24));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg24));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg24));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg24));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg25, arg5, arg6, arg7, arg23, 0x1::vector::pop_back<address>(&mut arg24));
        };
        arg8
    }

    public fun m(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: vector<address>, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg25);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg26), arg26);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg27));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906842068493271039);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg23, 0x1::vector::pop_back<address>(&mut arg25));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg26, arg5, arg6, arg7, arg24, 0x1::vector::pop_back<address>(&mut arg25));
        };
        arg8
    }

    fun mmt_swap_receipt_debts(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) : u64 {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(arg0);
        if (v0 != 0) {
            v0
        } else {
            v1
        }
    }

    public fun n(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: vector<address>, arg27: &0x2::clock::Clock, arg28: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg26);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg27), arg27);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg28));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906843077810585599);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg23, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg24, 0x1::vector::pop_back<address>(&mut arg26));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg27, arg5, arg6, arg7, arg25, 0x1::vector::pop_back<address>(&mut arg26));
        };
        arg8
    }

    public fun o(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: vector<address>, arg28: &0x2::clock::Clock, arg29: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg27);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg28), arg28);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg26, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg29));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906844142962475007);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg23, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg24, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg25, 0x1::vector::pop_back<address>(&mut arg27));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg28, arg5, arg6, arg7, arg26, 0x1::vector::pop_back<address>(&mut arg27));
        };
        arg8
    }

    public fun p(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: vector<address>, arg29: &0x2::clock::Clock, arg30: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg28);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg29), arg29);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg26, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg27, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg30));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906845263948939263);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg23, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg24, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg25, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg26, 0x1::vector::pop_back<address>(&mut arg28));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg29, arg5, arg6, arg7, arg27, 0x1::vector::pop_back<address>(&mut arg28));
        };
        arg8
    }

    public fun q(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: vector<address>, arg30: &0x2::clock::Clock, arg31: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg29);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg30), arg30);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg26, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg27, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg28, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg31), arg30);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg31));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906846440769978367);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg23, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg24, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg25, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg26, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg27, 0x1::vector::pop_back<address>(&mut arg29));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 15) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg30, arg5, arg6, arg7, arg28, 0x1::vector::pop_back<address>(&mut arg29));
        };
        arg8
    }

    public fun r(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: vector<address>, arg31: &0x2::clock::Clock, arg32: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg30);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg31), arg31);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg26, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg27, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg28, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg29, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg32), arg31);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg32));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906847673425592319);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg23, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg24, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg25, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg26, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg27, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 15) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg28, 0x1::vector::pop_back<address>(&mut arg30));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 16) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg31, arg5, arg6, arg7, arg29, 0x1::vector::pop_back<address>(&mut arg30));
        };
        arg8
    }

    public fun s(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg31: vector<address>, arg32: &0x2::clock::Clock, arg33: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg31);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg32), arg32);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg26, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg27, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg28, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg29, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg30, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg33), arg32);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg33));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906848961915781119);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg23, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg24, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg25, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg26, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg27, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 15) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg28, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 16) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg29, 0x1::vector::pop_back<address>(&mut arg31));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 17) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg32, arg5, arg6, arg7, arg30, 0x1::vector::pop_back<address>(&mut arg31));
        };
        arg8
    }

    public fun t(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg31: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg32: vector<address>, arg33: &0x2::clock::Clock, arg34: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg32);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg33), arg33);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg26, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg27, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg28, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg29, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg30, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg31, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg34), arg33);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg34));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906850306240544767);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg23, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg24, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg25, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg26, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg27, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 15) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg28, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 16) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg29, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 17) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg30, 0x1::vector::pop_back<address>(&mut arg32));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 18) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg33, arg5, arg6, arg7, arg31, 0x1::vector::pop_back<address>(&mut arg32));
        };
        arg8
    }

    public fun u(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg30: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg31: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg32: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg33: vector<address>, arg34: &0x2::clock::Clock, arg35: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg12 != 0) {
            let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg9, arg10, arg11);
            let v2 = 0x1::u256::try_as_u64(v1);
            if (0x1::option::is_some<u64>(&v2) && *0x1::option::borrow<u64>(&v2) < arg12) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg33);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v3 = 0;
            let v4 = 169;
            while (v3 < 0x1::vector::length<u8>(&arg3)) {
                let v5 = 0x1::vector::borrow_mut<u8>(&mut arg3, v3);
                *v5 = *v5 ^ v4;
                let v6 = (v4 as u16) + (*v5 as u16) & 255;
                v4 = (v6 as u8);
                v3 = v3 + 1;
            };
            let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v7);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v7);
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v7, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v7) as u64)), arg34), arg34);
            let v9 = v8;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg26, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg27, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg28, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg29, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg30, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg31, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v9, arg32, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg35), arg34);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v9);
        };
        let v10 = 0x2::address::to_u256(0x2::tx_context::sender(arg35));
        assert!(((v10 & 18446744073709551615) as u64) ^ ((v10 >> 192) as u64) == 3093055295260124999, 13906851706399883263);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg17, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg18, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg19, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg20, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg21, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg22, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg23, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg24, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg25, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg26, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg27, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 15) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg28, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 16) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg29, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 17) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg30, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 18) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg31, 0x1::vector::pop_back<address>(&mut arg33));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 19) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg34, arg5, arg6, arg7, arg32, 0x1::vector::pop_back<address>(&mut arg33));
        };
        arg8
    }

    // decompiled from Move bytecode v7
}

