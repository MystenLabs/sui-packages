module 0xd39eae6de9a757c6b272b78fc8fd37ed2edeced84c00f79eb6e6b05c97429fac::fvgs {
    struct FVGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FVGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FVGS>(arg0, 9, b"FVGS", b"WSRTW", b"SFFSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db7669ad-fe6e-45ee-89b5-9887258f1da9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FVGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FVGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

