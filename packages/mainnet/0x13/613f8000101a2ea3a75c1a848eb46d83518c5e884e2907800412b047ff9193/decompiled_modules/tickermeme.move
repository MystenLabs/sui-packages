module 0x13613f8000101a2ea3a75c1a848eb46d83518c5e884e2907800412b047ff9193::tickermeme {
    struct TICKERMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKERMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKERMEME>(arg0, 9, b"TICKERMEME", b"memefa", x"205741564520f09f8c8a206d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fc05c3f-767e-4fa5-b9ef-dc2803fc25c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKERMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKERMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

