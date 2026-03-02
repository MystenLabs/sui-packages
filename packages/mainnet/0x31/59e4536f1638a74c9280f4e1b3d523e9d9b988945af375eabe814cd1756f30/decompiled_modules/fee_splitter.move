module 0x3159e4536f1638a74c9280f4e1b3d523e9d9b988945af375eabe814cd1756f30::fee_splitter {
    public fun collect_10<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0) / 10;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0, arg1), @0x7dca7cbd2a2e7ef9d0967d7b66e64459e8708e46fc39a26236352a1c2bc3291b);
        };
        arg0
    }

    public fun collect_2_5<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0) / 40;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0, arg1), @0x7dca7cbd2a2e7ef9d0967d7b66e64459e8708e46fc39a26236352a1c2bc3291b);
        };
        arg0
    }

    public fun collect_5<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0) / 20;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0, arg1), @0x7dca7cbd2a2e7ef9d0967d7b66e64459e8708e46fc39a26236352a1c2bc3291b);
        };
        arg0
    }

    entry fun send_fee<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x7dca7cbd2a2e7ef9d0967d7b66e64459e8708e46fc39a26236352a1c2bc3291b);
    }

    // decompiled from Move bytecode v6
}

