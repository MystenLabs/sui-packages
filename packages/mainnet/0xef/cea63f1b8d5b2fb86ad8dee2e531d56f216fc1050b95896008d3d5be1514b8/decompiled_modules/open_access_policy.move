module 0xefcea63f1b8d5b2fb86ad8dee2e531d56f216fc1050b95896008d3d5be1514b8::open_access_policy {
    entry fun seal_approve(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1, 2);
        assert!(v0 - arg1 <= 900000, 1);
    }

    // decompiled from Move bytecode v6
}

