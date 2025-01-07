module 0x1fd4e153e52ff4cf249223e6519ec64eaf25f3c68077f98d2b1a55cdcf486c7::www {
    struct WWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWW>(arg0, 6, b"WWW", b"Willy WobbleWater", b"Willy Wobblewater is a hilariously clumsy water creature that resembles a cross between a jellyfish and a goofy marshmallow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/document_1_226214f585.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

