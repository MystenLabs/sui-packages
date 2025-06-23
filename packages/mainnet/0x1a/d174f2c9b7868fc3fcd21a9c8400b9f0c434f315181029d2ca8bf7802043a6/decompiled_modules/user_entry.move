module 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::user_entry {
    public fun cancel_deposit<T0>(arg0: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::cancel_deposit<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun cancel_withdraw<T0>(arg0: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::cancel_withdraw<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun deposit<T0>(arg0: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u256, arg4: 0x1::option::Option<0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::receipt::Receipt>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 1001);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::request_deposit<T0>(arg0, arg4, arg6, 0x2::coin::split<T0>(&mut arg1, arg2, arg7), arg3, arg5, arg7)
    }

    public fun withdraw<T0>(arg0: &mut 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::Vault<T0>, arg1: u256, arg2: u64, arg3: 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::receipt::Receipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault::request_withdraw<T0>(arg0, arg3, arg4, arg1, arg2, 0x2::tx_context::sender(arg5))
    }

    // decompiled from Move bytecode v6
}

