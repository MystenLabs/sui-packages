module 0xb47acdb17060f07115b2bf201c2cdfbffed07d89c88399a77d63f51423251292::wmsui {
    struct WMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMSUI>(arg0, 6, b"WMSUI", b"Waterman", x"57617465726d616e2c20746865205355497065726865726f2e204265207761746572204d460a4a6f696e20757320742e6d652f77617465726d616e5f535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957295853.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WMSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

