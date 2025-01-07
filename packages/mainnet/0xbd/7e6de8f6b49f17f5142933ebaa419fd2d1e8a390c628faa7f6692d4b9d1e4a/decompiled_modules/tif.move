module 0xbd7e6de8f6b49f17f5142933ebaa419fd2d1e8a390c628faa7f6692d4b9d1e4a::tif {
    struct TIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIF>(arg0, 6, b"TIF", b"This is fine", b"\"This is Fine\" Coin (TIF) is a community-driven memecoin inspired by the iconic \"This is fine\" meme. Just like the dog sitting calmly in a burning room, TIF embraces the chaotic and unpredictable nature of the crypto world with humor and resilience. Whether the markets on fire or the world seems upside down, TIF holders stay cool and collected, navigating the volatility with a smile.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/200_dd02699a30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

