module 0x215eb8cf5c54f9e6731b34fec902efb7b79f6715e0e4abbc8c4813885941c73b::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK", b"DUCK", b"SuiEmoji Duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/duck.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUCK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

