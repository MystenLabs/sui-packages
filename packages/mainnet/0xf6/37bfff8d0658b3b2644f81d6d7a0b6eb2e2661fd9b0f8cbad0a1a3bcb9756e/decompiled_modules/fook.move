module 0xf637bfff8d0658b3b2644f81d6d7a0b6eb2e2661fd9b0f8cbad0a1a3bcb9756e::fook {
    struct FOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOK>(arg0, 6, b"FOOK", b"FISHCOOK", b"Fish Cook $FOOK is the meme coin thats making waves on the Sui blockchain! Flip a fish and cook up some jokes. Fast transactions, big laughs, and zero effort requiredjust like your best joke. Get in the kitchen, now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004532_65afd5ea76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

