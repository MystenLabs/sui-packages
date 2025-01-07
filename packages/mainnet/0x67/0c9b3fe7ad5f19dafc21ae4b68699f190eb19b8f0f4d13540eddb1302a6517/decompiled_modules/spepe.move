module 0x670c9b3fe7ad5f19dafc21ae4b68699f190eb19b8f0f4d13540eddb1302a6517::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 9, b"SPEPE", b"SuiPepe", b"Token community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d671cada-7943-4537-94fe-5252de7673ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

