module 0xeed92f6c22f5fe90c87e19c2134ff42a1e7b07e4deddeefa9ccf2c6e1817cb84::ppy {
    struct PPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPY>(arg0, 9, b"PPY", b"HAppy", b"HAPPY WITH COFFE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b1f92ab-1857-47d6-9eab-8112280f9f16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

