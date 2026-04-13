module 0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::version {
    struct InterfaceVersion has copy, drop, store {
        inner: u64,
    }

    public fun expect_v(arg0: &InterfaceVersion, arg1: u64) {
        assert!(arg0.inner == arg1, 13906834281717563393);
    }

    public fun number(arg0: &InterfaceVersion) : u64 {
        arg0.inner
    }

    public fun v(arg0: u64) : InterfaceVersion {
        InterfaceVersion{inner: arg0}
    }

    // decompiled from Move bytecode v6
}

