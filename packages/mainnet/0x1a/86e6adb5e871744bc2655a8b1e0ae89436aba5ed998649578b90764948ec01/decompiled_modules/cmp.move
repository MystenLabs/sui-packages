module 0x1a86e6adb5e871744bc2655a8b1e0ae89436aba5ed998649578b90764948ec01::cmp {
    public fun assert_eq_u128(arg0: u128, arg1: u128, arg2: u64) {
        if (arg0 != arg1) {
            abort arg2
        };
    }

    public fun assert_eq_u256(arg0: u256, arg1: u256, arg2: u64) {
        if (arg0 != arg1) {
            abort arg2
        };
    }

    public fun assert_eq_u64(arg0: u64, arg1: u64, arg2: u64) {
        if (arg0 != arg1) {
            abort arg2
        };
    }

    public fun assert_ge_u128(arg0: u128, arg1: u128, arg2: u64) {
        if (arg0 < arg1) {
            abort arg2
        };
    }

    public fun assert_ge_u256(arg0: u256, arg1: u256, arg2: u64) {
        if (arg0 < arg1) {
            abort arg2
        };
    }

    public fun assert_ge_u64(arg0: u64, arg1: u64, arg2: u64) {
        if (arg0 < arg1) {
            abort arg2
        };
    }

    public fun assert_gt_u128(arg0: u128, arg1: u128, arg2: u64) {
        if (arg0 <= arg1) {
            abort arg2
        };
    }

    public fun assert_gt_u256(arg0: u256, arg1: u256, arg2: u64) {
        if (arg0 <= arg1) {
            abort arg2
        };
    }

    public fun assert_gt_u64(arg0: u64, arg1: u64, arg2: u64) {
        if (arg0 <= arg1) {
            abort arg2
        };
    }

    public fun assert_le_u128(arg0: u128, arg1: u128, arg2: u64) {
        if (arg0 > arg1) {
            abort arg2
        };
    }

    public fun assert_le_u256(arg0: u256, arg1: u256, arg2: u64) {
        if (arg0 > arg1) {
            abort arg2
        };
    }

    public fun assert_le_u64(arg0: u64, arg1: u64, arg2: u64) {
        if (arg0 > arg1) {
            abort arg2
        };
    }

    public fun assert_lt_u128(arg0: u128, arg1: u128, arg2: u64) {
        if (arg0 >= arg1) {
            abort arg2
        };
    }

    public fun assert_lt_u256(arg0: u256, arg1: u256, arg2: u64) {
        if (arg0 >= arg1) {
            abort arg2
        };
    }

    public fun assert_lt_u64(arg0: u64, arg1: u64, arg2: u64) {
        if (arg0 >= arg1) {
            abort arg2
        };
    }

    public fun assert_ne_u128(arg0: u128, arg1: u128, arg2: u64) {
        if (arg0 == arg1) {
            abort arg2
        };
    }

    public fun assert_ne_u256(arg0: u256, arg1: u256, arg2: u64) {
        if (arg0 == arg1) {
            abort arg2
        };
    }

    public fun assert_ne_u64(arg0: u64, arg1: u64, arg2: u64) {
        if (arg0 == arg1) {
            abort arg2
        };
    }

    public fun eq_u128(arg0: u128, arg1: u128) : bool {
        arg0 == arg1
    }

    public fun eq_u256(arg0: u256, arg1: u256) : bool {
        arg0 == arg1
    }

    public fun eq_u64(arg0: u64, arg1: u64) : bool {
        arg0 == arg1
    }

    public fun ge_u128(arg0: u128, arg1: u128) : bool {
        arg0 >= arg1
    }

    public fun ge_u256(arg0: u256, arg1: u256) : bool {
        arg0 >= arg1
    }

    public fun ge_u64(arg0: u64, arg1: u64) : bool {
        arg0 >= arg1
    }

    public fun gt_u128(arg0: u128, arg1: u128) : bool {
        arg0 > arg1
    }

    public fun gt_u256(arg0: u256, arg1: u256) : bool {
        arg0 > arg1
    }

    public fun gt_u64(arg0: u64, arg1: u64) : bool {
        arg0 > arg1
    }

    public fun le_u128(arg0: u128, arg1: u128) : bool {
        arg0 <= arg1
    }

    public fun le_u256(arg0: u256, arg1: u256) : bool {
        arg0 <= arg1
    }

    public fun le_u64(arg0: u64, arg1: u64) : bool {
        arg0 <= arg1
    }

    public fun lt_u128(arg0: u128, arg1: u128) : bool {
        arg0 < arg1
    }

    public fun lt_u256(arg0: u256, arg1: u256) : bool {
        arg0 < arg1
    }

    public fun lt_u64(arg0: u64, arg1: u64) : bool {
        arg0 < arg1
    }

    public fun ne_u128(arg0: u128, arg1: u128) : bool {
        arg0 != arg1
    }

    public fun ne_u256(arg0: u256, arg1: u256) : bool {
        arg0 != arg1
    }

    public fun ne_u64(arg0: u64, arg1: u64) : bool {
        arg0 != arg1
    }

    public fun not(arg0: bool) : bool {
        !arg0
    }

    public fun select_bool(arg0: bool, arg1: bool, arg2: bool) : bool {
        arg0 && arg1 || arg2
    }

    public fun select_u128(arg0: bool, arg1: u128, arg2: u128) : u128 {
        if (arg0) {
            arg1
        } else {
            arg2
        }
    }

    public fun select_u256(arg0: bool, arg1: u256, arg2: u256) : u256 {
        if (arg0) {
            arg1
        } else {
            arg2
        }
    }

    public fun select_u64(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (arg0) {
            arg1
        } else {
            arg2
        }
    }

    // decompiled from Move bytecode v7
}

