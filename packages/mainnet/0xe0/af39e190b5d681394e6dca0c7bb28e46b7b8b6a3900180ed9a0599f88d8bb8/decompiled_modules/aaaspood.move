module 0xe0af39e190b5d681394e6dca0c7bb28e46b7b8b6a3900180ed9a0599f88d8bb8::aaaspood {
    struct AAASPOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASPOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASPOOD>(arg0, 6, b"aaaSPOOD", b"aaa SPOODER SUI", b"Can't stop won't stop (thinking about SPOODER SUI) aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spid_6796d7bee2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASPOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASPOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

