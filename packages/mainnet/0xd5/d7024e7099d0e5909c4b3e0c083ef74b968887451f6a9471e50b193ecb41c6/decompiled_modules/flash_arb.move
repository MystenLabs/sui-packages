module 0xd5d7024e7099d0e5909c4b3e0c083ef74b968887451f6a9471e50b193ecb41c6::flash_arb {
    public fun calculate_profit<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        }
    }

    public fun check_profit<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: u64) : bool {
        0x2::balance::value<T0>(arg0) >= arg1 + arg2
    }

    public fun join_coins<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public fun merge_to_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg0), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public entry fun return_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun split_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 401);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public entry fun test_deployment(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg0);
    }

    public fun to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun transfer_or_destroy<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

