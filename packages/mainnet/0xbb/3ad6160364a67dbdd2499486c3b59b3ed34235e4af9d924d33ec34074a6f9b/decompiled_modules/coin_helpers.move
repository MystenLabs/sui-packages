module 0xbb3ad6160364a67dbdd2499486c3b59b3ed34235e4af9d924d33ec34074a6f9b::coin_helpers {
    public fun get_value<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public fun has_balance<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : bool {
        0x2::coin::value<T0>(arg0) >= arg1
    }

    public fun join_coins<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public fun split_exact<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun split_multiple<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            if (v2 > 0 && 0x2::coin::value<T0>(arg0) >= v2) {
                0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::split<T0>(arg0, v2, arg2));
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

