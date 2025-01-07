module 0x4b8ebd85c62aa86147a4ef101e427a360590f176e2a21de98e625622e468efa::else {
    struct ELSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELSE>(arg0, 6, b"ELSE", b"If", b"**IF Coin** is a meme cryptocurrency that blends internet culture and community-driven growth. Inspired by \"what if\" scenarios, it combines fun with potential utility, encouraging holders to explore new possibilities in the crypto world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732198916683.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

