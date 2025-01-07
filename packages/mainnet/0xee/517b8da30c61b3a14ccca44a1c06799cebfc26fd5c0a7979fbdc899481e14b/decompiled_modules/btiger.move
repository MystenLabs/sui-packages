module 0xee517b8da30c61b3a14ccca44a1c06799cebfc26fd5c0a7979fbdc899481e14b::btiger {
    struct BTIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTIGER>(arg0, 9, b"BTIGER", b"BABYTIGER", b"Ff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a7322f0-a509-4685-8443-20798d343547.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

