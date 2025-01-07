module 0x400ca4078e51d490cbc2f4c5a3d1a642fd62e244601bc2833bbda54a93b95249::hnmt {
    struct HNMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNMT>(arg0, 9, b"HNMT", b"Hpkl", x"c49166677364", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d39abb1-7f7e-4e18-8fe5-493163bef246.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

