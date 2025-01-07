module 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math {
    public fun add(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 115792089237316195423570985008687907853269984665640564039457584007913129639935 && arg1 != 0) {
            return 0
        };
        if (arg1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0) {
            return 0
        };
        arg0 + arg1
    }

    public fun div(arg0: u256, arg1: u256) : u256 {
        if (arg1 == 0) {
            return 0
        };
        arg0 / arg1
    }

    public fun mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = arg0 * arg1;
        if (v0 / arg0 != arg1) {
            return 0
        };
        v0
    }

    public fun mul_div(arg0: u256, arg1: u256, arg2: u256) : u256 {
        div(mul(arg0, arg1), arg2)
    }

    public fun sub(arg0: u256, arg1: u256) : u256 {
        if (arg1 > arg0) {
            return 0
        };
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

