module 0xdbbae2ae4535d73b5a73a6bc220a0f584ddd266778bda0a5ef40287704e81449::axo {
    struct AXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXO>(arg0, 6, b"Axo", b"Axo the Axolotl", b"Axo the Axolotl | Join us on the journey into the $SUI oceans | Our aim is to onboard the next generation of users to SUI and have fun while doing it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731261436036.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

