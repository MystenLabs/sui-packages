module 0x5fff162f0fb9e5ef821e36302935d6b4753a282af8c66a7e7121b375237fa525::vault {
    struct RecoverableVault<phantom T0> has key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
    }

    public fun recoverable_value<T0>(arg0: &RecoverableVault<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.coin)
    }

    public fun unwrap_recoverable<T0>(arg0: RecoverableVault<T0>, arg1: address) {
        let RecoverableVault {
            id   : v0,
            coin : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1);
    }

    public fun wrap_recoverable<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RecoverableVault<T0>{
            id   : 0x2::object::new(arg2),
            coin : arg0,
        };
        0x2::transfer::transfer<RecoverableVault<T0>>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

