module 0x62690206fc66e7b51cc657a8c1f4423ff5ebc614d59ac7db37625cb713b9123d::version {
    public fun next_version() : u64 {
        0x62690206fc66e7b51cc657a8c1f4423ff5ebc614d59ac7db37625cb713b9123d::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x62690206fc66e7b51cc657a8c1f4423ff5ebc614d59ac7db37625cb713b9123d::constants::version(), 0x62690206fc66e7b51cc657a8c1f4423ff5ebc614d59ac7db37625cb713b9123d::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x62690206fc66e7b51cc657a8c1f4423ff5ebc614d59ac7db37625cb713b9123d::constants::version()
    }

    // decompiled from Move bytecode v7
}

