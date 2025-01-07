module 0xfa333564eb69ddb65b506facb3635bf3465137610ab2705dfd7ed472832f5db2::ppaws {
    struct PPAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPAWS>(arg0, 9, b"PPAWS", b"PAWS$", b"Paws token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db2ff649-bf0e-4331-999a-29544192ccc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

