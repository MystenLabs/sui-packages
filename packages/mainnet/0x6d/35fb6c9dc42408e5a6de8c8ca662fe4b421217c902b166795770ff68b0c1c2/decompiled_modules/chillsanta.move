module 0x6d35fb6c9dc42408e5a6de8c8ca662fe4b421217c902b166795770ff68b0c1c2::chillsanta {
    struct CHILLSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSANTA>(arg0, 6, b"CHILLSANTA", b"Chill Santa", b"Chill Santa is here to bring some chilly vibe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734305547635.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLSANTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSANTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

