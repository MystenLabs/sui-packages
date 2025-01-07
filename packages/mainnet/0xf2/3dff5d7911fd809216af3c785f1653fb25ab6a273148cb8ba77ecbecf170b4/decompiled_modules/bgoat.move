module 0xf23dff5d7911fd809216af3c785f1653fb25ab6a273148cb8ba77ecbecf170b4::bgoat {
    struct BGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGOAT>(arg0, 6, b"BGOAT", b"Baby", b"First Baby AI on SUI - Baby GOAT $BGOAT - CTO powered - Strong community $BGOAT will follow $GOAT IMHO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gafxuw_NXAAA_7_Fo1_03974144df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

