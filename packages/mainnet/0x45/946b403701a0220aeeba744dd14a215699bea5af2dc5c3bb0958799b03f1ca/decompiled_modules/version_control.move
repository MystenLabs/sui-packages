module 0x45946b403701a0220aeeba744dd14a215699bea5af2dc5c3bb0958799b03f1ca::version_control {
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

