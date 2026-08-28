module 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::g {
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

