module 0xbf661b3a135ed7995a5b08d82b2061715fff7a239bf4991cb409206937944c7::oekdn {
    struct OEKDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEKDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEKDN>(arg0, 9, b"OEKDN", b"jsjene", b"bdbdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/912eb453-3f12-4e5a-a09f-5bd2a0114e8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEKDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEKDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

