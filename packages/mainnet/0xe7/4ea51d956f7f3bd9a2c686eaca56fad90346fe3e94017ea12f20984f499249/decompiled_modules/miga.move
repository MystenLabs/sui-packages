module 0xe74ea51d956f7f3bd9a2c686eaca56fad90346fe3e94017ea12f20984f499249::miga {
    struct MIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGA>(arg0, 9, b"MIGA", b"Tiger", b"Crying Tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8575e8d7-ab87-4361-90a6-149bcd565530.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

