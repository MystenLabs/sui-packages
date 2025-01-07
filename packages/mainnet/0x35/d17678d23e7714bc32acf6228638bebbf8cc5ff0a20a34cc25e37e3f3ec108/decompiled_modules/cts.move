module 0x35d17678d23e7714bc32acf6228638bebbf8cc5ff0a20a34cc25e37e3f3ec108::cts {
    struct CTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTS>(arg0, 9, b"CTS", b"CATSUI", b"Kucing dijaringan sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc5c86e6-2fa9-43cb-9259-525d676f0d4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

