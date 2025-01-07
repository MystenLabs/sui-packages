module 0x704eee55f13977371694cbb03a9af007f788ee048980769f5e71879e938329e7::golem {
    struct GOLEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLEM>(arg0, 6, b"GOLEM", b"Golems", b"We're all golems. Sell your rocks and buy GOLEMS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/autocollant_racaillou_pokemon_074_df95e4b035.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

