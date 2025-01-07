module 0x38803cb82d281fd08e9747fc3c976d976ac90348013bd333614155d10d57aa6c::ag {
    struct AG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AG>(arg0, 9, b"AG", b"GENERATED", b"MEME GENERATED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c73c61f5-f4b8-4240-937b-ce08d4e3e844.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AG>>(v1);
    }

    // decompiled from Move bytecode v6
}

