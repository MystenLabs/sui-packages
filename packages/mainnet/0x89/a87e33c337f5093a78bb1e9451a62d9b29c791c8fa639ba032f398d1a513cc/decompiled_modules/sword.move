module 0x89a87e33c337f5093a78bb1e9451a62d9b29c791c8fa639ba032f398d1a513cc::sword {
    struct SWORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWORD>(arg0, 6, b"SWORD", b"SWORD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWORD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

