module 0x5f9730e434efcae333d2ed5d999169977e143b52dd18154b2182ab975add7e81::utils {
    public fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x1::option::Option<address>, arg2: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            let v0 = if (0x1::option::is_some<address>(&arg1)) {
                0x1::option::destroy_some<address>(arg1)
            } else {
                0x1::option::destroy_none<address>(arg1);
                0x2::tx_context::sender(arg2)
            };
            0x2::coin::send_funds<T0>(arg0, v0);
        };
    }

    // decompiled from Move bytecode v7
}

