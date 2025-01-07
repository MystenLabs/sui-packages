module 0xaa607b07655c43966a52a50f1955ed99b34cb53b354ba33f2c6d6c42cd6e338a::spel {
    struct SPEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEL>(arg0, 9, b"SPEL", b"Gospel ", b"Charles ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c6d94e3-205c-41a0-af8a-34a71b1bd279.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

