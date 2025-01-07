module 0x1e32e966a24af32f2f258a8066650042a300b0d448e98cf80c429ae2797a74c7::suigull {
    struct SUIGULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGULL>(arg0, 6, b"SuiGull", b"Sui Gull", x"53756947756c6c20697320726561647920746f20696e68616c65210a4e657874206d6f76652069732062696721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5878_0141d452b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

