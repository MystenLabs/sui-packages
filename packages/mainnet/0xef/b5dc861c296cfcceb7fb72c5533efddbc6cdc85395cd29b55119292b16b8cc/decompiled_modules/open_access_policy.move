module 0xefb5dc861c296cfcceb7fb72c5533efddbc6cdc85395cd29b55119292b16b8cc::open_access_policy {
    entry fun seal_approve(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1, 2);
        assert!(v0 - arg1 <= 900000, 1);
    }

    // decompiled from Move bytecode v6
}

