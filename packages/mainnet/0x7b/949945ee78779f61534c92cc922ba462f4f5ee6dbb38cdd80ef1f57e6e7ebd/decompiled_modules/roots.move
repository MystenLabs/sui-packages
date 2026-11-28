module 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::roots {
    public fun check_isolation(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: u64) : bool {
        let v0 = 0x1::vector::length<u64>(&arg0);
        if (v0 == 0 || 0x1::vector::length<u64>(&arg1) != v0) {
            return false
        };
        if (*0x1::vector::borrow<u64>(&arg0, 0) == *0x1::vector::borrow<u64>(&arg1, 0)) {
            return false
        };
        if (0x1::vector::length<u64>(&arg2) / 2 != v0 - 1) {
            return false
        };
        check_roots(arg0, arg1, arg2, arg3, arg4)
    }

    public fun check_roots(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: u64) : bool {
        let v0 = 0x1::vector::length<u64>(&arg2);
        let v1 = if (0x1::vector::length<u64>(&arg1) != 0x1::vector::length<u64>(&arg0)) {
            true
        } else if (0x1::vector::length<u64>(&arg3) != v0) {
            true
        } else if (v0 % 2 != 0) {
            true
        } else {
            arg4 == 0
        };
        if (v1) {
            return false
        };
        let v2 = 1;
        let v3 = true;
        while (v3 && v2 < v0) {
            v3 = (*0x1::vector::borrow<u64>(&arg2, v2 - 1) as u128) + (*0x1::vector::borrow<u64>(&arg3, v2) as u128) < (*0x1::vector::borrow<u64>(&arg2, v2) as u128) + (*0x1::vector::borrow<u64>(&arg3, v2 - 1) as u128);
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v3 && v4 < v0) {
            let (v5, v6, v7) = eval_scaled(&arg0, &arg1, *0x1::vector::borrow<u64>(&arg2, v4), *0x1::vector::borrow<u64>(&arg3, v4), arg4);
            let (v8, v9, v10) = eval_scaled(&arg0, &arg1, *0x1::vector::borrow<u64>(&arg2, v4 + 1), *0x1::vector::borrow<u64>(&arg3, v4 + 1), arg4);
            let v11 = if (v5) {
                if (v8) {
                    v6 <= v7 && v10 <= v9 || v9 <= v10 && v7 <= v6
                } else {
                    false
                }
            } else {
                false
            };
            v3 = v11;
            v4 = v4 + 2;
        };
        v3
    }

    fun eval_scaled(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: u64) : (bool, u256, u256) {
        let v0 = (arg2 as u256);
        let v1 = (arg3 as u256);
        let v2 = 0;
        let v3 = 0;
        let v4 = 1;
        let v5 = 0;
        let v6 = true;
        while (v6 && v5 < 0x1::vector::length<u64>(arg0)) {
            let v7 = if (v2 >= 1569275433846670190958947355801916604025588861116008628224) {
                true
            } else if (v3 >= 1569275433846670190958947355801916604025588861116008628224) {
                true
            } else {
                v4 >= 1569275433846670190958947355801916604025588861116008628224
            };
            if (v7) {
                v6 = false;
                continue
            };
            let v8 = v2 * v0 + v3 * v1 + (*0x1::vector::borrow<u64>(arg0, v5) as u256) * v4;
            let v9 = v2 * v1 + v3 * v0 + (*0x1::vector::borrow<u64>(arg1, v5) as u256) * v4;
            if (v8 >= v9) {
                v2 = v8 - v9;
                v3 = 0;
            } else {
                v2 = 0;
                v3 = v9 - v8;
            };
            v4 = v4 * (arg4 as u256);
            v5 = v5 + 1;
        };
        (v6, v2, v3)
    }

    // decompiled from Move bytecode v7
}

