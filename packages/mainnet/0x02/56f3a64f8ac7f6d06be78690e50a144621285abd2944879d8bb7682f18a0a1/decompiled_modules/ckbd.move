module 0x256f3a64f8ac7f6d06be78690e50a144621285abd2944879d8bb7682f18a0a1::ckbd {
    struct CKBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CKBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKBD>(arg0, 9, b"CKBD", b"CryptoKup", x"43727970746f6b75705f62642054656c656772616d206368616e6e656c206f6666696369616c206d656d6520636f696e20f09faa99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e377ad6-616e-4beb-a1b3-caa656fc34bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CKBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

