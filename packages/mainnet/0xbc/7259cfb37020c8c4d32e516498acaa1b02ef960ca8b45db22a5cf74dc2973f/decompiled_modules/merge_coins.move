module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::merge_coins {
    public fun merge_coin<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0) {
            0x1::vector::reverse<0x2::coin::Coin<T0>>(&mut arg0);
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
                0x2::coin::join<T0>(&mut v1, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
            };
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            let v2 = 0x2::coin::value<T0>(&v1);
            let v3 = arg1;
            if (arg1 == 18446744073709551615) {
                v3 = v2;
            };
            assert!(v2 >= v3, 0);
            if (0x2::coin::value<T0>(&v1) > v3) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
                0x2::coin::split<T0>(&mut v1, v3, arg2)
            } else {
                v1
            }
        } else {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            assert!(arg1 == 0, 1);
            0x2::coin::zero<T0>(arg2)
        }
    }

    // decompiled from Move bytecode v6
}

