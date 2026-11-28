module 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::factor {
    public fun check_factorization(arg0: u256, arg1: vector<u256>, arg2: vector<vector<u256>>) : bool {
        let v0 = 0x1::vector::length<u256>(&arg1);
        if (0x1::vector::length<vector<u256>>(&arg2) != v0) {
            return false
        };
        let v1 = arg0;
        let v2 = 0;
        let v3 = true;
        while (v3 && v2 < v0) {
            let v4 = *0x1::vector::borrow<u256>(&arg1, v2);
            if (v4 < 2) {
                v3 = false;
            } else if (v1 % v4 != 0) {
                v3 = false;
            } else if (!0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::verify_pratt(v4, *0x1::vector::borrow<vector<u256>>(&arg2, v2))) {
                v3 = false;
            } else {
                v1 = v1 / v4;
            };
            v2 = v2 + 1;
        };
        v3 && v1 == 1
    }

    public fun check_prime(arg0: u256, arg1: vector<u256>) : bool {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::verify_pratt(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

