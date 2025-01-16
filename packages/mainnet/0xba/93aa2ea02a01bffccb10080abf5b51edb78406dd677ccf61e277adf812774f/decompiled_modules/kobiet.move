module 0xba93aa2ea02a01bffccb10080abf5b51edb78406dd677ccf61e277adf812774f::kobiet {
    struct KOBIET has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBIET>(arg0, 9, b"KOBIET", b"Bimbim", b"Ko hieu tao de lam gi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1235cf44-b741-404f-90b5-54dc1b853479.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBIET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOBIET>>(v1);
    }

    // decompiled from Move bytecode v6
}

