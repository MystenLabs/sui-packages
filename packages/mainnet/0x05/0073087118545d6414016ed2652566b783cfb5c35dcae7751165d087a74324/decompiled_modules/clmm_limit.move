module 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::clmm_limit {
    public fun relative(arg0: u128, arg1: bool, arg2: u128, arg3: u128, arg4: u128) : u128 {
        let v0 = if (arg2 > 0) {
            if (arg2 < 10000) {
                if (arg3 >= 4295048016) {
                    if (arg4 <= 79226673515401279992447579055) {
                        arg3 < arg4
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = if (arg1) {
            10000 - arg2
        } else {
            10000 + arg2
        };
        let v2 = if (arg1) {
            0x1::u128::max(arg0 * v1 / 10000, arg3)
        } else {
            0x1::u128::min(arg0 * v1 / 10000, arg4)
        };
        assert!(arg1 && v2 < arg0 || v2 > arg0, 2);
        v2
    }

    // decompiled from Move bytecode v7
}

