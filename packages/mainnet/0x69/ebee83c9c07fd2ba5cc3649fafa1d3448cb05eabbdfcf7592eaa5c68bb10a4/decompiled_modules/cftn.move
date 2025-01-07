module 0x69ebee83c9c07fd2ba5cc3649fafa1d3448cb05eabbdfcf7592eaa5c68bb10a4::cftn {
    struct CFTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFTN>(arg0, 9, b"CFTN", b"Chiften", b"chiften of the village", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/126cd414-e916-42f5-aaa7-1aa5b4b33a2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

