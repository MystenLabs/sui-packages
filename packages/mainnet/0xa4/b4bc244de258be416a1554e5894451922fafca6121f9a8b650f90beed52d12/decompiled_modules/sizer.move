module 0xa4b4bc244de258be416a1554e5894451922fafca6121f9a8b650f90beed52d12::sizer {
    public fun best(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<bool>, arg3: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 > 0 && 0x1::vector::length<u64>(&arg1) == v0, 2);
        assert!(0x1::vector::length<bool>(&arg2) % v0 == 0, 2);
        let v1 = 0x1::vector::length<bool>(&arg2) / v0;
        let v2 = 0;
        let v3 = false;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = false;
            let v6 = 0;
            while (v6 < v1) {
                if (*0x1::vector::borrow<bool>(&arg2, v4 * v1 + v6)) {
                    v5 = true;
                };
                v6 = v6 + 1;
            };
            if (!v5 && *0x1::vector::borrow<u64>(&arg1, v4) >= *0x1::vector::borrow<u64>(&arg0, v4)) {
                let v7 = *0x1::vector::borrow<u64>(&arg1, v4) - *0x1::vector::borrow<u64>(&arg0, v4);
                if (v7 >= arg3 && (!v3 || v7 > 0)) {
                    v3 = true;
                    v2 = *0x1::vector::borrow<u64>(&arg0, v4);
                };
            };
            v4 = v4 + 1;
        };
        assert!(v3, 1);
        v2
    }

    // decompiled from Move bytecode v6
}

