module 0xf416de37de34e3b1597a0e0d3244e79124f0c3ee60a39eb7cb314948836f4976::common {
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

