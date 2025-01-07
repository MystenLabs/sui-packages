module 0x5fdc4f7fa184aa02c7642576b5985720b0b3b1d28ab98b43e00fe3c8c3c1247b::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"FISH", b"SuiEmoji Fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/fish.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FISH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

