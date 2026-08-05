module 0x51cecaacaed0bd436f04ebbd8ba0ca1627c9c4d0e54ad28eff095ca78591518c::version {
    public fun next_version() : u64 {
        2 + 1
    }

    public fun pre_check_version(arg0: u64, arg1: u64) {
        assert!(arg0 == 2, arg1);
    }

    public fun this_version() : u64 {
        2
    }

    // decompiled from Move bytecode v7
}

