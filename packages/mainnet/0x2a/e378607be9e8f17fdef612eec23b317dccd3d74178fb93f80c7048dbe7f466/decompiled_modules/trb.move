module 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::trb {
    public fun ta<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::get_coin_vec<T0>(arg0), 0x2::coin::value<T0>(&arg0), arg2, arg3, true, arg5, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::get_deadline(arg6), arg6, arg4, arg7)
    }

    public fun ta_<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = ta<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit<T0>(arg7, v1);
        v0
    }

    public fun ta__<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: 0x2::coin::Coin<T1>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::join<T1>(ta_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9), arg8)
    }

    public fun ta_balance_<T0, T1, T2>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(arg0, arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T1>(ta_<T0, T1, T2>(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8))
    }

    public fun ta_balance__<T0, T1, T2>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg8: 0x2::balance::Balance<T1>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(arg0, arg9);
        let v1 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T1>(arg8, arg9);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T1>(ta__<T0, T1, T2>(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, arg9))
    }

    public fun tb<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::get_coin_vec<T1>(arg0), 0x2::coin::value<T1>(&arg0), arg2, arg3, true, arg5, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::get_deadline(arg6), arg6, arg4, arg7)
    }

    public fun tb_<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = tb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit<T1>(arg7, v1);
        v0
    }

    public fun tb__<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::join<T0>(tb_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9), arg8)
    }

    public fun tb_balance_<T0, T1, T2>(arg0: 0x2::balance::Balance<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T1>(arg0, arg8);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T0>(tb_<T0, T1, T2>(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8))
    }

    public fun tb_balance__<T0, T1, T2>(arg0: 0x2::balance::Balance<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg8: 0x2::balance::Balance<T0>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T1>(arg0, arg9);
        let v1 = 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(arg8, arg9);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T0>(tb__<T0, T1, T2>(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, arg9))
    }

    // decompiled from Move bytecode v7
}

