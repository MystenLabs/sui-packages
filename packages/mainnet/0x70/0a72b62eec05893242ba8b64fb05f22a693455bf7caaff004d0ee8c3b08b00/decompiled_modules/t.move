module 0xa5743a3413affa6d6e24f6a560d38b1924aacd46043a1cb833db97b2160c34de::t {
    public fun mc<T0>(arg0: &0xa5743a3413affa6d6e24f6a560d38b1924aacd46043a1cb833db97b2160c34de::l1::Admin, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
            while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1)) {
                0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1));
            };
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        } else {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
        };
    }

    // decompiled from Move bytecode v6
}

