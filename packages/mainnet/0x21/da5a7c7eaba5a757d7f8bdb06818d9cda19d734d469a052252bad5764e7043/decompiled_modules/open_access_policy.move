module 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::open_access_policy {
    entry fun seal_approve(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1, 2);
        assert!(v0 - arg1 <= 900000, 1);
    }

    // decompiled from Move bytecode v6
}

