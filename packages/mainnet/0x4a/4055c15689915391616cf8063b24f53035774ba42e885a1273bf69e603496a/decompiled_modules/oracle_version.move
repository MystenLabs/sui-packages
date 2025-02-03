module 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_version {
    public fun next_version() : u64 {
        0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_constants::version(), 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

