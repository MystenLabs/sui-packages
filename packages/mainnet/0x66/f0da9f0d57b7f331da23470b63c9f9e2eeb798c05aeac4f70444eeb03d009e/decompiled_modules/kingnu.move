module 0x66f0da9f0d57b7f331da23470b63c9f9e2eeb798c05aeac4f70444eeb03d009e::kingnu {
    struct KINGNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGNU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGNU>(arg0, 9, b"KINGNU", b"KING INU", x"2047657420796f75722070617773206f6e204b696e676e7520746f6461792c20616e6420746f676574686572207765e280996c6c206261726b20616c6c207468652077617920746f20746865206d6f6f6e2120f09f9a80f09f8c9520234b696e676e75546f6b656e2023446f67676f506f776572202350617773546f5468654d6f6f6e2023737569646f6720236e65787420696e75", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/706b40a0-28ba-4dba-8dbf-38b061b8bef4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGNU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KINGNU>>(v1);
    }

    // decompiled from Move bytecode v6
}

