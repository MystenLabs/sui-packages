module 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools {
    public fun destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public fun coin_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun da<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            destroy_zero_balance<T0>(arg0);
        } else {
            transfer_balance<T0>(arg0, 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::admin::a(), arg1);
        };
    }

    public fun destroy_zero_balance<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun destroy_zero_or_transfer<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            destroy_zero_balance<T0>(arg0);
        } else {
            let v0 = 0x2::tx_context::sender(arg1);
            transfer_balance<T0>(arg0, v0, arg1);
        };
    }

    public fun destroy_zero_or_transfer_to_recipient<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            destroy_zero_balance<T0>(arg0);
        } else {
            transfer_balance<T0>(arg0, arg1, arg2);
        };
    }

    public(friend) fun join_into<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public(friend) fun transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(coin_from_balance<T0>(arg0, arg2), arg1);
    }

    public fun zb<T0>() : 0x2::balance::Balance<T0> {
        zero_balance<T0>()
    }

    public fun zero_balance<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v7
}

