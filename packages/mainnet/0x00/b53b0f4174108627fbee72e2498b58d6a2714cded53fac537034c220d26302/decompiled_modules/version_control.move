module 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::version_control {
    struct V__0_1_1 has copy, drop, store {
        dummy_field: bool,
    }

    struct V__DUMMY has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun current_version() : V__0_1_1 {
        V__0_1_1{dummy_field: false}
    }

    public(friend) fun previous_version() : V__DUMMY {
        V__DUMMY{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

