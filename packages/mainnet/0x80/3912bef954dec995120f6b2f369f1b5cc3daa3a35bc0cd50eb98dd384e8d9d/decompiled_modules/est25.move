module 0x803912bef954dec995120f6b2f369f1b5cc3daa3a35bc0cd50eb98dd384e8d9d::est25 {
    struct EST25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST25>(arg0, 6, b"EST25", b"dfbxfdg", b"fdvx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1738928321449-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST25>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST25>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

