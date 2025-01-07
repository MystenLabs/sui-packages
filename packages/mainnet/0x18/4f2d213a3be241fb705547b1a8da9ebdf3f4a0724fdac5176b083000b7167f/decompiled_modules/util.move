module 0x184f2d213a3be241fb705547b1a8da9ebdf3f4a0724fdac5176b083000b7167f::util {
    public fun a<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 1);
        if (0 == v0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        };
    }

    public fun v<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

