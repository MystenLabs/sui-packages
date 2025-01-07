module 0x5bbe79d5fd5baa7d2d9ba0307fbe5f5ec5c66ef7c62894bbfed3f8cb71e93c15::lcoin {
    struct LCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LCOIN>(arg0, 6, b"LCOIN", b"LaughCoin", b"A fun meme token with a smiley icon, spreading joy, community vibes, and endless crypto laughs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/meme_b09afe613b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LCOIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCOIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

