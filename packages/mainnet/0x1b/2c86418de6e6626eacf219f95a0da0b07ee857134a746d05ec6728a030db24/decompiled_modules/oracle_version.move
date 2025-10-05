module 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::oracle_version {
    public fun next_version() : u64 {
        0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::oracle_constants::version(), 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

