module 0x13b3db8850748b2e3bcf46dfc436a6b277cff5229b7ac60e086d7b3b345af7ad::hgjfgh {
    struct HGJFGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGJFGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGJFGH>(arg0, 9, b"HGJFGH", b"ASDASD", b"SDFGSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d617676-bf1d-434d-9287-6f73f1851090.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGJFGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HGJFGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

