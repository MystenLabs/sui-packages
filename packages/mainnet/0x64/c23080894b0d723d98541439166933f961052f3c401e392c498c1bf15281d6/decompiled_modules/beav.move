module 0x64c23080894b0d723d98541439166933f961052f3c401e392c498c1bf15281d6::beav {
    struct BEAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAV>(arg0, 6, b"BEAV", b"SUIBEAV", b"In the rapidly evolving world of cryptocurrency, where meme coins have become a significant trend, the story of Beav the Beaver stands out as a unique blend of cultural phenomenon and blockchain innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_24_766117eb17_1_eec6adf45e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

