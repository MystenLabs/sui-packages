module 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math {
    public(friend) fun buy_fee_bps(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u64) : u64 {
        let v0 = arg0 + arg1;
        if (!arg2 || arg4) {
            return v0
        };
        let v1 = arg5 - arg3;
        if (v1 >= 5000) {
            return v0
        };
        let v2 = v1 / 100;
        let v3 = vector[9900, 8892, 7931, 7025, 6179, 5398, 4683, 4035, 3452, 2933, 2475, 2074, 1726, 1426, 1171, 954, 772, 621, 496, 393, 309, 242, 188, 145, 111, 84, 64, 48, 36, 26, 19, 14, 10, 7, 5, 4, 3, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        let v4 = *0x1::vector::borrow<u64>(&v3, v2);
        let v5 = v4 - mul_div(v4 - *0x1::vector::borrow<u64>(&v3, v2 + 1), v1 % 100, 100);
        if (v5 > v0) {
            v5
        } else {
            v0
        }
    }

    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public(friend) fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    fun sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 < 4) {
            return 1
        };
        let v0 = 0;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >= 340282366920938463463374607431768211456) {
            v2 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (v2 >= 18446744073709551616) {
            v2 = v2 >> 64;
            v1 = v1 + 64;
        };
        if (v2 >= 4294967296) {
            v2 = v2 >> 32;
            v1 = v1 + 32;
        };
        if (v2 >= 65536) {
            v2 = v2 >> 16;
            v1 = v1 + 16;
        };
        if (v2 >= 256) {
            v2 = v2 >> 8;
            v1 = v1 + 8;
        };
        if (v2 >= 16) {
            v2 = v2 >> 4;
            v1 = v1 + 4;
        };
        if (v2 >= 4) {
            v1 = v1 + 2;
        };
        let v3 = 1 << (v1 >> 1) + 1;
        let v4 = 0;
        while (v4 < 128) {
            let v5 = v3 + arg0 / v3 >> 1;
            if (v5 >= v3) {
                break
            };
            v3 = v5;
            v4 = v4 + 1;
        };
        if (v3 > arg0 / v3) {
            v3 - 1
        } else {
            v3
        }
    }

    public fun sqrt_price_x64(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 0);
        let (v0, v1) = if (arg3) {
            ((arg1 as u256) + (arg2 as u256), (arg0 as u256))
        } else {
            ((arg0 as u256), (arg1 as u256) + (arg2 as u256))
        };
        (sqrt((v0 << 128) / v1) as u128)
    }

    public fun token_is_a<T0, T1>() : bool {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0) && v2 < 0x1::vector::length<u8>(&v1)) {
            if (*0x1::vector::borrow<u8>(&v0, v2) != *0x1::vector::borrow<u8>(&v1, v2)) {
                return *0x1::vector::borrow<u8>(&v0, v2) > *0x1::vector::borrow<u8>(&v1, v2)
            };
            v2 = v2 + 1;
        };
        0x1::vector::length<u8>(&v0) > 0x1::vector::length<u8>(&v1)
    }

    // decompiled from Move bytecode v7
}

