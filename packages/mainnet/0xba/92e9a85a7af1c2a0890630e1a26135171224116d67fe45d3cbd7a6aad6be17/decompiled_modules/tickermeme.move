module 0xba92e9a85a7af1c2a0890630e1a26135171224116d67fe45d3cbd7a6aad6be17::tickermeme {
    struct TICKERMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKERMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKERMEME>(arg0, 9, b"TICKERMEME", b"memefa", x"205741564520f09f8c8a20666f6c6c6f77206d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ba99795-5061-4f46-9fa3-e83428dcc462.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKERMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKERMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

