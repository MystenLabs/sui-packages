module 0xa60d511f034137c715fe83ecb8ee40c8e9df8df5cb4c8467bdf46fce0e9c7811::col {
    struct COL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COL>(arg0, 9, b"COL", b"RANGO", b"COLORFUL COLORFUL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89e75b3c-2e63-4daf-a51e-f4c10c6ead6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COL>>(v1);
    }

    // decompiled from Move bytecode v6
}

