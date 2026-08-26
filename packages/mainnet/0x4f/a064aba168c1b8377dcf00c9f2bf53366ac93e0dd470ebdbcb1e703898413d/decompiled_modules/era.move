module 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::era {
    struct V1 has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun v1() : V1 {
        V1{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

