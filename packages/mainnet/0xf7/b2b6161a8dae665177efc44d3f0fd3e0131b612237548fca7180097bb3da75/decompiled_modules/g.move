module 0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::g {
    public fun bf(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 <= arg1, 2);
        assert!(arg1 - v0 <= 3600000, 3);
    }

    public fun mn(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

