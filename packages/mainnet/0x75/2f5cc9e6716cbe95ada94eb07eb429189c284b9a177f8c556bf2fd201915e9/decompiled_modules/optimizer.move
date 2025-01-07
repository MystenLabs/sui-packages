module 0x752f5cc9e6716cbe95ada94eb07eb429189c284b9a177f8c556bf2fd201915e9::optimizer {
    public fun bullshark(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = slam(arg0, arg1);
        while (v0 > 0) {
            0x2::object::delete(0x2::object::new(arg1));
            v0 = v0 - 1;
        };
    }

    public fun capy(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = fuddies(arg0, arg1);
        while (v0 > 0) {
            0x2::object::delete(0x2::object::new(arg1));
            v0 = v0 - 1;
        };
    }

    fun clonex(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<0x2::tx_context::TxContext>(arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = vs<u8>(&v0, v1 - 8, v1);
        let v3 = vu(&v2) + arg1;
        let v4 = 0x2::bcs::to_bytes<u64>(&v3);
        assert!(v4 == 0x2::bcs::to_bytes<u64>(&v3), 1);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 241;
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<u8>(&v6));
        0x1::vector::append<u8>(&mut v5, *0x2::tx_context::digest(arg0));
        0x1::vector::append<u8>(&mut v5, v4);
        0x2::hash::blake2b256(&v5)
    }

    fun fuddies(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        let v1 = 4;
        if (arg0 >= 13) {
            v1 = 6;
        } else if (arg0 >= 12) {
            v1 = 5;
        };
        loop {
            let v2 = clonex(arg1, v0);
            if (*0x1::vector::borrow<u8>(&v2, 0) % v1 == 0) {
                break
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun slam(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        let v1 = 4;
        if (arg0 >= 13) {
            v1 = 6;
        } else if (arg0 >= 12) {
            v1 = 5;
        };
        loop {
            let v2 = clonex(arg1, v0);
            if (*0x1::vector::borrow<u8>(&v2, 0) % v1 != 0) {
                break
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun vs<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    fun vu(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v1 << 8;
            v1 = v2 + (*0x1::vector::borrow<u8>(arg0, 0x1::vector::length<u8>(arg0) - 1 - v0) as u64);
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

