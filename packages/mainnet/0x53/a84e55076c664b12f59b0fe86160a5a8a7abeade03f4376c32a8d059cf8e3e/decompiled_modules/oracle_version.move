module 0x53a84e55076c664b12f59b0fe86160a5a8a7abeade03f4376c32a8d059cf8e3e::oracle_version {
    public fun next_version() : u64 {
        0x53a84e55076c664b12f59b0fe86160a5a8a7abeade03f4376c32a8d059cf8e3e::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x53a84e55076c664b12f59b0fe86160a5a8a7abeade03f4376c32a8d059cf8e3e::oracle_constants::version(), 0x53a84e55076c664b12f59b0fe86160a5a8a7abeade03f4376c32a8d059cf8e3e::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x53a84e55076c664b12f59b0fe86160a5a8a7abeade03f4376c32a8d059cf8e3e::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

