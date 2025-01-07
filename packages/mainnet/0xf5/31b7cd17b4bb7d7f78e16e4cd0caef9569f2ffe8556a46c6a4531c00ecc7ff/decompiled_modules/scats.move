module 0xf531b7cd17b4bb7d7f78e16e4cd0caef9569f2ffe8556a46c6a4531c00ecc7ff::scats {
    struct SCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCATS>(arg0, 6, b"SCATS", b"SuiAICATS", b"$SCATS the future meme coin with utility and comunity will grow up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241002_024557_fa8b956a8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

