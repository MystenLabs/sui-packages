module 0xc9ec08c1ac8182fdd1e08fc5c46e1fccbb6ced91fb5ca9ab4312168a858fb28a::nut {
    struct NUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUT>(arg0, 6, b"NUT", b"NUT", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

