module 0x2375797ec86a5146707e63fa3c204082248a98feb51aaa86ee8f9983d4352c8a::belon {
    struct BELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELON>(arg0, 6, b"BELON", b"Baby Elon", b"Baby Elon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8089_5f1d863e69.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

