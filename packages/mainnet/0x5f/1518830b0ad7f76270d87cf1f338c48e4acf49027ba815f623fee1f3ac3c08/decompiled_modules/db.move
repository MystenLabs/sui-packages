module 0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::db {
    public fun sab<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::util::tod<T0>(v0, 0x2::tx_context::sender(arg4));
        0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::util::tod<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, 0x2::tx_context::sender(arg4));
        v1
    }

    public fun sba<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::util::tod<T1>(v1, 0x2::tx_context::sender(arg4));
        0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::util::tod<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, 0x2::tx_context::sender(arg4));
        v0
    }

    // decompiled from Move bytecode v7
}

