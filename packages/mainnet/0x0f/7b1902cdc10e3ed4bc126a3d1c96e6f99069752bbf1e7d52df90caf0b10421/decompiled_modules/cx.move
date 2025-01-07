module 0xf7b1902cdc10e3ed4bc126a3d1c96e6f99069752bbf1e7d52df90caf0b10421::cx {
    struct CX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CX>(arg0, 9, b"CX", b"DFH", b"XC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b7ca2be-e8c5-4a19-9f7e-59d954fa1390.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CX>>(v1);
    }

    // decompiled from Move bytecode v6
}

