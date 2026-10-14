module 0x1f60d8eb2f2309216d13005e99817a9678942421d012e906e76b63916f2bbcc7::rules {
    public fun dex_plan_valid(arg0: u8, arg1: u64, arg2: u32, arg3: u64) : bool {
        if (arg1 < 10000 || arg1 == 10000 && arg3 == 0) {
            if (arg1 == 0) {
                true
            } else {
                let v1 = if (arg0 == 1) {
                    true
                } else if (arg0 == 2) {
                    true
                } else {
                    arg0 == 3
                };
                v1 && arg2 > 0
            }
        } else {
            false
        }
    }

    public fun raises_risk(arg0: u8, arg1: u64, arg2: u64) : bool {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 8) {
            true
        } else {
            arg0 == 9
        };
        if (v0) {
            arg2 > arg1
        } else {
            let v2 = if (arg0 == 2) {
                true
            } else if (arg0 == 3) {
                true
            } else {
                arg0 == 7
            };
            if (v2) {
                arg2 < arg1
            } else if (arg0 == 5) {
                arg1 != 0 && (arg2 == 0 || arg2 > arg1)
            } else if (arg0 == 6) {
                let (v3, v4, v5) = unpack_dex(arg1);
                let (v6, v7, v8) = unpack_dex(arg2);
                let v9 = v7 <= v4 && (v7 == 0 || v6 == v3 && v8 == v5);
                !v9
            } else {
                true
            }
        }
    }

    public fun unpack_dex(arg0: u64) : (u8, u64, u32) {
        (((arg0 >> 56) as u8), arg0 & 16777215, ((arg0 >> 24 & 4294967295) as u32))
    }

    // decompiled from Move bytecode v7
}

