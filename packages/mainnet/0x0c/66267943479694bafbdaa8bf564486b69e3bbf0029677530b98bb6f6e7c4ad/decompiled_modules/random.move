module 0xc66267943479694bafbdaa8bf564486b69e3bbf0029677530b98bb6f6e7c4ad::random {
    public fun bernoulli(arg0: &vector<u64>, arg1: u64, arg2: u64, arg3: u64) : (bool, u64) {
        let (v0, v1) = range(arg0, arg1, arg3);
        (v0 < arg2, v1)
    }

    fun limit(arg0: u64) : u128 {
        let v0 = (arg0 as u128);
        18446744073709551616 / v0 * v0
    }

    public fun range(arg0: &vector<u64>, arg1: u64, arg2: u64) : (u64, u64) {
        assert!(arg2 > 0, 1);
        let v0 = arg1;
        let v1 = false;
        let v2 = 0;
        while (!v1) {
            assert!(v0 < 0x1::vector::length<u64>(arg0), 2);
            let v3 = *0x1::vector::borrow<u64>(arg0, v0);
            v0 = v0 + 1;
            if ((v3 as u128) < limit(arg2)) {
                v1 = true;
                v2 = v3 % arg2;
            };
        };
        (v2, v0)
    }

    public fun shuffle(arg0: &vector<u64>, arg1: u64, arg2: vector<u64>) : (vector<u64>, u64) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        let v1 = arg1;
        while (v0 > 1) {
            let (v2, v3) = range(arg0, v1, v0);
            v1 = v3;
            v0 = v0 - 1;
            0x1::vector::swap<u64>(&mut arg2, v0, v2);
        };
        (arg2, v1)
    }

    public fun weighted(arg0: &vector<u64>, arg1: u64, arg2: &vector<u64>) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg2)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg2, v1);
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 3);
        let (v2, v3) = range(arg0, arg1, v0);
        let v4 = 0;
        let v5 = *0x1::vector::borrow<u64>(arg2, 0);
        while (v5 <= v2) {
            let v6 = v4 + 1;
            v4 = v6;
            v5 = v5 + *0x1::vector::borrow<u64>(arg2, v6);
        };
        (v4, v3)
    }

    // decompiled from Move bytecode v7
}

