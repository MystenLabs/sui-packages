module 0x7527e34e3aff81adcba26f3e3711fe2a307873c2b0d5b43d26571b27693d0fea::wewek {
    struct WEWEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEK>(arg0, 9, b"WEWEK", b"Wiwiwk", b"Wewekgombel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40c81f79-8614-4354-9f26-f0b2e10edb4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

