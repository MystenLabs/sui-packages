module 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::lp {
    public fun check_lp(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64, arg8: vector<u64>, arg9: u64, arg10: u64, arg11: u64) : bool {
        let v0 = if (arg10 >= 4294967296) {
            true
        } else if (arg11 >= 4294967296) {
            true
        } else if (arg7 == 0) {
            true
        } else {
            arg9 == 0
        };
        if (v0) {
            return false
        };
        let v1 = arg10 * arg11;
        if (0x1::vector::length<u64>(&arg0) != v1 || 0x1::vector::length<u64>(&arg1) != v1) {
            return false
        };
        let v2 = if (0x1::vector::length<u64>(&arg2) != arg10) {
            true
        } else if (0x1::vector::length<u64>(&arg3) != arg10) {
            true
        } else {
            0x1::vector::length<u64>(&arg8) != arg10
        };
        if (v2) {
            return false
        };
        let v3 = if (0x1::vector::length<u64>(&arg4) != arg11) {
            true
        } else if (0x1::vector::length<u64>(&arg5) != arg11) {
            true
        } else {
            0x1::vector::length<u64>(&arg6) != arg11
        };
        if (v3) {
            return false
        };
        let v4 = (arg7 as u256);
        let v5 = (arg9 as u256);
        let v6 = 0;
        let v7 = true;
        while (v7 && v6 < arg10) {
            let (v8, v9) = 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::sdot::sdot(&arg0, &arg1, v6 * arg11, 1, &arg6, arg11);
            v7 = v8 + v4 * (*0x1::vector::borrow<u64>(&arg3, v6) as u256) <= v9 + v4 * (*0x1::vector::borrow<u64>(&arg2, v6) as u256);
            v6 = v6 + 1;
        };
        let v10 = 0;
        while (v7 && v10 < arg11) {
            let (v11, v12) = 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::sdot::sdot(&arg0, &arg1, v10, arg11, &arg8, arg10);
            v7 = v11 + v5 * (*0x1::vector::borrow<u64>(&arg5, v10) as u256) >= v12 + v5 * (*0x1::vector::borrow<u64>(&arg4, v10) as u256);
            v10 = v10 + 1;
        };
        if (!v7) {
            return false
        };
        let (v13, v14) = 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::sdot::sdot(&arg4, &arg5, 0, 1, &arg6, arg11);
        let (v15, v16) = 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::sdot::sdot(&arg2, &arg3, 0, 1, &arg8, arg10);
        v5 * v13 + v4 * v16 == v5 * v14 + v4 * v15
    }

    // decompiled from Move bytecode v7
}

