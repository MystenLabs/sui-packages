module 0xf075fd2238d948b609a15776672abb973f9c92ab516c51d4b07c77a265aeeaa0::sevil {
    struct SEVIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEVIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEVIL>(arg0, 6, b"SEVIL", b"Sevil Sui", b"SEVIL Cooking: Bullish and SUI $20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_a4e288acbc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEVIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEVIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

