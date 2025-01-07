module 0xd73e325436ebf79899a01bb450728ea8786ad085bc6e3b49049b30d483ee9ce7::heidi {
    struct HEIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEIDI>(arg0, 9, b"HEIDI", b"Heidi cat", b"Heidicat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0dc8e1be-8b53-4edf-bb6f-e3f4e1e153c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

