module 0x4e25a07a11817de982721a7d181ef80c043dfdef423f485e9cc22aa0d99877d7::bakso {
    struct BAKSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSO>(arg0, 6, b"BAKSO", b"Bakso Sui Tiger", x"42616b736f20537569205469676572206375622066726f6d204469736e6579277320416e696d616c204b696e67646f6d2e20436f6d6d756e6974792072616e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_10_17_000112_d602212368_e961799368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

