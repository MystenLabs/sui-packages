module 0x4193b851703f0ddfef8d5e3d7cc4299a35f28b2e13a22c05afd8b6d037d96110::cat2 {
    struct CAT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CAT2>(arg0, 6, b"CAT2", b"CAT", b"SuiEmoji Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/cat2.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAT2>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT2>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

