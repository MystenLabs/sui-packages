module 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::version {
    public fun next_version() : u64 {
        0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::constants::version(), 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::constants::version()
    }

    // decompiled from Move bytecode v6
}

