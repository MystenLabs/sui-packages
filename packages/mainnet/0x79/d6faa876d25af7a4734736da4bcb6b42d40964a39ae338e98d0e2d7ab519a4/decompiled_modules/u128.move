module 0x79d6faa876d25af7a4734736da4bcb6b42d40964a39ae338e98d0e2d7ab519a4::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v6
}

