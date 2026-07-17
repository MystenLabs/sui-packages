module 0xd9cf964cde093c4b9ab5cfc0589f0726d72abbc910446e60706233cb1d1bd4d4::utils {
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

