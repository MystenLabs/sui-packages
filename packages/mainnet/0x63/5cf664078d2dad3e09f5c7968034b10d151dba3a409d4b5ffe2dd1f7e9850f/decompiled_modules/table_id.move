module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::table_id {
    public fun encode(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        arg0
    }

    public fun offchain_table_type() : vector<u8> {
        b"oft"
    }

    public fun onchain_table_type() : vector<u8> {
        b"ont"
    }

    public fun table_name(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 3;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun table_type(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, 0));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, 1));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, 2));
        v0
    }

    // decompiled from Move bytecode v6
}

