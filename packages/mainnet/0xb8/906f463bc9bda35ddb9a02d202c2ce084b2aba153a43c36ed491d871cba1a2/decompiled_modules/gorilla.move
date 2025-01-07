module 0xb8906f463bc9bda35ddb9a02d202c2ce084b2aba153a43c36ed491d871cba1a2::gorilla {
    struct GORILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GORILLA>(arg0, 6, b"GORILLA", b"GORILLA", b"SuiEmoji Gorilla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/gorilla.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GORILLA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORILLA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

