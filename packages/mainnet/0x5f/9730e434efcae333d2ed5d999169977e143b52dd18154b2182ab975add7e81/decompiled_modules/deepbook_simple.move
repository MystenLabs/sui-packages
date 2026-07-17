module 0x5f9730e434efcae333d2ed5d999169977e143b52dd18154b2182ab975add7e81::deepbook_simple {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg0, arg1, 0x2::coin::zero<T1>(arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x5f9730e434efcae333d2ed5d999169977e143b52dd18154b2182ab975add7e81::utils::destroy_or_transfer<T0>(v0, 0x1::option::none<address>(), arg3);
        0x5f9730e434efcae333d2ed5d999169977e143b52dd18154b2182ab975add7e81::utils::destroy_or_transfer<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, 0x1::option::none<address>(), arg3);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg0, 0x2::coin::zero<T0>(arg3), arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x5f9730e434efcae333d2ed5d999169977e143b52dd18154b2182ab975add7e81::utils::destroy_or_transfer<T1>(v1, 0x1::option::none<address>(), arg3);
        0x5f9730e434efcae333d2ed5d999169977e143b52dd18154b2182ab975add7e81::utils::destroy_or_transfer<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, 0x1::option::none<address>(), arg3);
        v0
    }

    // decompiled from Move bytecode v7
}

