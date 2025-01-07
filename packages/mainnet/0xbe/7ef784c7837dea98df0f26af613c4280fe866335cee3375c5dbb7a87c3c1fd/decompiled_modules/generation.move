module 0xbe7ef784c7837dea98df0f26af613c4280fe866335cee3375c5dbb7a87c3c1fd::generation {
    struct GENERATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENERATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENERATION>(arg0, 9, b"GENERATION", b"Fairy", b"Eco SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e39eca7-1c20-4553-98f7-ed96cedc072b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENERATION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENERATION>>(v1);
    }

    // decompiled from Move bytecode v6
}

