module 0xfd9ccac3fafa6f7ebe43eef76fb3262ba86f143d9aa068b93b9cbc1473305198::o {
    public fun obr<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = sw_bq<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::da<T0>(v1, arg5);
        (v0, v2)
    }

    public fun obv<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext, arg6: &mut 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::Vault<T0>) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = sw_bq<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::destroy_or_deposit_balance<T0>(arg6, v1);
        (v0, v2)
    }

    public fun oqr<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = sw_qb<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::da<T1>(v1, arg5);
        (v0, v2)
    }

    public fun oqv<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext, arg6: &mut 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::Vault<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = sw_qb<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::destroy_or_deposit_balance<T1>(arg6, v1);
        (v0, v2)
    }

    fun sw_bq<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_from_balance<T0>(arg1, arg5), 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg5), arg3, arg4, arg5);
        (0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_to_balance<T1>(v1), 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_to_balance<T0>(v0), 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_to_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2))
    }

    fun sw_qb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_from_balance<T1>(arg1, arg5), 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg5), arg3, arg4, arg5);
        (0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_to_balance<T0>(v0), 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_to_balance<T1>(v1), 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_to_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2))
    }

    // decompiled from Move bytecode v7
}

