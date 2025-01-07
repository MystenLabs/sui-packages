module 0x900986c0bd4e3fc5e877425f2a47ff65d35849bc828d23366d1e4e575fd99828::lampro {
    struct LAMPRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMPRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMPRO>(arg0, 9, b"LAMPRO", b"SEIKA", b"Seika Lamprogue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea60c563-973d-4e52-8a12-a43f110cb74c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMPRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMPRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

