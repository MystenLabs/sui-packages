module 0x90acd72293b1d0a64f60e678737fba46bad7e6bd560b11ef6164d88a7cdf7694::lensas {
    struct LENSAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENSAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENSAS>(arg0, 9, b"LENSAS", b"Creator", b"It is a creator of Bitcoin, but probably nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8882f0f9-4f5b-4c36-8bed-07d4f200a9af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENSAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LENSAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

