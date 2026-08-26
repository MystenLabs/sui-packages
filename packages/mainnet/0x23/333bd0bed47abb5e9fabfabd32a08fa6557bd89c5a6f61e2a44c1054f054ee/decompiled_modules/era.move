module 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era {
    struct V1 has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun v1() : V1 {
        V1{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

