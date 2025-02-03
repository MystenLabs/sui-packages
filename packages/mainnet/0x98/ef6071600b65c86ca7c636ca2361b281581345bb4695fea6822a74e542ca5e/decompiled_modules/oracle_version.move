module 0x98ef6071600b65c86ca7c636ca2361b281581345bb4695fea6822a74e542ca5e::oracle_version {
    public fun next_version() : u64 {
        0x98ef6071600b65c86ca7c636ca2361b281581345bb4695fea6822a74e542ca5e::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x98ef6071600b65c86ca7c636ca2361b281581345bb4695fea6822a74e542ca5e::oracle_constants::version(), 0x98ef6071600b65c86ca7c636ca2361b281581345bb4695fea6822a74e542ca5e::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x98ef6071600b65c86ca7c636ca2361b281581345bb4695fea6822a74e542ca5e::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

