module 0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::deposit {
    public fun deposit_a<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::vault::Vault<T0, T1>, arg3: &0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::vault::OwnerKey, arg4: 0x2::coin::Coin<T0>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::vault::assert_ownership<T0, T1>(arg3, arg2);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, false, true, 0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::vault::get_deposit_flash_swap_amount<T0, T1>(arg2, 0x2::coin::value<T0>(&arg4)), 79226673515401279992447579055, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v0, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::vault::deposit<T0, T1>(arg2, arg4, arg5, arg6, arg7, arg8, arg9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg10, arg11)), v3);
    }

    public fun deposit_b<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::vault::Vault<T0, T1>, arg3: &0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::vault::OwnerKey, arg4: 0x2::coin::Coin<T0>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::vault::assert_ownership<T0, T1>(arg3, arg2);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg0, true, true, 0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::vault::get_deposit_flash_swap_amount<T0, T1>(arg2, 0x2::coin::value<T0>(&arg4)), 4295048016, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v1, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg0, 0x2::coin::into_balance<T1>(0x5e98b49939b89678835e000ba439a33233215b8f59747909d1984e67cdaf2a0e::vault::deposit<T0, T1>(arg2, arg4, arg5, arg6, arg7, arg8, arg9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v3), arg10, arg11)), 0x2::balance::zero<T0>(), v3);
    }

    // decompiled from Move bytecode v6
}

