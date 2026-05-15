module 0xb875de698170ddd09d2edd07041e0644f711dfc8693f613d8b2b2c7bd81bab2b::common {
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

