module 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::fl_dp {
    public(friend) fun base_fl_b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::coin::value<T0>(&arg2), arg3);
        fl_return_b<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg2, arg3, arg5), arg1);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit<T0>(arg4, arg2);
    }

    public(friend) fun base_fl_b_from_balance<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(arg2, arg5);
        base_fl_b<T0, T1>(arg0, arg1, v0, arg3, arg4, arg5);
    }

    public(friend) fun base_fl_q<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_greated_than(0x2::coin::value<T1>(&arg2), arg3);
        fl_return_q<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg2, arg3, arg5), arg1);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit<T1>(arg4, arg2);
    }

    public(friend) fun base_fl_q_from_balance<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T1>(arg2, arg5);
        base_fl_q<T0, T1>(arg0, arg1, v0, arg3, arg4, arg5);
    }

    public(friend) fun fl_b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2)
    }

    public(friend) fun fl_b_checked<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = fl_b<T0, T1>(arg0, arg1, arg2);
        let v2 = v0;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_equals(0x2::coin::value<T0>(&v2), arg1);
        (v2, v1)
    }

    public(friend) fun fl_q<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2)
    }

    public(friend) fun fl_q_checked<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = fl_q<T0, T1>(arg0, arg1, arg2);
        let v2 = v0;
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount_equals(0x2::coin::value<T1>(&v2), arg1);
        (v2, v1)
    }

    public(friend) fun fl_return_b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, arg1, arg2);
    }

    public(friend) fun fl_return_q<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

