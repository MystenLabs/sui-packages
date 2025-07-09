module 0x3a58e14973fc7bd17e5c477da8dcf56ea22d287447817591280093f2f2f23e04::oracle_version {
    public fun next_version() : u64 {
        0x3a58e14973fc7bd17e5c477da8dcf56ea22d287447817591280093f2f2f23e04::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x3a58e14973fc7bd17e5c477da8dcf56ea22d287447817591280093f2f2f23e04::oracle_constants::version(), 0x3a58e14973fc7bd17e5c477da8dcf56ea22d287447817591280093f2f2f23e04::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x3a58e14973fc7bd17e5c477da8dcf56ea22d287447817591280093f2f2f23e04::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

