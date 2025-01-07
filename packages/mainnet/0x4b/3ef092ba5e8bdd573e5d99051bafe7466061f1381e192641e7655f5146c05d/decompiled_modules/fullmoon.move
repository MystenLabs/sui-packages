module 0x4b3ef092ba5e8bdd573e5d99051bafe7466061f1381e192641e7655f5146c05d::fullmoon {
    struct FULLMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FULLMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FULLMOON>(arg0, 6, b"FULLMOON", b"FULL MOON", b"SuiEmoji Full Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/fullmoon.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FULLMOON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FULLMOON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

