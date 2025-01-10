module 0x34992d0e9bbdf48107e34bcfd4332bbfa759a165e891bea4714824f12c43212a::notai {
    struct NOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTAI>(arg0, 9, b"NOTAI", b"NOT_AI", b"NOTAI (GEM)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61b1c108-0bc6-4feb-87a0-07013bc85e45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

