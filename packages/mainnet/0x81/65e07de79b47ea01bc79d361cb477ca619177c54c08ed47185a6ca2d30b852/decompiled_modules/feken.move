module 0x8165e07de79b47ea01bc79d361cb477ca619177c54c08ed47185a6ca2d30b852::feken {
    struct FEKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEKEN>(arg0, 9, b"FEKEN", b"hdjd", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e7878e8-713f-4f74-a55a-73bf7600909d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

