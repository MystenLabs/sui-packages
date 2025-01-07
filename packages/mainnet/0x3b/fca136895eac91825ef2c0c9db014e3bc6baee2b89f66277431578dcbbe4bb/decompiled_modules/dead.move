module 0x3bfca136895eac91825ef2c0c9db014e3bc6baee2b89f66277431578dcbbe4bb::dead {
    struct DEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAD>(arg0, 9, b"DEAD", b"Deadpool", b"Pamp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/208892b9-88f8-410e-ab2e-d11c85494d5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

