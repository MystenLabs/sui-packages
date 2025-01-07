module 0xc33431342f5d13343c4300f4284941e56b22e0c6b509b405ac9a251bf47419e5::theking1 {
    struct THEKING1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEKING1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEKING1>(arg0, 9, b"THEKING1", b"tete", b"All is tete, tete is all, tete love all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5ac2234-34a6-46b7-a188-26b67473d410.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEKING1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEKING1>>(v1);
    }

    // decompiled from Move bytecode v6
}

