module 0x8433fe6d633e5324c11fb86d26e0b5aebeeb1a0c533909023e4297d8fe2b73f2::kaori {
    struct KAORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAORI>(arg0, 9, b"KAORI", b"KAO", b"KAORI THE LIZARD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cfb91c03-488a-472e-b744-a0cba91363be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

