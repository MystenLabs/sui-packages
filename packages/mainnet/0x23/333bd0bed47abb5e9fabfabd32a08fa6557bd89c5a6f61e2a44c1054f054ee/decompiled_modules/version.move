module 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version {
    struct InterfaceVersion has copy, drop, store {
        inner: u64,
    }

    public fun expect_v(arg0: &InterfaceVersion, arg1: u64) {
        assert!(arg0.inner == arg1, 13906834324667236353);
    }

    public fun number(arg0: &InterfaceVersion) : u64 {
        arg0.inner
    }

    public fun v(arg0: u64) : InterfaceVersion {
        InterfaceVersion{inner: arg0}
    }

    // decompiled from Move bytecode v7
}

