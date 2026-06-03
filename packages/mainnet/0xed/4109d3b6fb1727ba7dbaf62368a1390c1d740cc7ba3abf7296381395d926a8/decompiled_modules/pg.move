module 0xed4109d3b6fb1727ba7dbaf62368a1390c1d740cc7ba3abf7296381395d926a8::pg {
    public fun chk<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, arg1 - v0);
    }

    // decompiled from Move bytecode v7
}

