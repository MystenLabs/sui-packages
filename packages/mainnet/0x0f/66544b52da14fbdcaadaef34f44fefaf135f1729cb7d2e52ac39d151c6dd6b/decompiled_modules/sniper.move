module 0xf66544b52da14fbdcaadaef34f44fefaf135f1729cb7d2e52ac39d151c6dd6b::sniper {
    struct SNIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPER>(arg0, 6, b"Sniper", b"Snip", b"Ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie5ole2zofy2pojlfjnjk32b3jszsswb2zoc5vcmyp7wiaxrextwa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

