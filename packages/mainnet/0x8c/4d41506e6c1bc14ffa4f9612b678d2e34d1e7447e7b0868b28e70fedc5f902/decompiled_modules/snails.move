module 0x8c4d41506e6c1bc14ffa4f9612b678d2e34d1e7447e7b0868b28e70fedc5f902::snails {
    struct SNAILS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAILS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAILS>(arg0, 6, b"SNAILS", b"SHELLDONSUI", b"Hello! Are you ready to 'crawl' with me on the road to conquer Suinetwork?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_23d5b7b221.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAILS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAILS>>(v1);
    }

    // decompiled from Move bytecode v6
}

