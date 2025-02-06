module 0x7178dbadabb256cf4452875b00536b5e5cf249211fcb3669b01ceaea0340da8c::onemill {
    struct ONEMILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEMILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEMILL>(arg0, 9, b"ONEMILL", b"1$ TO 1M$", x"496e7665737420312053756920746f2031204d494c4c20f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf464a8d-73dc-4ba9-b0ab-53c1998d907f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEMILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEMILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

