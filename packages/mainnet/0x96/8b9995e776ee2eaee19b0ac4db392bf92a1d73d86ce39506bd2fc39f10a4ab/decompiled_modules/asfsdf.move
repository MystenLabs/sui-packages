module 0x968b9995e776ee2eaee19b0ac4db392bf92a1d73d86ce39506bd2fc39f10a4ab::asfsdf {
    struct ASFSDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASFSDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASFSDF>(arg0, 9, b"ASFSDF", b"fsdfsdf", b"Asfdsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3511774d-7dcf-4a9e-90e8-f94c8c6f89b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASFSDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASFSDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

