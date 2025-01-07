module 0x67f9279966605c79cf2ab45d2a946e9f56b3237b96513135dd9b9137cbeaf116::suib {
    struct SUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIB>(arg0, 6, b"SUIB", b"suiberia", b"Siberia snus lover cult", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7377_309d83ef99.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

