module 0xa72eacdc19833a6d82afd87ed850ce4bf292ac717667af62f0fab345148e4bba::lot {
    public fun quantity(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        let v0 = (arg0 as u128) * 1000000000 / (1000000000 + 1250000000 * (arg1 as u128) / 1000000000);
        ((v0 - v0 % (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

