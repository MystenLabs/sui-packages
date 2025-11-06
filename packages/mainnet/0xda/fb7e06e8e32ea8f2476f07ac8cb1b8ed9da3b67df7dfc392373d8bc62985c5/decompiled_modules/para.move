module 0xdafb7e06e8e32ea8f2476f07ac8cb1b8ed9da3b67df7dfc392373d8bc62985c5::para {
    struct Output has copy, drop {
        amount: u64,
    }

    public fun value<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun destroy_zero_balance<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public entry fun identity(arg0: u64) : u64 {
        arg0
    }

    public fun to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

