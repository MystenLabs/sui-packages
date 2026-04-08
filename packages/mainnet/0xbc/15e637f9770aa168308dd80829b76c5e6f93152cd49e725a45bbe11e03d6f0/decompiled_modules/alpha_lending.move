module 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::alpha_lending {
    struct LendingProtocol has key {
        id: 0x2::object::UID,
    }

    struct Promise {
        id: 0x2::object::UID,
    }

    public fun add_collateral<T0>(arg0: &mut LendingProtocol, arg1: &mut 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun fulfill_promise<T0>(arg0: &mut LendingProtocol, arg1: Promise, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun remove_collateral<T0>(arg0: &mut LendingProtocol, arg1: &mut 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Promise {
        abort 0
    }

    // decompiled from Move bytecode v6
}

