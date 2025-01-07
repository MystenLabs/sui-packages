module 0xca2201769c8f4dcfd2f916a2afbd17a1f9e10cc959051a5ff6ba62232259b0f1::amber {
    struct AMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBER>(arg0, 6, b"AMBER", b"Amber Baldet", b"A meme coin for Amber Baldet, co-founder of Clovyr and a blockchain leader.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Amber_Baldet_Coin_f319fe1a2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

