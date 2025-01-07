module 0x370d17631fad0f36c08b87173ff5504e0e22c2172703d0123394a0c1ef17e279::onepiece97 {
    struct ONEPIECE97 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEPIECE97, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEPIECE97>(arg0, 9, b"ONEPIECE97", b"Onepiece ", b"Fan token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37b05533-9e2c-4435-978d-918d3f2f49ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEPIECE97>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEPIECE97>>(v1);
    }

    // decompiled from Move bytecode v6
}

