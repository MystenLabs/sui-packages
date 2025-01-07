module 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::bcd {
    public fun bytes_to_u128(arg0: vector<u8>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u128) << ((8 * (15 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    public fun bytes_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((8 * (7 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

