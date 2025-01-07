module 0x2464a071081952e69c3dfc46c3adc9b0d0dc5788856b83f5e2487aa4a9ef7c85::pa {
    struct PA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PA>(arg0, 9, b"PA", b"Prana", b"Life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/357c6294-2fe3-419f-a819-64434bf856ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PA>>(v1);
    }

    // decompiled from Move bytecode v6
}

