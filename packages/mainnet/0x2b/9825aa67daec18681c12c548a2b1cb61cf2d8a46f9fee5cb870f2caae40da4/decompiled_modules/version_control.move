module 0x2b9825aa67daec18681c12c548a2b1cb61cf2d8a46f9fee5cb870f2caae40da4::version_control {
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

