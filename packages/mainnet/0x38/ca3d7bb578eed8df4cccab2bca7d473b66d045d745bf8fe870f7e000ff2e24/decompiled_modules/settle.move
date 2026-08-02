module 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::settle {
    public entry fun cetus_fee_probe<T0>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg1, true, true, arg2);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0);
        assert!(v1 == 0, 200000 + v1);
    }

    public entry fun deepbook_quote_flash_probe<T0, T1>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, arg2, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg1, v0, v1);
    }

    public entry fun flash_probe<T0, T1>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, arg2, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg1, v0, v1);
    }

    public entry fun swap_cert_sui(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg2, arg1, 0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&arg1), 0, arg3), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
    }

    public entry fun swap_sui_usdc<T0, T1>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: 0x2::coin::Coin<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg3, false, true, v1);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, false, true, v1 - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v2), 79226673515401279992447579055, arg4);
        let v6 = v5;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6);
        assert!(v7 <= v1, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v0, v7), v6);
        0x2::balance::destroy_zero<T1>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg5), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg5), 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::consts::profit_wallet());
    }

    // decompiled from Move bytecode v7
}

