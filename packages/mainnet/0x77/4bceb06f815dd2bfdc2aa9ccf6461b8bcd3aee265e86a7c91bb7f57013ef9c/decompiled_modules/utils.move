module 0x774bceb06f815dd2bfdc2aa9ccf6461b8bcd3aee265e86a7c91bb7f57013ef9c::utils {
    public fun exact_split_and_profit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<T0>(&mut arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

