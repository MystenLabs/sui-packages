module 0x968807f56b9fe0f1c483b4dd24d4f2d9a314b24238a01193bee09ceb8c43a2a2::gwinch {
    struct GWINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWINCH>(arg0, 6, b"GWINCH", b"Gwinch SUI", b"The $GWINCH stole Christmas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241226_082920_275_da7b9ba7a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWINCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWINCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

