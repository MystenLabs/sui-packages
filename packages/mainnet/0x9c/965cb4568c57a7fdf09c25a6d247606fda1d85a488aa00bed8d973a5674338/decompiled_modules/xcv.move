module 0x9c965cb4568c57a7fdf09c25a6d247606fda1d85a488aa00bed8d973a5674338::xcv {
    struct XCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCV>(arg0, 9, b"XCV", b"G", b"SZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15402e33-643d-476f-9424-a100c8781887.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

