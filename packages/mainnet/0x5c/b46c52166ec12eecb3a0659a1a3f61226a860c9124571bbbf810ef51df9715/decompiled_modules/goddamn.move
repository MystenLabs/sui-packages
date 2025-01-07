module 0x5cb46c52166ec12eecb3a0659a1a3f61226a860c9124571bbbf810ef51df9715::goddamn {
    struct GODDAMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODDAMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODDAMN>(arg0, 9, b"GODDAMN", b"DAMN", b"letsgo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6baa5971-09e2-4c93-8e41-25cab96c4288.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODDAMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODDAMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

