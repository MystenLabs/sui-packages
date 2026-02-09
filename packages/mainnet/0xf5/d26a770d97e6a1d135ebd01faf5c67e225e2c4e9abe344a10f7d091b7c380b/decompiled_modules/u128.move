module 0xf5d26a770d97e6a1d135ebd01faf5c67e225e2c4e9abe344a10f7d091b7c380b::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v6
}

