module 0xf2c3e46006f5a925328168e48af2d0960aa74a8c3802dd46dc040e3551331098::nems {
    struct NEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMS>(arg0, 9, b"NEMS", b"Games", b"Games token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/233844bf-8ad1-4f6b-991c-5f8e0791e052.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

