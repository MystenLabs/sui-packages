module 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::version {
    struct Version has store {
        value: u64,
    }

    public fun check_version(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.value, 1);
    }

    public fun initialize(arg0: u64) : Version {
        Version{value: arg0}
    }

    public fun migrate(arg0: &mut Version, arg1: u64) {
        assert!(arg1 > arg0.value, 1);
        arg0.value = arg1;
    }

    // decompiled from Move bytecode v6
}

