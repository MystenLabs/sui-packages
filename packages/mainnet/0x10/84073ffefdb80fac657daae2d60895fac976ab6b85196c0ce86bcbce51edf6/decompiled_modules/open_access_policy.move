module 0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::open_access_policy {
    entry fun seal_approve(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1, 2);
        assert!(v0 - arg1 <= 900000, 1);
    }

    // decompiled from Move bytecode v6
}

