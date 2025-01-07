module 0x8023391f99292f2bd720d03026d2de69950bfaf42c29772a69de4a2409ad7b59::random {
    public fun get_last_number(arg0: u64) : u64 {
        while (arg0 > 9) {
            let v0 = arg0 % 10;
            arg0 = v0;
            get_last_number(v0);
        };
        arg0
    }

    fun nonce_primitives(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        0x2::object::delete(v0);
        let v2 = 0x2::tx_context::epoch(arg0);
        let v3 = 0x2::tx_context::sender(arg0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v3));
        v1
    }

    public fun number_to_bool(arg0: u64) : bool {
        arg0 % 2 == 1
    }

    public fun rand_with_ctx(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, nonce_primitives(arg0));
        rand_with_nonce(v0)
    }

    public fun rand_with_nonce(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha3_256(arg0)
    }

    public fun u64_from_bytes(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        let v2 = v1;
        if (v1 > 8) {
            v2 = 8;
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = v0 << 8;
            v0 = v4 + (*0x1::vector::borrow<u8>(arg0, v3) as u64);
            v3 = v3 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

