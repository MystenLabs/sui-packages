module 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::entry {
    public fun exact_in<T0, T1, T2, T3>(arg0: u64, arg1: bool, arg2: u128, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T3>, arg7: u64, arg8: u64, arg9: u128, arg10: u128) : u64 {
        let v0 = 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::dex_integration::get_btc_usdt_sqrtprice<T0, T1, T2>(arg3, arg4);
        let (v1, v2) = 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::suilend_integration::get_supply_debt_check_fee<T3>(arg5, arg6, arg7, arg8);
        let v3 = 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::vault_integration::vault_sqrtprice(v0, 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::vault_integration::deviation(v0, v1, v2, arg9), arg10);
        let v4 = 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::swap::exact_in(arg1, arg0 - 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::floor(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(arg0), arg2)), v3, 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::vault_integration::liquidity(v3, v1, arg9, arg10));
        0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::vault_integration::emit_swap(arg0, v4, arg1, v1, v2, v0, arg10, arg9, arg2);
        v4
    }

    // decompiled from Move bytecode v6
}

