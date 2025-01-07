module 0x7eadc2a7ddfa3c2473809e0fd3c20453e52f1c8d68e085600afb875b39db4a01::moneymouthface {
    struct MONEYMOUTHFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONEYMOUTHFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MONEYMOUTHFACE>(arg0, 6, b"MONEYMOUTHFACE", b"MONEY-MOUTH FACE", b"SuiEmoji Money-Mouth Face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/moneymouthface.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONEYMOUTHFACE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONEYMOUTHFACE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

