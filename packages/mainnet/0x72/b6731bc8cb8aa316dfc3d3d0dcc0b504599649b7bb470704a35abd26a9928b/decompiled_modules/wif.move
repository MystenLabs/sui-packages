module 0x72b6731bc8cb8aa316dfc3d3d0dcc0b504599649b7bb470704a35abd26a9928b::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 6, b"WIF", b"WIF", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WIF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

