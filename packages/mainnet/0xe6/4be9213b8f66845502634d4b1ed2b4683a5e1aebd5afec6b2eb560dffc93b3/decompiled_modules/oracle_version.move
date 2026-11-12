module 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_version {
    public fun next_version() : u64 {
        0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_constants::version(), 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_constants::version()
    }

    // decompiled from Move bytecode v7
}

