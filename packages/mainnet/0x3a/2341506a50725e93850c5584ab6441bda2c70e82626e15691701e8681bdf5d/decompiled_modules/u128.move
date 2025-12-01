module 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v6
}

