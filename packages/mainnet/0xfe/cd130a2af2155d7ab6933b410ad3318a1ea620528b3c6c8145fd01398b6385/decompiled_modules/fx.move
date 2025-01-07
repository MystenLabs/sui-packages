module 0xfecd130a2af2155d7ab6933b410ad3318a1ea620528b3c6c8145fd01398b6385::fx {
    struct FX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FX>(arg0, 6, b"Fx", b"FOXXTOKEN", b"Foxxtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000345983_6a5a9df9c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FX>>(v1);
    }

    // decompiled from Move bytecode v6
}

