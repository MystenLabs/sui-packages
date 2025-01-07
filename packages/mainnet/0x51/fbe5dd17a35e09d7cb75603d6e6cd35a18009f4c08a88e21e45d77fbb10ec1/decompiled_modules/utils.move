module 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::utils {
    public fun max_vector_u8(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0x1::vector::length<u8>(&arg1);
        if (v0 != v1) {
            if (v0 > v1) {
                return arg0
            };
            return arg1
        };
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(&arg1, v2);
            if (v3 > v4) {
                return arg0
            };
            if (v4 > v3) {
                return arg1
            };
            v2 = v2 + 1;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

