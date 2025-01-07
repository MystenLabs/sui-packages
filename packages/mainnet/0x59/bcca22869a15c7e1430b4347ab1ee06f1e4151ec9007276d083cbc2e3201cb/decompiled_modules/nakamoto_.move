module 0x59bcca22869a15c7e1430b4347ab1ee06f1e4151ec9007276d083cbc2e3201cb::nakamoto_ {
    struct NAKAMOTO_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKAMOTO_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKAMOTO_>(arg0, 9, b"NAKAMOTO_", b"Satoshi", b"It's just a secret coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16ca0510-58e5-45ab-a7b5-03cc82e02697.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAMOTO_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAKAMOTO_>>(v1);
    }

    // decompiled from Move bytecode v6
}

