module 0xb6c09f127d1e902e617cba59704278fd6defe23fe1bce7f97a6d2f7c10b2bd91::jhgffgh {
    struct JHGFFGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHGFFGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHGFFGH>(arg0, 9, b"JHGFFGH", b"Hh", b"Njvvjkkll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/713f8da4-97d8-4127-a69e-c813f9630bf4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHGFFGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHGFFGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

