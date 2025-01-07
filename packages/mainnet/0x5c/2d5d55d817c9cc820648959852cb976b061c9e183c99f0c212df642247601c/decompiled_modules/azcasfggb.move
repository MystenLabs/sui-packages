module 0x5c2d5d55d817c9cc820648959852cb976b061c9e183c99f0c212df642247601c::azcasfggb {
    struct AZCASFGGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZCASFGGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZCASFGGB>(arg0, 9, b"AZCASFGGB", x"64e1babb676564", b"fzdsfcxb cvnrth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38001fda-587a-42b0-8bf4-4a16e3335ca0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZCASFGGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZCASFGGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

