module 0xe15ec1f4ddebee10264c9bc2a783e6cd32e965b62f3d52652740cc8461b77a03::sadfd {
    struct SADFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADFD>(arg0, 6, b"SADFD", b"SADFD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SADFD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

