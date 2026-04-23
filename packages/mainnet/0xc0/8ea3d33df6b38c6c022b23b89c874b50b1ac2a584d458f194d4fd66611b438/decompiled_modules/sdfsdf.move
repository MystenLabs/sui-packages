module 0xc08ea3d33df6b38c6c022b23b89c874b50b1ac2a584d458f194d4fd66611b438::sdfsdf {
    struct SDFSDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFSDF>(arg0, 6, b"SDFSDF", b"SDFSDF", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFSDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDFSDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

