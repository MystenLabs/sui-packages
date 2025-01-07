module 0x56eaa86475598d8c9575266695c4c0b26cbcd802b6ff1f864c922e08d37a4b76::shitler {
    struct SHITLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITLER>(arg0, 6, b"SHITLER", b"Suitler", b"The top is in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_73c7508d79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

