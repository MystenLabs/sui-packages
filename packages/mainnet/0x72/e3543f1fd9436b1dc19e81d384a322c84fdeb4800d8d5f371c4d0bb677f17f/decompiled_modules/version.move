module 0x72e3543f1fd9436b1dc19e81d384a322c84fdeb4800d8d5f371c4d0bb677f17f::version {
    public fun assert_is_current(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

