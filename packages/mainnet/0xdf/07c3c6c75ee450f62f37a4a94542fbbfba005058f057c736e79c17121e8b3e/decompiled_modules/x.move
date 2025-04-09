module 0xdf07c3c6c75ee450f62f37a4a94542fbbfba005058f057c736e79c17121e8b3e::x {
    public fun AAA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg16, 4295048017, arg15);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg15);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v11), 4295048017, arg15);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, true, v17, 79226673515401279992447579054, arg15);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223374738389204991);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AAC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223377452808536063);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AAa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg16, 79226673515401279992447579054, arg15);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg15);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T3>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v11), 4295048017, arg15);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T3>(arg0, arg2, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, true, v17, 4295048017, arg15);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223374407676723199);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AAc<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T3>(arg0, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T3>(arg0, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223377113506119679);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ACA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg16, arg1, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223380167227867135);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ACC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg16, arg1, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223382881647198207);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ACa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T3>(arg16, arg1, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T3>(arg1, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223379827925450751);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ACc<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T3>(arg16, arg1, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T3>(arg1, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223382542344781823);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AaA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg16, 4295048017, arg15);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg15);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054, arg15);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, true, v17, 79226673515401279992447579054, arg15);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223374076964241407);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AaC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223376774203703295);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Aaa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg16, 79226673515401279992447579054, arg15);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg15);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054, arg15);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T1>(arg0, arg2, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, true, v17, 4295048017, arg15);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223373746251759615);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Aac<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T1>(arg0, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T1>(arg0, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223376434901286911);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AcA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg16, arg1, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223379488623034367);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AcC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg16, arg1, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223382203042365439);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Aca<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T1>(arg16, arg1, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T1>(arg1, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223379149320617983);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Acc<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017, arg16);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T1>(arg16, arg1, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T1>(arg1, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223381863739949055);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CAA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223385596066529279);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CAC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223388310485860351);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CAa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T3>(arg0, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T3>(arg0, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223385256764112895);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CAc<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T3>(arg0, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T3>(arg0, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223387971183443967);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CCA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg16, arg1, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223391024905191423);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

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
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223393670605045759);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CCa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T3>(arg16, arg1, arg3, true, true, 0x2::balance::value<T1>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T3>(arg1, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223390685602775039);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
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
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223393339892563967);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CaA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223384917461696511);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CaC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223387631881027583);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Caa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T1>(arg0, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T1>(arg0, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223384578159280127);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Cac<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T1>(arg0, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T1>(arg0, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223387292578611199);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CcA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T0>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg16, arg1, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223390346300358655);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
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
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223393009180082175);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Cca<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T0>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T1>(arg16, arg1, arg3, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T1>(arg1, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223390006997942271);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
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
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223392678467600383);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aAA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg16, 4295048017, arg15);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg15);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v11), 4295048017, arg15);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, true, v17, 79226673515401279992447579054, arg15);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223373415539277823);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aAC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223376095598870527);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aAa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg16, 79226673515401279992447579054, arg15);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg15);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T3>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v11), 4295048017, arg15);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T3>(arg0, arg2, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, true, v17, 4295048017, arg15);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223373084826796031);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aAc<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T3>(arg0, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T3>(arg0, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223375756296454143);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aCA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg16, arg1, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg1, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223378810018201599);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aCC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg16, arg1, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg1, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223381524437532671);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aCa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T3>(arg16, arg1, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T3>(arg1, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223378470715785215);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aCc<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T3>(arg16, arg1, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T3>(arg1, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223381185135116287);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aaA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg16, 4295048017, arg15);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg15, arg5, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg15);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054, arg15);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, true, v17, 79226673515401279992447579054, arg15);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223372754114314239);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aaC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223375416994037759);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aaa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        if (arg16 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg16, 79226673515401279992447579054, arg15);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg15, arg5, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg17);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg15);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T0>(arg0, arg2, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054, arg15);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T0>(arg0, arg2, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, true, v17, 4295048017, arg15);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223372423401832447);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aac<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T0>(arg0, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T0>(arg0, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223375077691621375);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun acA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg16, arg1, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg1, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223378131413368831);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun acC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg16, arg1, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg1, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223380845832699903);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aca<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T0>(arg16, arg1, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T0>(arg1, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223377792110952447);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun acc<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054, arg16);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T0>(arg16, arg1, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T0>(arg1, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223380506530283519);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cAA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223384238856863743);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cAC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223386953276194815);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cAa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T3>(arg0, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T3>(arg0, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223383899554447359);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cAc<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T3>(arg0, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017, arg16);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T3>(arg0, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223386613973778431);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cCA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg16, arg1, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg1, arg3, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223389667695525887);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
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
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223392347755118591);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cCa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T3>(arg16, arg1, arg3, true, true, 0x2::balance::value<T0>(&v11), 4295048017);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T3>(arg1, arg3, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223389328393109503);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
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
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223392017042636799);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun caA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223383560252030975);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun caC<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, false, arg17, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, true, v17, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T3>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223386274671362047);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun caa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T0>(arg0, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T0>(arg0, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223383220949614591);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cac<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, false, false, arg17, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T0>(arg0, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054, arg16);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T0>(arg0, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg16, arg1, arg4, true, true, v17, 4295048017);
            0x2::balance::destroy_zero<T2>(v18);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223385935368945663);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ccA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, false, arg17, 4295048017, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T3, T1>(arg16, arg6, arg8, arg9, arg10, v1, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg16, arg1, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg1, arg3, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T3>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T3>(v6);
        } else if (0x2::balance::value<T2>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, true, v17, 79226673515401279992447579054, arg16);
            0x2::balance::destroy_zero<T3>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), v6, v20);
            0x2::balance::join<T2>(&mut v15, v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223388989090693119);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
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
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223391686330155007);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cca<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: address, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        if (arg17 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, false, false, arg17, 79226673515401279992447579054, arg16);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T2, T1>(arg16, arg6, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg18);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg1, arg2, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T3, T0>(arg16, arg1, arg3, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T3, T0>(arg1, arg3, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        let v17 = 0x2::balance::value<T2>(&v6);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else if (0x2::balance::value<T3>(&v15) < v16) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg4, true, true, v17, 4295048017, arg16);
            0x2::balance::destroy_zero<T2>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, v6, 0x2::balance::zero<T3>(), v20);
            0x2::balance::join<T3>(&mut v15, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v21 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223388649788276735);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg18), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
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
        assert!(((v21 & 18446744073709551615) as u64) ^ ((v21 >> 192) as u64) == 3093055295260124999, 9223391355617673215);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg17), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    // decompiled from Move bytecode v7
}

