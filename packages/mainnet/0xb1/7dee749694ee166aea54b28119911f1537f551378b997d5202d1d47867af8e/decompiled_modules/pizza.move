module 0xb17dee749694ee166aea54b28119911f1537f551378b997d5202d1d47867af8e::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PIZZA>(arg0, 6, b"PIZZA", b"PIZZA", b"SuiEmoji Pizza", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/pizza.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIZZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

