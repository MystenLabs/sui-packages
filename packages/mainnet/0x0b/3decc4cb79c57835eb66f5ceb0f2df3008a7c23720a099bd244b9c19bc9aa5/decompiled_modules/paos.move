module 0xb3decc4cb79c57835eb66f5ceb0f2df3008a7c23720a099bd244b9c19bc9aa5::paos {
    struct PAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAOS>(arg0, 6, b"PAOS", b"pumpkin Ai on sui", b"I'm pumpkin robot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1730374319274_0f14fdd0a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

