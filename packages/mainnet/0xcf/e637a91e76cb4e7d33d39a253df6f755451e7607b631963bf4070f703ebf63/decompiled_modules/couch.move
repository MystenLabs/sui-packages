module 0xcfe637a91e76cb4e7d33d39a253df6f755451e7607b631963bf4070f703ebf63::couch {
    struct COUCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUCH>(arg0, 6, b"COUCH", b"COUCH ON SUI", b"Chadz now this Couch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7084_98129b3728.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COUCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

