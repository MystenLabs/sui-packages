module 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit {
    struct Unit has drop {
        dummy_field: bool,
    }

    public fun unit() : Unit {
        Unit{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

