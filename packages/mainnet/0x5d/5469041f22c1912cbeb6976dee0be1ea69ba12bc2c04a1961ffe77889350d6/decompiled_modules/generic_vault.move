module 0x5d5469041f22c1912cbeb6976dee0be1ea69ba12bc2c04a1961ffe77889350d6::generic_vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        total: 0x2::balance::Balance<T0>,
    }

    public entry fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id    : 0x2::object::new(arg0),
            total : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.total, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun total<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total)
    }

    public entry fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

