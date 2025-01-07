module 0x79e48ad587e4a655690e759d8f90d14950407e3a5ad85a9f61fa22a9c65ac551::lalatl {
    struct LALATL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALATL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALATL>(arg0, 9, b"LALATL", b"Lalal", b"What what I do you can't helps ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6c6ff59-606a-420e-b701-db064c85ec2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALATL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LALATL>>(v1);
    }

    // decompiled from Move bytecode v6
}

