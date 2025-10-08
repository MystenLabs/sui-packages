module 0xceee8b58cade9d5e65c02944f2851ce75ca9b30090efb570ae997b6c09e2c8e8::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"PANDA2262", b"Cosmic Panda #2262", b"A mystical panda floating through the cosmos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/cosmic-panda.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

