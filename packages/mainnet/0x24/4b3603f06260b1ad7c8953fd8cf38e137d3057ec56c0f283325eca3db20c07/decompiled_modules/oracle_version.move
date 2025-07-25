module 0x244b3603f06260b1ad7c8953fd8cf38e137d3057ec56c0f283325eca3db20c07::oracle_version {
    public fun next_version() : u64 {
        0x244b3603f06260b1ad7c8953fd8cf38e137d3057ec56c0f283325eca3db20c07::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x244b3603f06260b1ad7c8953fd8cf38e137d3057ec56c0f283325eca3db20c07::oracle_constants::version(), 0x244b3603f06260b1ad7c8953fd8cf38e137d3057ec56c0f283325eca3db20c07::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x244b3603f06260b1ad7c8953fd8cf38e137d3057ec56c0f283325eca3db20c07::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

