module 0x90ed5591580a551ddd8acf0f96ab6c4e10590ee2d28cd9bfa6452d694c1549d7::monkeyface {
    struct MONKEYFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEYFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MONKEYFACE>(arg0, 6, b"MONKEYFACE", b"MONKEY FACE", b"SuiEmoji Monkey Face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/monkeyface.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONKEYFACE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEYFACE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

