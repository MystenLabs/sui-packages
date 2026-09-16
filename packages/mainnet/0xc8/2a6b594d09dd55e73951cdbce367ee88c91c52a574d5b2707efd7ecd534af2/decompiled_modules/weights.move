module 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights {
    public fun absorb(arg0: vector<u64>, arg1: vector<u64>, arg2: u64) : (bool, vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(0x1::vector::length<u64>(&arg1) == v0, 0);
        if (v0 == 0) {
            return (arg2 == 0, vector[])
        };
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            v1 = v1 + 100;
            v2 = v2 + *0x1::vector::borrow<u64>(&arg1, v3);
            v3 = v3 + 1;
        };
        if (arg2 < v1 || arg2 > v2) {
            return (false, vector[])
        };
        let v4 = vector[];
        let v5 = vector[];
        v3 = 0;
        while (v3 < v0) {
            0x1::vector::push_back<u64>(&mut v4, 0);
            0x1::vector::push_back<bool>(&mut v5, false);
            v3 = v3 + 1;
        };
        let v6 = 0;
        loop {
            let v7 = 0;
            let v8 = 0;
            v3 = 0;
            while (v3 < v0) {
                if (!*0x1::vector::borrow<bool>(&v5, v3)) {
                    v7 = v7 + (*0x1::vector::borrow<u64>(&arg0, v3) as u128);
                    v8 = v8 + 1;
                };
                v3 = v3 + 1;
            };
            if (v8 == 0) {
                return (v6 == arg2, v4)
            };
            if (v6 > arg2) {
                return (false, vector[])
            };
            if (v7 == 0) {
                return (false, vector[])
            };
            let v9 = false;
            v3 = 0;
            while (v3 < v0) {
                if (!*0x1::vector::borrow<bool>(&v5, v3)) {
                    let v10 = (((*0x1::vector::borrow<u64>(&arg0, v3) as u128) * ((arg2 - v6) as u128) / v7) as u64);
                    if (v10 < 100) {
                        *0x1::vector::borrow_mut<u64>(&mut v4, v3) = 100;
                        *0x1::vector::borrow_mut<bool>(&mut v5, v3) = true;
                        v6 = v6 + 100;
                        v9 = true;
                    } else if (v10 > *0x1::vector::borrow<u64>(&arg1, v3)) {
                        *0x1::vector::borrow_mut<u64>(&mut v4, v3) = *0x1::vector::borrow<u64>(&arg1, v3);
                        *0x1::vector::borrow_mut<bool>(&mut v5, v3) = true;
                        v6 = v6 + *0x1::vector::borrow<u64>(&arg1, v3);
                        v9 = true;
                    } else {
                        *0x1::vector::borrow_mut<u64>(&mut v4, v3) = v10;
                    };
                };
                v3 = v3 + 1;
            };
            if (!v9) {
                break
            };
        };
        let v11 = 0;
        v3 = 0;
        while (v3 < v0) {
            v11 = v11 + *0x1::vector::borrow<u64>(&v4, v3);
            v3 = v3 + 1;
        };
        if (v11 > arg2) {
            return (false, vector[])
        };
        let v12 = arg2 - v11;
        v3 = 0;
        while (v12 > 0 && v3 < v0) {
            if (!*0x1::vector::borrow<bool>(&v5, v3) && *0x1::vector::borrow<u64>(&v4, v3) < *0x1::vector::borrow<u64>(&arg1, v3)) {
                *0x1::vector::borrow_mut<u64>(&mut v4, v3) = *0x1::vector::borrow<u64>(&v4, v3) + 1;
                v12 = v12 - 1;
            };
            v3 = v3 + 1;
        };
        (v12 == 0, v4)
    }

    public fun bps() : u64 {
        10000
    }

    public fun max_bps() : u64 {
        5000
    }

    public fun min_bps() : u64 {
        100
    }

    public fun scale_unbounded(arg0: vector<u64>, arg1: u64) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(&arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + (*0x1::vector::borrow<u64>(&arg0, v2) as u128);
            v2 = v2 + 1;
        };
        let v3 = vector[];
        if (v0 == 0 || v1 == 0) {
            return v3
        };
        let v4 = 0;
        let v5 = 0;
        v2 = 0;
        while (v2 < v0) {
            let v6 = (((*0x1::vector::borrow<u64>(&arg0, v2) as u128) * (arg1 as u128) / v1) as u64);
            0x1::vector::push_back<u64>(&mut v3, v6);
            v4 = v4 + v6;
            v2 = v2 + 1;
        };
        *0x1::vector::borrow_mut<u64>(&mut v3, v5) = *0x1::vector::borrow<u64>(&v3, v5) + arg1 - v4;
        v3
    }

    public fun young_max_bps() : u64 {
        1000
    }

    // decompiled from Move bytecode v7
}

