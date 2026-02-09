module 0xdeb92e07470e8c22aa007a6a05d49cac966d7d661cf0082db8b2c943a5ee037d::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v6
}

