module 0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self {
    public fun expect<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (v0 < arg1) {
            abort v0 << 8 | 1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun max_sqrt_price() : u128 {
        79226673515401279992447579055
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    public fun probe_value<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 < arg1) {
            abort v0 << 8 | 1
        };
        v0
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

