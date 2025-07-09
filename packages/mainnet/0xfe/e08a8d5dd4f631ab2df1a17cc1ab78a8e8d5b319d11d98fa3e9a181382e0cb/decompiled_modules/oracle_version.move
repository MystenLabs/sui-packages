module 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_version {
    public fun next_version() : u64 {
        0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_constants::version(), 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

