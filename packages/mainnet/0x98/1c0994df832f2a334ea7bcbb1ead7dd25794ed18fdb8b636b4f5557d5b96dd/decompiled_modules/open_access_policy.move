module 0x981c0994df832f2a334ea7bcbb1ead7dd25794ed18fdb8b636b4f5557d5b96dd::open_access_policy {
    entry fun seal_approve(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1, 2);
        assert!(v0 - arg1 <= 900000, 1);
    }

    // decompiled from Move bytecode v6
}

