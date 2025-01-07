module 0xb3a9180ecdf492b3e6a183b15d41aff91047a3ba65917df1c37ee03e6c4d6623::ienne {
    struct IENNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IENNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IENNE>(arg0, 9, b"IENNE", b"bdbd", b"bdbdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6ef2df7-8347-4c3d-802f-7ff12946b2d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IENNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IENNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

