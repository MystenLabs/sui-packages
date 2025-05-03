module 0x10c228b31133693423c62f9198bba89bc7be31120defea0691c7607e8b75b4cb::ghib {
    struct GHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHIB>(arg0, 6, b"GHIB", b"Ghibli DAO", b"Ghibli DAO is the home of tokenized Ghibli artwork, assets, and communities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ghibli_b55b714aaa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

