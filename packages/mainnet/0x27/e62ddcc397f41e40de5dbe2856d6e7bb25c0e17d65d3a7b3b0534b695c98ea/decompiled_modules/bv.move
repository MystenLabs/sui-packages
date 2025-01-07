module 0x27e62ddcc397f41e40de5dbe2856d6e7bb25c0e17d65d3a7b3b0534b695c98ea::bv {
    struct BV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BV>(arg0, 9, b"BV", b"FJN", b"XCB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92065f6d-cba5-49f5-9cc1-6cf7164b72d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BV>>(v1);
    }

    // decompiled from Move bytecode v6
}

