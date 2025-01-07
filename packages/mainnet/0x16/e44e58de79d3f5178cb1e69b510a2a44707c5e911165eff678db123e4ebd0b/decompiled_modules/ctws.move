module 0x16e44e58de79d3f5178cb1e69b510a2a44707c5e911165eff678db123e4ebd0b::ctws {
    struct CTWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTWS>(arg0, 9, b"CTWS", b"Cat", b"Head Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/835f9ca3-250a-41d3-a428-3717add43175.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

