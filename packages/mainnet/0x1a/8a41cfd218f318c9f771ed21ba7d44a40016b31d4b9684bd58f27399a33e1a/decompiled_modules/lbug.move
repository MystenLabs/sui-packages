module 0x1a8a41cfd218f318c9f771ed21ba7d44a40016b31d4b9684bd58f27399a33e1a::lbug {
    struct LBUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBUG>(arg0, 9, b"LBUG", b"LANOCHIM", b"Let's make community together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87615c8c-266b-4c0e-b511-0efb15a7d32f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

