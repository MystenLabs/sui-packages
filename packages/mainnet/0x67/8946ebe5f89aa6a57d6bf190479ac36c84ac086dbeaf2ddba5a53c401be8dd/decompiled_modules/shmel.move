module 0x678946ebe5f89aa6a57d6bf190479ac36c84ac086dbeaf2ddba5a53c401be8dd::shmel {
    struct SHMEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHMEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHMEL>(arg0, 9, b"SHMEL", b"ShmelUA", b"0x875e563621C24aC93F289EdB64c022a3a81EE46A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/365270b4-3bc8-44f4-8543-f2d6b150a78e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHMEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHMEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

