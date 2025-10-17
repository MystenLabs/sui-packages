module 0x5595f034fc7150715206dcab82c0f527422482ee050811fa58fe5bcb5680d6b1::db3 {
    fun swap<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = v0;
        if (v0 > 0) {
            v1 = v0 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        };
        let v2 = 0x2::coin::value<T1>(&arg3);
        let v3 = v2;
        if (v2 > 0) {
            v3 = v2 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        };
        assert!(v1 > 0 != v3 > 0, 1);
        let (_, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v7 = v3 > 0;
        if (v7) {
            let (v8, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, v3, arg5);
            v1 = v8;
        } else {
            let v11 = v1 % v5;
            v1 = v1 - v11;
        };
        assert!(v1 >= v6, 3);
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg2, arg6);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        if (0x2::coin::value<T1>(&arg3) > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, arg3, arg6);
        } else {
            0x2::coin::destroy_zero<T1>(arg3);
        };
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v12, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v1, v7, false, arg5, arg6);
        let v13 = if (v7) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg1, arg6)
        } else {
            0x2::coin::zero<T0>(arg6)
        };
        let v14 = v13;
        let v15 = if (v7) {
            0x2::coin::zero<T1>(arg6)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg1, arg6)
        };
        let v16 = v15;
        if (v7) {
            assert!(0x2::coin::value<T0>(&v14) >= arg4, 2);
        } else {
            assert!(0x2::coin::value<T1>(&v16) >= arg4, 2);
        };
        (v14, v16)
    }

    public fun b2q<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let (v1, v2) = swap<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg5);
        0x2::coin::destroy_zero<T0>(v1);
        v2
    }

    public fun q2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let (v1, v2) = swap<T0, T1>(arg0, arg1, v0, arg2, arg3, arg4, arg5);
        0x2::coin::destroy_zero<T1>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

