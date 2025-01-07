module 0x1454088ebfb33bbb4bfc4b0c8ef55f01ad9245462b9149894c7a239322278d85::worm {
    struct WORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WORM>(arg0, 6, b"WORM", b"WORM", b"SuiEmoji Worm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/worm.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WORM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

