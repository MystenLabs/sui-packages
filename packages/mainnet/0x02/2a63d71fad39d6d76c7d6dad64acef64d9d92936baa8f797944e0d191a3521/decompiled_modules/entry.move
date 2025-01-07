module 0xee3fbd4c17539244536ba4dff8e96a25d1051739bf83257129bba2d8e0e7be96::entry {
    struct WrappedCoin<T0> {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
    }

    entry fun entry_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public entry fun public_entry_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun unwrap<T0>(arg0: WrappedCoin<T0>) : 0x2::coin::Coin<T0> {
        let WrappedCoin {
            id   : v0,
            coin : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun wrap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : WrappedCoin<T0> {
        WrappedCoin<T0>{
            id   : 0x2::object::new(arg1),
            coin : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

