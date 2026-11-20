module 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::fee_vault {
    public fun keeper_shares(arg0: u64, arg1: &vector<u64>) : (vector<u64>, u64) {
        let v0 = 0x1::vector::length<u64>(arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + (*0x1::vector::borrow<u64>(arg1, v2) as u128);
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 0);
        let v3 = arg0 / 2;
        let v4 = 2 * arg0 / v0;
        let v5 = vector[];
        let v6 = 0;
        v2 = 0;
        while (v2 < v0) {
            let v7 = v3 / v0 + ((((arg0 - v3) as u128) * (*0x1::vector::borrow<u64>(arg1, v2) as u128) / v1) as u64);
            let v8 = v7;
            if (v7 > v4) {
                v8 = v4;
            };
            0x1::vector::push_back<u64>(&mut v5, v8);
            v6 = v6 + v8;
            v2 = v2 + 1;
        };
        (v5, arg0 - v6)
    }

    public fun split_fee(arg0: u64) : (u64, u64, u64) {
        let v0 = (((arg0 as u128) * (70 as u128) / 100) as u64);
        let v1 = (((arg0 as u128) * (20 as u128) / 100) as u64);
        (v0, v1, arg0 - v0 - v1)
    }

    // decompiled from Move bytecode v7
}

