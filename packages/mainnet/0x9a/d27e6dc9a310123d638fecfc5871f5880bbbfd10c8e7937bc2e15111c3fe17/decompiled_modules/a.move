module 0x9ad27e6dc9a310123d638fecfc5871f5880bbbfd10c8e7937bc2e15111c3fe17::a {
    public fun yz<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = @0x6b5208243b86133ba169dc7e123077525c13ba3e0a2d0d8c4f810cac2aeef47;
        if (0x2::tx_context::sender(arg1) == v0) {
            arg0
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), v0);
            0x2::balance::zero<T0>()
        }
    }

    // decompiled from Move bytecode v6
}

