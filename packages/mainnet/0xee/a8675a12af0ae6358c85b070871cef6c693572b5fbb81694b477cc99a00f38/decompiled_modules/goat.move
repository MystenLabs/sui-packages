module 0xeea8675a12af0ae6358c85b070871cef6c693572b5fbb81694b477cc99a00f38::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"GOAT", b"SuiEmoji Goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/goat.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

