module 0x100a4f522ce2791923c99639a9f18d8fc8c729db5b382ea2e6f54bb85410079::hodl {
    struct HODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODL>(arg0, 6, b"HODL", b"THE HODL", b"Token is a long term coin for true degen's, meme koin connoisseurs ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/photo_5447351968805804998_y_17b1453469.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODL>>(v1);
    }

    // decompiled from Move bytecode v6
}

