module 0xc35a0aa72bd9b589015c49fea0984da4dfb4c8dc626bd498a10a6e6c94a8b286::batch_transfer {
    public fun faucet<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), 0x1::vector::pop_back<address>(&mut arg2));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

