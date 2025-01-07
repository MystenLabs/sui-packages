module 0x38abf7e3d7d1fee97fceb24d521d84d9edb36a527a9ccf1826059324fed97d54::col {
    struct COL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COL>(arg0, 9, b"COL", b"RANGO", b"COLORFUL COLORFUL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fe59843-3b95-45ad-9c82-db5964d52686.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COL>>(v1);
    }

    // decompiled from Move bytecode v6
}

