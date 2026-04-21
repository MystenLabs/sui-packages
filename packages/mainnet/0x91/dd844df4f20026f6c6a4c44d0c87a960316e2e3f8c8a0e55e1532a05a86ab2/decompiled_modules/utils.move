module 0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::utils {
    public fun split_quote<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        if (v0 == 0) {
            let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            v1 = 0;
            while (v1 < 0x1::vector::length<u64>(&arg1)) {
                0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::zero<T0>(arg2));
                v1 = v1 + 1;
            };
            if (0x2::coin::value<T0>(&arg0) == 0) {
                0x2::coin::destroy_zero<T0>(arg0);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
            };
            return v2
        };
        let v3 = 0x2::coin::value<T0>(&arg0);
        let v4 = if (v3 < v0) {
            v3
        } else {
            v0
        };
        let v5 = vector[];
        let v6 = 0;
        v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v7 = (((*0x1::vector::borrow<u64>(&arg1, v1) as u128) * (v4 as u128) / (v0 as u128)) as u64);
            0x1::vector::push_back<u64>(&mut v5, v7);
            v6 = v6 + v7;
            v1 = v1 + 1;
        };
        let v8 = v4 - v6;
        v1 = 0;
        while (v8 > 0 && v1 < 0x1::vector::length<u64>(&v5)) {
            if (*0x1::vector::borrow<u64>(&arg1, v1) > 0) {
                *0x1::vector::borrow_mut<u64>(&mut v5, v1) = *0x1::vector::borrow<u64>(&v5, v1) + 1;
                v8 = v8 - 1;
            };
            let v9 = if (v1 + 1 == 0x1::vector::length<u64>(&v5)) {
                0
            } else {
                v1 + 1
            };
            v1 = v9;
        };
        let v10 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v5)) {
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v10, 0x2::coin::split<T0>(&mut arg0, *0x1::vector::borrow<u64>(&v5, v1), arg2));
            v1 = v1 + 1;
        };
        0x2::coin::destroy_zero<T0>(arg0);
        v10
    }

    // decompiled from Move bytecode v6
}

