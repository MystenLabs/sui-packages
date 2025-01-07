module 0x41221d3e03572098fd9f5acd6e2ddf2f30489a36e29ef76789fc40a285b62fd4::jupcat {
    struct JUPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUPCAT>(arg0, 6, b"Jupcat", b"JUPCAT", b"Jupiter is the best decentralized exchange platform. It will update its latest logo and create a meme coin: JUPCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241013_133126_d25d879d7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

