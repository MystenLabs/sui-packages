module 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::sortperm {
    public fun check_sorted_perm(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>) : bool {
        let v0 = 0x1::vector::length<u64>(&arg0);
        if (0x1::vector::length<u64>(&arg1) != v0 || 0x1::vector::length<u64>(&arg2) != v0) {
            return false
        };
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<bool>(&mut v1, false);
            v2 = v2 + 1;
        };
        let v3 = true;
        let v4 = 0;
        while (v3 && v4 < v0) {
            let v5 = *0x1::vector::borrow<u64>(&arg2, v4);
            if (v5 >= v0) {
                v3 = false;
            } else if (*0x1::vector::borrow<bool>(&v1, v5)) {
                v3 = false;
            } else {
                *0x1::vector::borrow_mut<bool>(&mut v1, v5) = true;
                if (*0x1::vector::borrow<u64>(&arg1, v4) != *0x1::vector::borrow<u64>(&arg0, v5)) {
                    v3 = false;
                } else if (v4 > 0 && *0x1::vector::borrow<u64>(&arg1, v4 - 1) > *0x1::vector::borrow<u64>(&arg1, v4)) {
                    v3 = false;
                };
            };
            v4 = v4 + 1;
        };
        v3
    }

    // decompiled from Move bytecode v7
}

