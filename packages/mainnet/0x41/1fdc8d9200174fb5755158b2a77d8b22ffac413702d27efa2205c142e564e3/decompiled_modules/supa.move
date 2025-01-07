module 0x411fdc8d9200174fb5755158b2a77d8b22ffac413702d27efa2205c142e564e3::supa {
    struct SUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPA>(arg0, 6, b"SUPA", b"SUISUPA", x"535550412077696c6c204c61756e636820736f6f6e20696e2040426c75654d6f76655f4f41200a4669727374206275792046697273742050726f66697421204c65747320434f4f4b20697420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018140_4196d7e99c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

