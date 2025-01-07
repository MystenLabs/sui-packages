module 0x3d502554d793032f55c6472a33a84d19b0febb4d927537e2d9d55bed18d50b7::meoe {
    struct MEOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOE>(arg0, 9, b"MEOE", b"MEE", b"MOOEW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a163a76-c98a-4b78-b791-8e8d7442d7f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

