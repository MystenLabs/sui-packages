module 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::comparator {
    struct Result has drop {
        inner: u8,
    }

    public fun compare<T0>(arg0: &T0, arg1: &T0) : Result {
        compare_u8_vector(0x1::bcs::to_bytes<T0>(arg0), 0x1::bcs::to_bytes<T0>(arg1))
    }

    public fun compare_u8_vector(arg0: vector<u8>, arg1: vector<u8>) : Result {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0x1::vector::length<u8>(&arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(&arg1, v2);
            if (v3 < v4) {
                return Result{inner: 1}
            };
            if (v3 > v4) {
                return Result{inner: 2}
            };
            v2 = v2 + 1;
        };
        if (v0 < v1) {
            Result{inner: 1}
        } else if (v0 > v1) {
            Result{inner: 2}
        } else {
            Result{inner: 0}
        }
    }

    public fun eq(arg0: &Result) : bool {
        arg0.inner == 0
    }

    public fun gt(arg0: &Result) : bool {
        arg0.inner == 2
    }

    public fun gte(arg0: &Result) : bool {
        arg0.inner == 2 || arg0.inner == 0
    }

    public fun lt(arg0: &Result) : bool {
        arg0.inner == 1
    }

    public fun lte(arg0: &Result) : bool {
        arg0.inner == 1 || arg0.inner == 0
    }

    // decompiled from Move bytecode v6
}

