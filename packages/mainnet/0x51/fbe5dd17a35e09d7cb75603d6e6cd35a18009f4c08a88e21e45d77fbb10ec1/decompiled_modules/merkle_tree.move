module 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::merkle_tree {
    fun efficient_hash(arg0: &vector<u8>) : 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32 {
        let v0 = 0x2::hash::keccak256(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::from_vector(v1)
    }

    fun hash_pair(arg0: 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32, arg1: 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32) : 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32 {
        let v0 = 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::data(&arg0);
        let v1 = v0;
        let v2 = 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::data(&arg1);
        let v3 = v2;
        if (0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::utils::max_vector_u8(v0, v2) == v0) {
            v3 = v0;
            v1 = v2;
        };
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v4, v1);
        0x1::vector::append<u8>(&mut v4, v3);
        efficient_hash(&v4)
    }

    public fun leaf_from_vector(arg0: &vector<u8>) : 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32 {
        let v0 = x"00";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        efficient_hash(&v0)
    }

    fun process_proof(arg0: vector<0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32>, arg1: 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32) : 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32>(&arg0)) {
            v0 = hash_pair(v0, *0x1::vector::borrow<0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun verify(arg0: vector<0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32>, arg1: 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32, arg2: 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32) : bool {
        let v0 = process_proof(arg0, arg2);
        0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::data(&v0) == 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::data(&arg1)
    }

    public fun verify_v1(arg0: vector<address>, arg1: address, arg2: address) : bool {
        let v0 = 0x1::vector::empty<0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            0x1::vector::push_back<0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32>(&mut v0, 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::from_vector(0x2::address::to_bytes(*0x1::vector::borrow<address>(&arg0, v1))));
            v1 = v1 + 1;
        };
        verify(v0, 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::from_vector(0x2::address::to_bytes(arg1)), 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::from_vector(0x2::address::to_bytes(arg2)))
    }

    // decompiled from Move bytecode v6
}

