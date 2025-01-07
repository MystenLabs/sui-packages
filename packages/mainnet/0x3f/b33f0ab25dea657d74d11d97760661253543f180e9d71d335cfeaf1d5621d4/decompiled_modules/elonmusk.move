module 0x3fb33f0ab25dea657d74d11d97760661253543f180e9d71d335cfeaf1d5621d4::elonmusk {
    struct ELONMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMUSK>(arg0, 9, b"ELONMUSK", b"D.O.G.E", b"Department of Government Efficiency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bcbf4d1-58b5-4ca1-b643-59909a0d2894.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

