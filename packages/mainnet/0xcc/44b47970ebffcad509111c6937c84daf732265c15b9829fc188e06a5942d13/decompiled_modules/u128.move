module 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

