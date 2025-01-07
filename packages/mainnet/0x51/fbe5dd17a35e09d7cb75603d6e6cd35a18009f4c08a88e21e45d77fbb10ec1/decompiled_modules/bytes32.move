module 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32 {
    struct Bytes32 has copy, drop, store {
        data: vector<u8>,
    }

    public fun data(arg0: &Bytes32) : vector<u8> {
        arg0.data
    }

    public fun from_vector(arg0: vector<u8>) : Bytes32 {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        Bytes32{data: arg0}
    }

    public fun from_vector_addresses(arg0: vector<address>) : vector<Bytes32> {
        let v0 = 0x1::vector::empty<Bytes32>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            0x1::vector::push_back<Bytes32>(&mut v0, from_vector(0x2::address::to_bytes(*0x1::vector::borrow<address>(&arg0, v1))));
            v1 = v1 + 1;
        };
        v0
    }

    public fun into_vector(arg0: Bytes32) : vector<u8> {
        let Bytes32 { data: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

