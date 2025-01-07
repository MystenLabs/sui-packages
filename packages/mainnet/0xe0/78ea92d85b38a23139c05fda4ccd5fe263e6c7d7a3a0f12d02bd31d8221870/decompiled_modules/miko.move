module 0xe078ea92d85b38a23139c05fda4ccd5fe263e6c7d7a3a0f12d02bd31d8221870::miko {
    struct MIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKO>(arg0, 9, b"MIKO", b"Mikail ", b"To expand my knowledge and experience with the cyroptocurrency ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/853fbf39-efc1-4490-8779-85e900c0fa7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

