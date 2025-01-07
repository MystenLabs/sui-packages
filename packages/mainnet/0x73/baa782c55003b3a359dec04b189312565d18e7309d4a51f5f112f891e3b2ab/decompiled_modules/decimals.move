module 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::decimals {
    public fun change_decimals_128(arg0: u128, arg1: u8, arg2: u8) : u128 {
        if (arg2 >= arg1) {
            arg0 * 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::numerical::int_exp_128(10, ((arg2 - arg1) as u64))
        } else {
            arg0 / 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::numerical::int_exp_128(10, ((arg1 - arg2) as u64))
        }
    }

    public fun close_enough_decimals(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : bool {
        if (arg0 < arg1) {
            return close_enough_decimals(arg1, arg0, arg2, arg3)
        };
        0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::numerical::int_exp_128(10, (arg3 as u64)) * ((arg0 - arg1) as u128) <= (arg0 as u128) * (arg2 as u128)
    }

    public fun decimal_scalars_from_decimals(arg0: &vector<u8>) : (u8, vector<u128>) {
        let v0 = 18;
        let v1 = v0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            if (v4 < v0) {
                v1 = v4;
            };
            v3 = v3 + 1;
        };
        let v5 = vector[];
        v3 = 0;
        while (v3 < v2) {
            0x1::vector::push_back<u128>(&mut v5, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::numerical::int_exp_128(10, ((18 + v1 - *0x1::vector::borrow<u8>(arg0, v3)) as u64)));
            v3 = v3 + 1;
        };
        ((v1 as u8), v5)
    }

    public fun mean(arg0: &vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            v2 = v2 + (*0x1::vector::borrow<u8>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        ((v2 / v0) as u8)
    }

    public fun min(arg0: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 255;
        let v2 = v1;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v0);
            if (v3 < v1) {
                v2 = v3;
            };
            v0 = v0 + 1;
        };
        v2
    }

    // decompiled from Move bytecode v6
}

