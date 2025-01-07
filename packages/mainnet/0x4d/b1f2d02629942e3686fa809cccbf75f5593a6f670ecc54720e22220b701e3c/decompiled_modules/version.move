module 0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::version {
    public(friend) fun assert_interacting_with_most_up_to_date_package(arg0: u64) {
        assert!(arg0 == 1, 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

