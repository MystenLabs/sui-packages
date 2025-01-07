module 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::payment {
    public fun burn_from_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::coin::burn<T0>(arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg3))
    }

    public fun join_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun take_from<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, arg2);
        let v1 = v0 - arg1;
        if (v1 > 0) {
            0x2::pay::split<T0>(arg0, v1, arg3);
        };
    }

    public fun transfer_coins<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun transfer_from_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg2), arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

