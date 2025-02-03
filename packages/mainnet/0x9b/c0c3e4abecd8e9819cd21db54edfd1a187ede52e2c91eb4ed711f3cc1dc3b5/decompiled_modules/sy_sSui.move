module 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy_sSui {
    public entry fun create<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) {
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::create<T0>(9, b"sSUI", b"scallop sSUI", arg0);
    }

    public fun deposit<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>> {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::deposit<T0>(v0, arg1, 0x2::balance::value<T0>(&v0), arg2, arg3)
    }

    public fun redeem<T0: drop>(arg0: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>, arg1: u64, arg2: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(arg0);
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::redeem<T0>(v0, arg1, 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&v0), arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

