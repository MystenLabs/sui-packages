module 0xd7a566b02316965124d0b61988c093b432f38fbe22463a33a2b40c8c904ee074::utils {
    public fun move_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), @0x3a9051c5cdb975cb98605f3e795b7d5ea0e3f3613f32fd45ec5ac1dedd02c97f);
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

