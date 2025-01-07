module 0x561cbc4e4bfeedc6cc3d7cb1d63c6bd7a8071b47f2275119152a68d22253896d::denji {
    struct DENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENJI>(arg0, 6, b"DENJI", b"POCHITA'S REAL OWNER", b"POCHITA'S REAL OWNER - DENJI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_19_49_38_3cfb1dae8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

