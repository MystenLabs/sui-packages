module 0x7d630387fc2b2ef1ec9579b8451d501daad74e8725eb0a309fc772d772ae5552::utils {
    public fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x1::option::Option<address>, arg2: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            let v0 = if (0x1::option::is_some<address>(&arg1)) {
                0x1::option::destroy_some<address>(arg1)
            } else {
                0x1::option::destroy_none<address>(arg1);
                0x2::tx_context::sender(arg2)
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v0);
        };
    }

    public fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x1::option::Option<address>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            let v0 = if (0x1::option::is_some<address>(&arg1)) {
                0x1::option::destroy_some<address>(arg1)
            } else {
                0x1::option::destroy_none<address>(arg1);
                0x2::tx_context::sender(arg2)
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), v0);
        };
    }

    public fun merge_balance<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg0), arg1);
    }

    // decompiled from Move bytecode v7
}

