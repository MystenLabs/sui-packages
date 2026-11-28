module 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ratio {
    public(friend) fun frac_down(arg0: u256, arg1: u256, arg2: u256) : u256 {
        arg0 / arg1 * arg2 + arg0 % arg1 * arg2 / arg1
    }

    public(friend) fun frac_up(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 % arg1 * arg2;
        if (v0 % arg1 != 0) {
            arg0 / arg1 * arg2 + v0 / arg1 + 1
        } else {
            arg0 / arg1 * arg2 + v0 / arg1
        }
    }

    public(friend) fun signed_ratio(arg0: bool, arg1: u256, arg2: u256, arg3: bool) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        let v0 = if (arg0 != arg3) {
            frac_up(arg1, arg2, 1000000000000000000)
        } else {
            frac_down(arg1, arg2, 1000000000000000000)
        };
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

