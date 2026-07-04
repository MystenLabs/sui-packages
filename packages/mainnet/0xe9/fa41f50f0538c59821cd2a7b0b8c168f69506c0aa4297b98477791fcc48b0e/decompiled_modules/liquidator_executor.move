module 0xe9fa41f50f0538c59821cd2a7b0b8c168f69506c0aa4297b98477791fcc48b0e::liquidator_executor {
    entry fun liquidate<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: address, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg12: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg13: u64, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg16: u128, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_loan<T0, T2>(arg11, arg13, 0, arg12, arg18);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg7, arg8, arg9, arg10, arg18);
        let v6 = v4;
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg14, arg15, true, true, 0x2::balance::value<T1>(&v6), arg16, arg0);
        let v10 = v9;
        0x2::balance::destroy_zero<T1>(v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg14, arg15, 0x2::balance::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v10)), 0x2::balance::zero<T0>(), v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg18), 0x2::tx_context::sender(arg18));
        let v11 = v8;
        0x2::balance::join<T0>(&mut v11, v5);
        let (v12, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_loan<T0, T2>(arg11, v3, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), arg12, arg18);
        assert!(0x2::balance::value<T0>(&v11) >= arg17, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg18), 0x2::tx_context::sender(arg18));
    }

    entry fun liquidate_2hop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: address, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg12: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg13: u64, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg16: u128, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg18: u128, arg19: u64, arg20: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_loan<T0, T2>(arg11, arg13, 0, arg12, arg20);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg7, arg8, arg9, arg10, arg20);
        let v6 = v4;
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg14, arg15, false, true, 0x2::balance::value<T1>(&v6), arg16, arg0);
        let v10 = v9;
        let v11 = v7;
        0x2::balance::destroy_zero<T1>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg14, arg15, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v10)), v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg20), 0x2::tx_context::sender(arg20));
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg14, arg17, true, true, 0x2::balance::value<T2>(&v11), arg18, arg0);
        let v15 = v14;
        0x2::balance::destroy_zero<T2>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg14, arg17, 0x2::balance::split<T2>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v15)), 0x2::balance::zero<T0>(), v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v11, arg20), 0x2::tx_context::sender(arg20));
        let v16 = v13;
        0x2::balance::join<T0>(&mut v16, v5);
        let (v17, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_loan<T0, T2>(arg11, v3, 0x2::balance::split<T0>(&mut v16, v17), 0x2::balance::zero<T2>(), arg12, arg20);
        assert!(0x2::balance::value<T0>(&v16) >= arg19, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg20), 0x2::tx_context::sender(arg20));
    }

    // decompiled from Move bytecode v7
}

