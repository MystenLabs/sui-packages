module 0xd92bac610e40833de8f4fe9323d8a68c42ba643e03ee8b0fb3ad47c581ee6534::mewvokhsh {
    struct MEWVOKHSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWVOKHSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWVOKHSH>(arg0, 9, b"MEWVOKHSH", b"Catvokhsh", b"We will go to moon with sui community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9129dc5-3765-4083-af4e-61c50d70a5f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWVOKHSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWVOKHSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

