module 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::bluefin {
    public fun swap_a2b<T0, T1>(arg0: &mut 0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::Vault, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::take<0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::Witness, T0, T1>(arg0, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::witness(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v2 = v0;
        let (v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg1, arg2, true, true, arg3, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::bound(arg5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), true));
        let v6 = v5;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v6)), 0x2::balance::zero<T1>(), v6);
        0x2::balance::join<T0>(&mut v2, v3);
        0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::settle<0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::Witness, T0, T1>(arg0, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::witness(), v1, v2, v4);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::Vault, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::take<0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::Witness, T1, T0>(arg0, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::witness(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v2 = v0;
        let (v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg1, arg2, false, true, arg3, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::bound(arg5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), false));
        let v6 = v5;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v6)), v6);
        0x2::balance::join<T1>(&mut v2, v4);
        0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::settle<0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::Witness, T1, T0>(arg0, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::witness(), v1, v2, v3);
    }

    // decompiled from Move bytecode v7
}

