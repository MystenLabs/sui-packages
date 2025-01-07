module 0x97411a9f168894274f60d26844f508fac36c1eb2f76e7dcc537790adae6153bf::elonmusk {
    struct ELONMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMUSK>(arg0, 6, b"ElonMusk", b"Starship", b"Starship meme coin organized by the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KX_4d2j_XG_400x400_0ddb9b8354.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

