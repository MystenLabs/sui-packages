module 0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::adapter_deepbook {
    struct RepayTicket has drop {
        dummy_field: bool,
    }

    public fun borrow_base<T0, T1>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, RepayTicket) {
        abort 0
    }

    public fun borrow_quote<T0, T1>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, RepayTicket) {
        abort 0
    }

    public fun repay_base<T0, T1>(arg0: address, arg1: &mut 0x2::coin::Coin<T0>, arg2: RepayTicket, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun repay_quote<T0, T1>(arg0: address, arg1: &mut 0x2::coin::Coin<T1>, arg2: RepayTicket, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

