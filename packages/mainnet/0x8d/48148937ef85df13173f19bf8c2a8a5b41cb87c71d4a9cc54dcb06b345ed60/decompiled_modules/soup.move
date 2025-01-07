module 0x8d48148937ef85df13173f19bf8c2a8a5b41cb87c71d4a9cc54dcb06b345ed60::soup {
    struct SOUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUP>(arg0, 6, b"SOUP", b"SOUP the Barn Kitty", b"Hi I'm Soup the Barn Kitty. Your most hilarious cat on Tiktok. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735478180926.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

