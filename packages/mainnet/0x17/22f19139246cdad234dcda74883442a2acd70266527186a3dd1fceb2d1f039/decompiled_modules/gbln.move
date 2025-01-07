module 0x1722f19139246cdad234dcda74883442a2acd70266527186a3dd1fceb2d1f039::gbln {
    struct GBLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBLN>(arg0, 6, b"GBLN", b"Goblin", b"Bullish this one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000194855_1bba77bbd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

