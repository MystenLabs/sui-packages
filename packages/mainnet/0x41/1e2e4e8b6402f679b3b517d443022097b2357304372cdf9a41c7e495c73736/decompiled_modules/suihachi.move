module 0x411e2e4e8b6402f679b3b517d443022097b2357304372cdf9a41c7e495c73736::suihachi {
    struct SUIHACHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHACHI>(arg0, 6, b"SUIHACHI", b"HACHI SUI", x"2448414348490a0a4d65657420486163686921204a6170616e73206d6f73742061646f726564206361742077697468206d656d6561626c652065796562726f77732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Desain_tanpa_judul_2_5d37b61385.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHACHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHACHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

