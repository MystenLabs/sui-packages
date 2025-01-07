module 0x5076790df6c01ec48773d17cf3c85b0579296d3224f09975028f26fd73608461::gig {
    struct GIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIG>(arg0, 9, b"GIG", b"Efemoni", x"517569636b20616e642065617379e29c8cefb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15aa514c-e2a8-425c-8ebb-12f43c8e5e6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

