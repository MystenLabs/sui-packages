module 0xba8cca31763948ff5cd4b687e5147a9a4a122a9487d84bea816fbf823cc08597::tao {
    struct TAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAO>(arg0, 6, b"TAO", b"The Anthropic Order", b"without humanity, there are no machines ai is a product of humanity this is our claim to dominance once again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733445352499.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

