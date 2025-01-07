module 0xee4f594fdb2c185a0977e7c0d42cc65559115972f7e88f7564742a835b41b4d8::gz {
    struct GZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GZ>(arg0, 9, b"GZ", b"GAZA", b"FREE PALESTINE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b48b929e-f082-40c4-a2e9-99c5be5c502d-images - 2024-10-06T080413.681.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

