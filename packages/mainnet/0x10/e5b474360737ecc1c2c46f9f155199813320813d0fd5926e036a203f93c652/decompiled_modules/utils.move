module 0x10e5b474360737ecc1c2c46f9f155199813320813d0fd5926e036a203f93c652::utils {
    public fun deduct_slippage(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128);
        ((v0 - v0 * (arg1 as u128) * 1000000 / 100000 * 1000000) as u64)
    }

    public fun deduct_slippage_from_vector(arg0: vector<u64>, arg1: u64) : vector<u64> {
        let v0 = 0;
        while (0x1::vector::length<u64>(&arg0) > v0) {
            let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0, v0);
            let v2 = (*v1 as u128);
            *v1 = ((v2 - v2 * (arg1 as u128) * 1000000 / 100000 * 1000000) as u64);
            v0 = v0 + 1;
        };
        arg0
    }

    public fun handle_coin_vector<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            return v0
        };
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 > arg1) {
            0x2::pay::split_and_transfer<T0>(&mut v0, v1 - arg1, 0x2::tx_context::sender(arg2), arg2);
        };
        v0
    }

    public fun to_result<T0: store + key>(arg0: T0) : T0 {
        arg0
    }

    // decompiled from Move bytecode v6
}

