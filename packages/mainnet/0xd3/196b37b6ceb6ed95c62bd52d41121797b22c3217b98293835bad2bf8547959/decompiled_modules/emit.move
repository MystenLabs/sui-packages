module 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::emit {
    public fun emit_virtual_balances<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T3>, arg4: u64, arg5: u64, arg6: u128, arg7: u128) {
        let v0 = 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::dex_integration::get_btc_usdt_sqrtprice<T0, T1, T2>(arg0, arg1);
        let (v1, v2) = 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::suilend_integration::get_supply_debt_check_fee<T3>(arg2, arg3, arg4, arg5);
        0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::vault_integration::emit_virtual_balances(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::vault_integration::vault_sqrtprice(v0, 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::vault_integration::deviation(v0, v1, v2, arg6), arg7), v1, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

