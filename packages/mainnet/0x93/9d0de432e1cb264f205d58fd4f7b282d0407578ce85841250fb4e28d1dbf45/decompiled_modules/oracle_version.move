module 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_version {
    public fun next_version() : u64 {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_constants::version(), 0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x939d0de432e1cb264f205d58fd4f7b282d0407578ce85841250fb4e28d1dbf45::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

