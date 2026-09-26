module 0xf28d63c523f1eef1b6917be1e885c6748753535d92861787f68518936ed78b3b::m {
    fun assert_no_deep_side<T0, T1>() {
        let v0 = 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        assert!(0x1::type_name::with_defining_ids<T0>() != v0 && 0x1::type_name::with_defining_ids<T1>() != v0, 2);
    }

    public fun da<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert_no_deep_side<T0, T1>();
        let v0 = sized<T0, T1>(arg0, 0x2::balance::value<T0>(&arg2));
        taker<T0, T1, T0, T1>(arg0, arg1, arg2, v0, false, arg3, arg4)
    }

    public fun db<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_no_deep_side<T0, T1>();
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, 0x2::balance::value<T1>(&arg2), arg3);
        let v3 = sized<T0, T1>(arg0, v0);
        taker<T0, T1, T1, T0>(arg0, arg1, arg2, v3, true, arg3, arg4)
    }

    fun sized<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v3 = arg1 - arg1 % v1;
        assert!(v3 >= v2, 1);
        v3
    }

    fun taker<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T2>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg1, 0x2::coin::from_balance<T2>(arg2, arg6), arg6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg3, arg4, true, arg5, arg6);
        0x2::balance::send_funds<T2>(0x2::coin::into_balance<T2>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T2>(arg1, arg6)), 0x2::tx_context::sender(arg6));
        0x2::coin::into_balance<T3>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T3>(arg1, arg6))
    }

    // decompiled from Move bytecode v7
}

