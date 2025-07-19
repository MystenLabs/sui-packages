module 0x53c78f9bc8ddc5552248c07e3703335460114a783b8c2026473c99120d5869f9::M22 {
    struct Foo has copy, drop {
        pos0: u64,
    }

    fun x() {
        Foo{pos0: 0};
        abort 13906834238767890431
    }

    // decompiled from Move bytecode v6
}

