module 0x47a3c11a9fc9f4c0800b670b75bd32c0b48e53d0ef237aee18dd2b6a0d906bb7::oracle_version {
    public fun next_version() : u64 {
        0x47a3c11a9fc9f4c0800b670b75bd32c0b48e53d0ef237aee18dd2b6a0d906bb7::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x47a3c11a9fc9f4c0800b670b75bd32c0b48e53d0ef237aee18dd2b6a0d906bb7::oracle_constants::version(), 0x47a3c11a9fc9f4c0800b670b75bd32c0b48e53d0ef237aee18dd2b6a0d906bb7::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x47a3c11a9fc9f4c0800b670b75bd32c0b48e53d0ef237aee18dd2b6a0d906bb7::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

