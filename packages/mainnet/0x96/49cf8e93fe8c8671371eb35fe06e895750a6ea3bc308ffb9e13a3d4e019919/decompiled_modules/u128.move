module 0x9649cf8e93fe8c8671371eb35fe06e895750a6ea3bc308ffb9e13a3d4e019919::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

