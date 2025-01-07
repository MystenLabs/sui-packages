module 0x2e1839e58fa5168d9595aa756e528d42a22db73a2d4cb012e19ccff671c5a13::hempy {
    struct HEMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEMPY>(arg0, 6, b"HEMPY", b"Sui Hempy", x"48656d7079206973206275696c64696e67207468652066697273742044655363692d64726976656e2066617368696f6e20656d7069726520706f776572656420627920646567656e732c207265616c20736369656e63652c20616e64206361726520666f722074686520706c616e65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057166_ab275e8ad9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

