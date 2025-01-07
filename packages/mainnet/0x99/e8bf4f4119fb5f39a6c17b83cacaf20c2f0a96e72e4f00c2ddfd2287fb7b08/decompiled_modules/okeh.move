module 0x99e8bf4f4119fb5f39a6c17b83cacaf20c2f0a96e72e4f00c2ddfd2287fb7b08::okeh {
    struct OKEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKEH>(arg0, 9, b"OKEH", b"jsjene", b"vs w", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c6e02d0-7593-426c-acd4-1e2d8ad71b3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKEH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKEH>>(v1);
    }

    // decompiled from Move bytecode v6
}

