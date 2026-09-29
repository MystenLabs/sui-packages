module 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::gap {
    public fun flip(arg0: u128, arg1: u128, arg2: u64) : (bool, bool) {
        let v0 = (arg2 as u256);
        let v1 = if (v0 >= 1000000) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg0 > 79226673515401279992447579054) {
            true
        } else {
            arg1 > 79226673515401279992447579054
        };
        if (v1) {
            return (false, false)
        };
        let v2 = (arg0 as u256) * (arg1 as u256);
        if (v2 < 340282366920938463463374607431768211456) {
            (v2 * 1000000 < 340282366920938463463374607431768211456 * (1000000 - v0), true)
        } else {
            (340282366920938463463374607431768211456 * 1000000 < v2 * (1000000 - v0), false)
        }
    }

    public fun same(arg0: u128, arg1: u128, arg2: u64) : (bool, bool) {
        let v0 = (arg2 as u256);
        let v1 = if (v0 >= 1000000) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg0 > 79226673515401279992447579054) {
            true
        } else {
            arg1 > 79226673515401279992447579054
        };
        if (v1) {
            return (false, false)
        };
        let v2 = (arg0 as u256);
        let v3 = (arg1 as u256);
        if (v2 < v3) {
            (v2 * 1000000 < v3 * (1000000 - v0), true)
        } else {
            (v3 * 1000000 < v2 * (1000000 - v0), false)
        }
    }

    // decompiled from Move bytecode v7
}

