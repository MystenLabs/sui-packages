module 0xc88fd658c90e44dd803dcab8b28d61faf5733cd2472974b0641f523fdebadbc3::pick {
    public fun best(arg0: vector<u64>, arg1: vector<u64>, arg2: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1) && v0 > 0, 2);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = v3;
        while (v1 < v0) {
            let v5 = *0x1::vector::borrow<u64>(&arg0, v1);
            let v6 = *0x1::vector::borrow<u64>(&arg1, v1);
            if (v6 > v5) {
                let v7 = v6 - v5;
                if (v7 > v3) {
                    v4 = v7;
                    v2 = v5;
                };
            };
            v1 = v1 + 1;
        };
        assert!(v4 >= arg2, 1);
        v2
    }

    public fun best_with_cost(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>, arg3: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0);
        let v1 = if (v0 == 0x1::vector::length<u64>(&arg1)) {
            if (v0 == 0x1::vector::length<u64>(&arg2)) {
                v0 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = v4;
        while (v2 < v0) {
            let v6 = *0x1::vector::borrow<u64>(&arg0, v2);
            let v7 = *0x1::vector::borrow<u64>(&arg1, v2);
            let v8 = *0x1::vector::borrow<u64>(&arg2, v2);
            if (v7 > v6 + v8) {
                let v9 = v7 - v6 - v8;
                if (v9 > v4) {
                    v5 = v9;
                    v3 = v6;
                };
            };
            v2 = v2 + 1;
        };
        assert!(v5 >= arg3, 1);
        v3
    }

    // decompiled from Move bytecode v7
}

