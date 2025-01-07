module 0x1b76e2728502b502345340b9c9e24fb587d67a142fe8513bd9b9b534451d2735::lch1 {
    struct LCH1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCH1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCH1>(arg0, 9, b"LCH1", b"LCH", b"Nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49b8ab75-4cf5-4f2a-a64d-0ecaf82f0774.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCH1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCH1>>(v1);
    }

    // decompiled from Move bytecode v6
}

