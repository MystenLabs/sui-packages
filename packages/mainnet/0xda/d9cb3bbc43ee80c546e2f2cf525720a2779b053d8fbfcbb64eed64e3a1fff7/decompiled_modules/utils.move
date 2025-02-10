module 0xdad9cb3bbc43ee80c546e2f2cf525720a2779b053d8fbfcbb64eed64e3a1fff7::utils {
    public fun move_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun sum_balance_vector<T0>(arg0: vector<0x2::balance::Balance<T0>>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (!0x1::vector::is_empty<0x2::balance::Balance<T0>>(&arg0)) {
            0x2::balance::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::balance::Balance<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::balance::Balance<T0>>(arg0);
        v0
    }

    public fun sum_u64_vector(arg0: vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun zero_balance<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v6
}

