module 0x688a6ea22b39b74e07227f1fdca2633a8305ad90bbc8b36390b5664a1fbefc20::lili {
    struct LILI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILI>(arg0, 9, b"LILI", b"lili lili", b"Lili's here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a28685f0-6ffa-4c8e-8280-3f1614ffda0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LILI>>(v1);
    }

    // decompiled from Move bytecode v6
}

