module 0x53e004b97599ef536fb06f6c6bdc5d7a55d504543c764ce259dda09fbb51ae34::white {
    struct WHITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITE>(arg0, 6, b"WHITE", b"The White Meme", b"Only WHITE, nothing else. That's WHITE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/whitememe_3415d412b4.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

