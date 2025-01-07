module 0xfaed737df6bac03c2b76f586a9b09a42b910c54bd749a23e0e427400b02e6da2::pnkgnd {
    struct PNKGND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNKGND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNKGND>(arg0, 9, b"PNKGND", b"Pink Gndlf", b"Is it black or white , no it's pink gandalf :))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5fa8d6d-b7b4-4690-bf71-78550587e8e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNKGND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNKGND>>(v1);
    }

    // decompiled from Move bytecode v6
}

