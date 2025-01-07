module 0x22fd1898c1f3186aabadef548b8e6dc32e8079ca66f9c1fe87e6a6882069996::metachill {
    struct METACHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: METACHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METACHILL>(arg0, 6, b"Metachill", b"Metachill guy", b"Meta Chill guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241123_224719_67bcd954e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METACHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<METACHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

