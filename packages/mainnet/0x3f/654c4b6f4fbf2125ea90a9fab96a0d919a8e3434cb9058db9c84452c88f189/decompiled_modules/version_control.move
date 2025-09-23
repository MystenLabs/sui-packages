module 0x3f654c4b6f4fbf2125ea90a9fab96a0d919a8e3434cb9058db9c84452c88f189::version_control {
    struct V__1_0_0 has copy, drop, store {
        dummy_field: bool,
    }

    struct V__DUMMY has copy, drop, store {
        dummy_field: bool,
    }

    public fun current_version() : V__1_0_0 {
        V__1_0_0{dummy_field: false}
    }

    public fun previous_version() : V__DUMMY {
        V__DUMMY{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

