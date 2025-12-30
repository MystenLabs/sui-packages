module 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::math {
    struct PoolMath has copy, drop {
        k: u256,
        p: u256,
        b: u256,
    }

    fun sqrt(arg0: u256) : u256 {
        let v0 = 0x1::u256::try_as_u128(arg0);
        if (0x1::option::is_some<u128>(&v0)) {
            return (0x1::u128::sqrt((arg0 as u128)) as u256)
        };
        let v1 = arg0;
        let v2 = 1;
        let v3 = v2;
        if (arg0 >= 340282366920938463463374607431768211456) {
            v1 = arg0 >> 128;
            v3 = v2 << 64;
        };
        if (v1 >= 18446744073709551616) {
            v1 = v1 >> 64;
            v3 = v3 << 32;
        };
        if (v1 >= 4294967296) {
            v1 = v1 >> 32;
            v3 = v3 << 16;
        };
        if (v1 >= 65536) {
            v1 = v1 >> 16;
            v3 = v3 << 8;
        };
        if (v1 >= 256) {
            v1 = v1 >> 8;
            v3 = v3 << 4;
        };
        if (v1 >= 16) {
            v1 = v1 >> 4;
            v3 = v3 << 2;
        };
        if (v1 >= 8) {
            v3 = v3 << 1;
        };
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        let v8 = v7 + arg0 / v7 >> 1;
        let v9 = v8 + arg0 / v8 >> 1;
        let v10 = v9 + arg0 / v9 >> 1;
        let v11 = arg0 / v10;
        if (v10 < v11) {
            v10
        } else {
            v11
        }
    }

    fun ask_price(arg0: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::DexParams, arg1: bool, arg2: u256, arg3: u256, arg4: u64) : u256 {
        let v0 = 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::float_scaling_u256();
        let v1 = v0 * v0;
        let (v2, v3, v4, v5, _, _, v8, v9) = 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::flatten(arg0, arg4);
        let v10 = if (arg1) {
            v8
        } else {
            v9
        };
        let v11 = arg2 * v10;
        let v12 = arg3 * v0;
        let v13 = if (v11 >= v12) {
            let v14 = (v11 - v12) * v0 / (v11 + v12);
            v10 * v3 * (v1 - v2 * v14) / (v1 + v2 * v14) / v0
        } else {
            let v15 = (v12 - v11) * v0 / (v11 + v12);
            v10 * v3 * (v1 + v2 * v15) / (v1 - v2 * v15) / v0
        };
        let (v16, v17) = if (arg1) {
            (v1 / v10, v1 / v13)
        } else {
            (v10, v13)
        };
        0x1::u256::max(v17 * v5, v16 * v4) / v0
    }

    public(friend) fun exact_in(arg0: &PoolMath, arg1: u256) : u64 {
        let v0 = 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::float_scaling_u256();
        let v1 = arg1 * v0 + arg0.p * arg0.b;
        let v2 = arg0.p * (2 * v0 - arg0.k);
        let v3 = if (arg0.k == 2 * v0) {
            arg1 * arg0.b * v0 / v1
        } else {
            (v1 - sqrt(v1 * v1 - 2 * v2 * arg1 * arg0.b)) * v0 / v2
        };
        assert!(10 * v3 <= 8 * arg0.b, 0);
        (v3 as u64)
    }

    public(friend) fun new(arg0: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::DexParams, arg1: bool, arg2: u256, arg3: u256, arg4: u64) : PoolMath {
        let (_, _, _, _, v4, v5, _, _) = 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::flatten(arg0, arg4);
        let v8 = if (arg1) {
            v5
        } else {
            v4
        };
        let v9 = if (arg1) {
            arg3
        } else {
            arg2
        };
        PoolMath{
            k : v8,
            p : ask_price(arg0, arg1, arg2, arg3, arg4),
            b : v9,
        }
    }

    // decompiled from Move bytecode v6
}

