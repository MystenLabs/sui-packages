module 0x8d18843d4a183a8b372157d8fa5e652fa1b7ac7a1de2c6ebf5d443837fea5448::penguin {
    struct PENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUIN>(arg0, 6, b"PENGUIN", b"Nietzschean Penguin", b"This viral penguin known as the \"Nietzschean Penguin\" is doing millions of impressions all over Tik-Tok and X! The tiktok comments are calling him the \"Nietzschean Penguin\" he turns his back on the colony, and away from the hunting grounds in search ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1769269458821.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGUIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

