module 0xda53ef744e78ea0af81225ba94838272b45a944b2b46f09c6c7b09b1ed699341::db3 {
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
        let (v4, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        assert!(v1 > 0 != v3 > 0, 1);
        let (_, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v10 = v3 > 0;
        if (v10) {
            let (v11, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, 0, v3, arg5);
            v1 = v11;
        } else {
            v1 = 0xda53ef744e78ea0af81225ba94838272b45a944b2b46f09c6c7b09b1ed699341::util::div(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0xda53ef744e78ea0af81225ba94838272b45a944b2b46f09c6c7b09b1ed699341::util::mul(v4, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()));
        };
        let v14 = v1 - v1 % v8;
        assert!(v14 >= v9, 3);
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
        let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v15, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v14, v10, false, arg5, arg6);
        let v16 = if (v10) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg1, arg6)
        } else {
            0x2::coin::zero<T0>(arg6)
        };
        let v17 = v16;
        let v18 = if (v10) {
            0x2::coin::zero<T1>(arg6)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg1, arg6)
        };
        let v19 = v18;
        if (v10) {
            assert!(0x2::coin::value<T0>(&v17) >= arg4, 2);
        } else {
            assert!(0x2::coin::value<T1>(&v19) >= arg4, 2);
        };
        (v17, v19)
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

