module 0xe04bda2a036b0c451a1f0fa5ea8189b9ea7d3c9cc036b8f9eb037f9c022fc470::era {
    struct ERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERA>(arg0, 9, b"ERA", b"ERAi", x"4e45572024455241690a4e45572042414c414e4345200a4e4557204449534349504c494e45203a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c286f0dcd56d9372e91f40f1d27fddb7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

