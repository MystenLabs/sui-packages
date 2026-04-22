module 0x6babb562b62c52b8bbe33c9becd818310946453f8bef5b7482947c54ec96bf4e::fucking {
    struct FUCKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKING>(arg0, 6, b"FUCKING", b"FUCKING", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

