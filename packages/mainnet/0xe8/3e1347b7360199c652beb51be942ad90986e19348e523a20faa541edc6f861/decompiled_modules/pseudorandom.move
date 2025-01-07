module 0xe83e1347b7360199c652beb51be942ad90986e19348e523a20faa541edc6f861::pseudorandom {
    fun bytes_to_u32(arg0: vector<u8>) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 4) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u32) << ((8 * (3 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    public fun rand_u32(arg0: &mut 0x2::tx_context::TxContext) : u32 {
        bytes_to_u32(seed(arg0))
    }

    fun seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::tx_context::TxContext>(arg0));
        0x1::vector::append<u8>(&mut v1, 0x2::object::uid_to_bytes(&v0));
        0x1::hash::sha3_256(v1)
    }

    // decompiled from Move bytecode v6
}

