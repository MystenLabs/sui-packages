module 0x926359bbaf25e7e8f6b58e690e23de3ec6c113bde11b2485379664fc8b9717ec::merkle_proof {
    fun efficient_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::hash::sha2_256(arg0)
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (0x926359bbaf25e7e8f6b58e690e23de3ec6c113bde11b2485379664fc8b9717ec::vectors::lt(&arg0, &arg1)) {
            efficient_hash(arg0, arg1)
        } else {
            efficient_hash(arg1, arg0)
        }
    }

    fun hex_char_to_byte(arg0: u8) : u8 {
        if (arg0 >= 48 && arg0 <= 57) {
            return arg0 - 48
        };
        if (arg0 >= 65 && arg0 <= 70) {
            return 10 + arg0 - 65
        };
        assert!(arg0 >= 97 && arg0 <= 102, 0);
        10 + arg0 - 97
    }

    public fun hex_string_to_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 % 2 == 0, 0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u8>(&mut v1, hex_char_to_byte(*0x1::vector::borrow<u8>(&arg0, v2)) * 16 + hex_char_to_byte(*0x1::vector::borrow<u8>(&arg0, v2 + 1)));
            v2 = v2 + 2;
        };
        v1
    }

    fun process_proof(arg0: &vector<vector<u8>>, arg1: vector<u8>) : vector<u8> {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            v0 = hash_pair(v0, *0x1::vector::borrow<vector<u8>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun verify(arg0: &vector<0x1::string::String>, arg1: 0x1::string::String, arg2: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(arg0)) {
            0x1::vector::push_back<vector<u8>>(&mut v0, hex_string_to_bytes(*0x1::string::bytes(0x1::vector::borrow<0x1::string::String>(arg0, v1))));
            v1 = v1 + 1;
        };
        process_proof(&v0, arg2) == hex_string_to_bytes(*0x1::string::bytes(&arg1))
    }

    // decompiled from Move bytecode v6
}

