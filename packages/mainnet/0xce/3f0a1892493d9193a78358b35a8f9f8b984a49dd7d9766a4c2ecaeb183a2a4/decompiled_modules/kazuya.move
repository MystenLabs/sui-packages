module 0xce3f0a1892493d9193a78358b35a8f9f8b984a49dd7d9766a4c2ecaeb183a2a4::kazuya {
    struct KAZUYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAZUYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAZUYA>(arg0, 6, b"KAZUYA", b"KAZUYA", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAZUYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAZUYA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

