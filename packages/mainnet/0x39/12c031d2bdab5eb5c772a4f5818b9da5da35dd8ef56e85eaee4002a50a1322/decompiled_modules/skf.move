module 0x3912c031d2bdab5eb5c772a4f5818b9da5da35dd8ef56e85eaee4002a50a1322::skf {
    struct SKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKF>(arg0, 6, b"SKF", b"SuiKingFizh", b"Life Is More Funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaidpgbuwgamrmaizteoxf76l4jbecbmm7myanky2ppsd373yki4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

