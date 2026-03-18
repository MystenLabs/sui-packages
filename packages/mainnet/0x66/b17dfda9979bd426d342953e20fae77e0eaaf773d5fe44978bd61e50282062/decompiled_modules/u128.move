module 0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v6
}

