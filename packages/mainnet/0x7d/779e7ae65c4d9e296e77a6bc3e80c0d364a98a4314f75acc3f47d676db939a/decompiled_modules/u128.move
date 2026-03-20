module 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v6
}

