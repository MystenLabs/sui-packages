module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common {
    public(friend) fun div_away_u256(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 / arg1;
        if (v0 * arg1 == arg0) {
            v0
        } else {
            v0 + 1
        }
    }

    // decompiled from Move bytecode v7
}

