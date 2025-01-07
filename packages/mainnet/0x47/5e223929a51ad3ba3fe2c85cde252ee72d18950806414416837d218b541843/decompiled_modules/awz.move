module 0x475e223929a51ad3ba3fe2c85cde252ee72d18950806414416837d218b541843::awz {
    struct AWZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWZ>(arg0, 9, b"AWZ", b"Dark", b"Not buy!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/497b3f12-3975-4c8d-bef4-5ef4f8c94e3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

