module 0xc6b1acee8b982a79c919a2fa9a363c89b4a37e0380afdcbaaa58cf18979d5d14::musk {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 9, b"MUSK", b"Vior1", b"Token oh Elon Musk ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1047da00-f935-4b9c-9227-6c40f18206b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

