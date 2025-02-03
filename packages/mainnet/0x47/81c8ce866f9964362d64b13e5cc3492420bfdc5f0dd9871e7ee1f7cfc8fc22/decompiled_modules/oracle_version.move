module 0xb026eeb6fdb5161a148657ad8fd64abd238aae36e2eef2e0bbee0bcf10ba1c41::oracle_version {
    public fun next_version() : u64 {
        0xb026eeb6fdb5161a148657ad8fd64abd238aae36e2eef2e0bbee0bcf10ba1c41::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xb026eeb6fdb5161a148657ad8fd64abd238aae36e2eef2e0bbee0bcf10ba1c41::oracle_constants::version(), 0xb026eeb6fdb5161a148657ad8fd64abd238aae36e2eef2e0bbee0bcf10ba1c41::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xb026eeb6fdb5161a148657ad8fd64abd238aae36e2eef2e0bbee0bcf10ba1c41::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

