module 0xb8c94f8eea0c6ba6faf2270c5815d31254202d5a663f6797237eadcfe0dcd3f0::nan {
    struct NAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = if (0x1::vector::is_empty<u8>(&v0)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<NAN>(arg0, 6, b"NAN", b"nzn", b"nznznzn", v1, arg1);
        0x288bd69b11d4eeb690e48b03f7711fea7a6879df204f31301c1d535c5416fb61::curve::launch<NAN>(v2, v3, arg1);
    }

    // decompiled from Move bytecode v7
}

