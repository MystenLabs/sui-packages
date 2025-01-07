module 0x5a0615cc9afa072734081c2d0262ada30e0750b487dfb9476793d015ad26ae68::wop {
    struct WOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOP>(arg0, 9, b"WOP", b"Pow", b"Test 123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea1e2f3a-d612-4f47-bff6-315ff5ffde58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

