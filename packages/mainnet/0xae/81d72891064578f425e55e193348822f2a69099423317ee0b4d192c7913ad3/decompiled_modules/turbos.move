module 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::turbos {
    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::Vault, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::take<0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::Witness, T0, T1>(arg0, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::witness(), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v2 = v0;
        let (v3, v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg8), true, (arg3 as u128), true, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::bound(arg5, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2), true), arg7, arg1, arg8);
        let v6 = v5;
        let (_, _, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v6);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v9), arg8), 0x2::coin::zero<T1>(arg8), v6, arg1);
        0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v3));
        0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::settle<0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::Witness, T0, T1>(arg0, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::witness(), v1, v2, 0x2::coin::into_balance<T1>(v4));
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::Vault, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::take<0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::Witness, T1, T0>(arg0, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::witness(), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v2 = v0;
        let (v3, v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg8), false, (arg3 as u128), true, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::bound(arg5, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2), false), arg7, arg1, arg8);
        let v6 = v5;
        let (_, _, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v6);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg2, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v9), arg8), v6, arg1);
        0x2::balance::join<T1>(&mut v2, 0x2::coin::into_balance<T1>(v4));
        0xda00b7a91519aa764421569217300672686692fb250c84766e5fec96e8c30ae2::vault::settle<0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::Witness, T1, T0>(arg0, 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router::witness(), v1, v2, 0x2::coin::into_balance<T0>(v3));
    }

    // decompiled from Move bytecode v7
}

