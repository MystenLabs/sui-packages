module 0x8e1c8c8fad3be994b7cdc489ceee37faf69d072eb44741769f7d6e72abcbd623::orangutan {
    struct ORANGUTAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGUTAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ORANGUTAN>(arg0, 6, b"ORANGUTAN", b"ORANGUTAN", b"SuiEmoji Orangutan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/orangutan.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORANGUTAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGUTAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

