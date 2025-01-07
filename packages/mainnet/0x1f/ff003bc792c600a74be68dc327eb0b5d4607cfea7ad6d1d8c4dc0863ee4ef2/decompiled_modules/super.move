module 0x1fff003bc792c600a74be68dc327eb0b5d4607cfea7ad6d1d8c4dc0863ee4ef2::super {
    struct SUPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER>(arg0, 9, b"SUPER", b"Super", b"Supoerman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dbd00db3-dd73-46d2-84bd-b1caf6f566ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

