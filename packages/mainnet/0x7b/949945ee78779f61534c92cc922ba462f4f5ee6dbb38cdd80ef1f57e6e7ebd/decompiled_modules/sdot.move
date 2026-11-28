module 0x7b949945ee78779f61534c92cc922ba462f4f5ee6dbb38cdd80ef1f57e6e7ebd::sdot {
    public(friend) fun sdot(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: &vector<u64>, arg5: u64) : (u256, u256) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg5) {
            let v3 = arg2 + v2 * arg3;
            let v4 = (*0x1::vector::borrow<u64>(arg4, v2) as u256);
            v0 = v0 + (*0x1::vector::borrow<u64>(arg0, v3) as u256) * v4;
            v1 = v1 + (*0x1::vector::borrow<u64>(arg1, v3) as u256) * v4;
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v7
}

