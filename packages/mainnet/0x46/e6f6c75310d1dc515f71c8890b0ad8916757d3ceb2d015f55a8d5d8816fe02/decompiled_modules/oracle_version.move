module 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_version {
    public fun next_version() : u64 {
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_constants::version(), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

