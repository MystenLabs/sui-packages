module 0x3b2a608141b14bb169e593facfd4df4631fb90e84e433719ed1b6d0e332b55b5::execution {
    public fun maybe_a2b<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0x2::coin::Coin<T0>>, arg4: &0x3b2a608141b14bb169e593facfd4df4631fb90e84e433719ed1b6d0e332b55b5::reader::Cursor, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg3)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x3b2a608141b14bb169e593facfd4df4631fb90e84e433719ed1b6d0e332b55b5::reader::assert_binding<T0, T1>(arg4, arg0, true);
        let v0 = 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg3));
        let (v1, _, _, _, _) = 0x3b2a608141b14bb169e593facfd4df4631fb90e84e433719ed1b6d0e332b55b5::reader::limits(arg4);
        let (v6, v7, v8) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::balance::value<T0>(&v0), 0x1::u128::max(v1, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::min_sqrt_price() + 1), arg2, arg1, arg5);
        let v9 = v8;
        let (v10, v11) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v9);
        assert!(v11 == 0, 10);
        0x2::balance::destroy_zero<T0>(v6);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg0, v9, 0x2::balance::split<T0>(&mut v0, v10), 0x2::balance::zero<T1>(), arg1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg5))
    }

    public fun maybe_b2a<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0x2::coin::Coin<T1>>, arg4: &0x3b2a608141b14bb169e593facfd4df4631fb90e84e433719ed1b6d0e332b55b5::reader::Cursor, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg3)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg3);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x3b2a608141b14bb169e593facfd4df4631fb90e84e433719ed1b6d0e332b55b5::reader::assert_binding<T0, T1>(arg4, arg0, false);
        let v0 = 0x2::coin::into_balance<T1>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg3));
        let (v1, _, _, _, _) = 0x3b2a608141b14bb169e593facfd4df4631fb90e84e433719ed1b6d0e332b55b5::reader::limits(arg4);
        let (v6, v7, v8) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::balance::value<T1>(&v0), 0x1::u128::min(v1, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::max_sqrt_price() - 1), arg2, arg1, arg5);
        let v9 = v8;
        let (v10, v11) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v9);
        assert!(v10 == 0, 10);
        0x2::balance::destroy_zero<T1>(v7);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg0, v9, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v0, v11), arg1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg5), 0x2::tx_context::sender(arg5));
        0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg5))
    }

    // decompiled from Move bytecode v7
}

