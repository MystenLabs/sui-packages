module 0xe63c74d62ea486d3a824da1272810178b639fd7224d620d7f9d99607726c8254::sidra {
    struct SIDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDRA>(arg0, 6, b"Sidra", b"Sidra Coin", b"Sidra Chain is a revolutionary DeFi platform that combines blockchain technology with Shariah-compliant financial solutions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747870061435.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIDRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

