module 0x689b092e8fdbd6f780b0ce8baafd2fcb7981e21e7f55ab305a33cabd761e1f4d::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"TrumpMAGA by SuiAI", b"TRUMPMAGA Coin is a meme-powered cryptocurrency fueled by the energy of an enthusiastic and rapidly growing community. Designed for fun and engagement, TRUMPMAGA Coin was created to unite supporters of meme culture and digital assets in a new way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/magatrump_282e23ac50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

