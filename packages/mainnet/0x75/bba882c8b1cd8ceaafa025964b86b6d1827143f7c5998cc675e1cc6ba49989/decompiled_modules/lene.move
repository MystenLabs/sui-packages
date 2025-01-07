module 0x75bba882c8b1cd8ceaafa025964b86b6d1827143f7c5998cc675e1cc6ba49989::lene {
    struct LENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENE>(arg0, 9, b"LENE", b"jend", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4a6b8d1-09a0-47ff-909c-8d9d34dd5608.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

