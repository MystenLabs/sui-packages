module 0xfcdf201087a9af1a8aaa4a85292c78592c52259bf4270963225d13f5e49bc4da::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v6
}

