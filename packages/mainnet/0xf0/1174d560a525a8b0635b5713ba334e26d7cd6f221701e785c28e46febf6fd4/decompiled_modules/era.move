module 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::era {
    struct V1 has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun v1() : V1 {
        V1{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

