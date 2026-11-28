module 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::linsys {
    public fun check_solution(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: u64) : bool {
        let v0 = if (arg7 >= 4294967296) {
            true
        } else if (arg8 >= 4294967296) {
            true
        } else {
            arg6 == 0
        };
        if (v0) {
            return false
        };
        let v1 = arg7 * arg8;
        if (0x1::vector::length<u64>(&arg0) != v1 || 0x1::vector::length<u64>(&arg1) != v1) {
            return false
        };
        if (0x1::vector::length<u64>(&arg2) != arg7 || 0x1::vector::length<u64>(&arg3) != arg7) {
            return false
        };
        if (0x1::vector::length<u64>(&arg4) != arg8 || 0x1::vector::length<u64>(&arg5) != arg8) {
            return false
        };
        let v2 = (arg6 as u256);
        let v3 = 0;
        let v4 = true;
        while (v4 && v3 < arg7) {
            let v5 = v3 * arg8;
            let (v6, v7) = 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::sdot::sdot(&arg0, &arg1, v5, 1, &arg4, arg8);
            let (v8, v9) = 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::sdot::sdot(&arg0, &arg1, v5, 1, &arg5, arg8);
            v4 = v6 + v9 + v2 * (*0x1::vector::borrow<u64>(&arg3, v3) as u256) == v7 + v8 + v2 * (*0x1::vector::borrow<u64>(&arg2, v3) as u256);
            v3 = v3 + 1;
        };
        v4
    }

    // decompiled from Move bytecode v7
}

