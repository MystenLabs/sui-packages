module 0xd57cd76ada1cf36928ae38939f91d7f1fd662040955ed1c1604ea3f739b4906d::sqrt_limit {
    public(friend) fun bounded(arg0: u128, arg1: bool, arg2: u128, arg3: u128) : u128 {
        if (arg1) {
            let v1 = arg0 * (10000 - 500) / 10000;
            if (v1 < arg2) {
                arg2
            } else {
                v1
            }
        } else {
            let v2 = arg0 * (10000 + 500) / 10000;
            if (v2 > arg3) {
                arg3
            } else {
                v2
            }
        }
    }

    public(friend) fun usable(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg1 < arg0 || arg1 > arg0
    }

    // decompiled from Move bytecode v7
}

