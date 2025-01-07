module 0xabbda0710e9246e1c9b3393b9a6166b9597d69b672912b9e39e5be83d1005886::worms {
    struct WORMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORMS>(arg0, 6, b"WORMS", x"574f524d204f4e205355c4b0", b"first meme worm token on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731621356896.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WORMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

