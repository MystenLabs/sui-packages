module 0x3c89fb57737a49b87b6488ad528f7828282dcf47c4298c1a5ec6fc0b988e2190::treasury {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun create<T0>(arg0: &0x3c89fb57737a49b87b6488ad528f7828282dcf47c4298c1a5ec6fc0b988e2190::config::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public(friend) fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun withdraw<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

