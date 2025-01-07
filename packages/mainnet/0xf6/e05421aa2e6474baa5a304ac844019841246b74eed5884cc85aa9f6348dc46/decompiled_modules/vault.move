module 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        reserve: 0x2::coin::Coin<T0>,
    }

    public fun value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.reserve)
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        Vault<T0>{
            id      : 0x2::object::new(arg0),
            reserve : 0x2::coin::zero<T0>(arg0),
        }
    }

    public entry fun create_and_transfer<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Vault<T0>>(new<T0>(arg1), arg0);
    }

    public entry fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.reserve, arg1);
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(&mut arg0.reserve, arg1, arg2)
    }

    public entry fun withdraw_and_transfer<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

