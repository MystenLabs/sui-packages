module 0x814b4a5e9089296a7d1d46f1d2a9a3385fdd5d11b5d971dc45bca56c4723e0a6::z {
    public fun A<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, false, arg14, 79226673515401279992447579055, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T0, T1>(arg13, arg3, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg15);
        let v6 = v5;
        let v7 = v4;
        if (0x2::balance::value<T0>(&v6) == 0) {
            0x2::balance::destroy_zero<T0>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14930523562255814326, 9223376396246581247);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun B<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg14, 4295048016, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T1, T0>(arg13, arg3, arg5, arg6, arg7, v1, arg8, arg9, arg10, arg11, arg12, arg15);
        let v6 = v5;
        let v7 = v4;
        if (0x2::balance::value<T1>(&v6) == 0) {
            0x2::balance::destroy_zero<T1>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14930523562255814326, 9223376653944619007);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun E<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 79226673515401279992447579055;
        let v1 = false;
        if (arg15 == 0) {
            return
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, v1, false, arg15, v0, arg14);
        let v5 = v4;
        0x2::balance::destroy_zero<T0>(v3);
        let (v6, v7) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T2, T1>(arg14, arg4, arg6, arg7, arg8, v2, arg9, arg10, arg11, arg12, arg13, arg16);
        let v8 = v7;
        let v9 = v6;
        if (0x2::balance::value<T2>(&v8) == 0) {
            0x2::balance::destroy_zero<T2>(v8);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v8, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, v1, true, 0x2::balance::value<T1>(&v9), v0, arg14);
        let v13 = v10;
        0x2::balance::destroy_zero<T1>(v11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v9, v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v5)), v5);
        let v14 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v14 & 18446744073709551615) as u64) ^ ((v14 >> 64 & 18446744073709551615) as u64) ^ ((v14 >> 128 & 18446744073709551615) as u64) ^ ((v14 >> 192) as u64) == 14930523562255814326, 9223376941707427839);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun F<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg15 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, true, false, arg15, 4295048016, arg14);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T2, T1>(arg14, arg4, arg6, arg7, arg8, v1, arg9, arg10, arg11, arg12, arg13, arg16);
        let v6 = v5;
        let v7 = v4;
        if (0x2::balance::value<T2>(&v6) == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v7), 79226673515401279992447579055, arg14);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::split<T0>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14930523562255814326, 9223377229470236671);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun G<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg15 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, false, arg15, 79226673515401279992447579055, arg14);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T2, T0>(arg14, arg4, arg6, arg7, arg8, v0, arg9, arg10, arg11, arg12, arg13, arg16);
        let v6 = v5;
        let v7 = v4;
        if (0x2::balance::value<T2>(&v6) == 0) {
            0x2::balance::destroy_zero<T2>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v6, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&v7), 4295048016, arg14);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v3)), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14930523562255814326, 9223377517233045503);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun H<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &0x2::clock::Clock, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 4295048016;
        let v1 = true;
        if (arg15 == 0) {
            return
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, v1, false, arg15, v0, arg14);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v2);
        let (v6, v7) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T2, T0>(arg14, arg4, arg6, arg7, arg8, v3, arg9, arg10, arg11, arg12, arg13, arg16);
        let v8 = v7;
        let v9 = v6;
        if (0x2::balance::value<T2>(&v8) == 0) {
            0x2::balance::destroy_zero<T2>(v8);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v8, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, v1, true, 0x2::balance::value<T0>(&v9), v0, arg14);
        let v13 = v11;
        0x2::balance::destroy_zero<T0>(v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v9, 0x2::balance::zero<T1>(), v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v5)), 0x2::balance::zero<T2>(), v5);
        let v14 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v14 & 18446744073709551615) as u64) ^ ((v14 >> 64 & 18446744073709551615) as u64) ^ ((v14 >> 128 & 18446744073709551615) as u64) ^ ((v14 >> 192) as u64) == 14930523562255814326, 9223377804995854335);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v13, arg16), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun b(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: vector<address>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg10);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 14930523562255814326, 9223372298847780863);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg11), arg11);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg12), arg11);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14930523562255814326, 9223372376157192191);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg11, arg5, arg6, arg7, arg9, 0x1::vector::pop_back<address>(&mut arg10));
        };
        arg8
    }

    public fun c(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: vector<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg11);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 14930523562255814326, 9223372616675360767);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg12), arg12);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg13), arg12);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg13), arg12);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14930523562255814326, 9223372715459608575);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg5, arg6, arg7, arg9, 0x1::vector::pop_back<address>(&mut arg11));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg5, arg6, arg7, arg10, 0x1::vector::pop_back<address>(&mut arg11));
        };
        arg8
    }

    public fun d(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: vector<address>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg12);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 14930523562255814326, 9223372990337515519);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg13), arg13);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14930523562255814326, 9223373110596599807);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg5, arg6, arg7, arg9, 0x1::vector::pop_back<address>(&mut arg12));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg5, arg6, arg7, arg10, 0x1::vector::pop_back<address>(&mut arg12));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg5, arg6, arg7, arg11, 0x1::vector::pop_back<address>(&mut arg12));
        };
        arg8
    }

    public fun e(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: vector<address>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg13);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 14930523562255814326, 9223373419834245119);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg14), arg14);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14930523562255814326, 9223373561568165887);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg5, arg6, arg7, arg9, 0x1::vector::pop_back<address>(&mut arg13));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg5, arg6, arg7, arg10, 0x1::vector::pop_back<address>(&mut arg13));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg5, arg6, arg7, arg11, 0x1::vector::pop_back<address>(&mut arg13));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg14, arg5, arg6, arg7, arg12, 0x1::vector::pop_back<address>(&mut arg13));
        };
        arg8
    }

    public fun f(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: vector<address>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg14);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 14930523562255814326, 9223373905165549567);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg15), arg15);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14930523562255814326, 9223374068374306815);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg5, arg6, arg7, arg9, 0x1::vector::pop_back<address>(&mut arg14));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg5, arg6, arg7, arg10, 0x1::vector::pop_back<address>(&mut arg14));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg5, arg6, arg7, arg11, 0x1::vector::pop_back<address>(&mut arg14));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg5, arg6, arg7, arg12, 0x1::vector::pop_back<address>(&mut arg14));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg15, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg14));
        };
        arg8
    }

    public fun g(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: vector<address>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg15);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 14930523562255814326, 9223374446331428863);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg16), arg16);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14930523562255814326, 9223374631015022591);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg5, arg6, arg7, arg9, 0x1::vector::pop_back<address>(&mut arg15));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg5, arg6, arg7, arg10, 0x1::vector::pop_back<address>(&mut arg15));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg5, arg6, arg7, arg11, 0x1::vector::pop_back<address>(&mut arg15));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg5, arg6, arg7, arg12, 0x1::vector::pop_back<address>(&mut arg15));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg15));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg16, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg15));
        };
        arg8
    }

    public fun h(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: vector<address>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg16);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 14930523562255814326, 9223375043331883007);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg17), arg17);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14930523562255814326, 9223375249490313215);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg5, arg6, arg7, arg9, 0x1::vector::pop_back<address>(&mut arg16));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg5, arg6, arg7, arg10, 0x1::vector::pop_back<address>(&mut arg16));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg5, arg6, arg7, arg11, 0x1::vector::pop_back<address>(&mut arg16));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg5, arg6, arg7, arg12, 0x1::vector::pop_back<address>(&mut arg16));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg16));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg16));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg17, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg16));
        };
        arg8
    }

    public fun i(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: vector<address>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        0x1::vector::reverse<address>(&mut arg17);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 14930523562255814326, 9223375696166911999);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg18), arg18);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14930523562255814326, 9223375923800178687);
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg9, 0x1::vector::pop_back<address>(&mut arg17));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg10, 0x1::vector::pop_back<address>(&mut arg17));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg11, 0x1::vector::pop_back<address>(&mut arg17));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg12, 0x1::vector::pop_back<address>(&mut arg17));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg13, 0x1::vector::pop_back<address>(&mut arg17));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg14, 0x1::vector::pop_back<address>(&mut arg17));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg15, 0x1::vector::pop_back<address>(&mut arg17));
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg18, arg5, arg6, arg7, arg16, 0x1::vector::pop_back<address>(&mut arg17));
        };
        arg8
    }

    // decompiled from Move bytecode v7
}

