module 0xa584ec4a6f029c3ac4d5ac4ac670f6dcc30b65462e5e096642d6d80957db3122::mew2 {
    struct MEW2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW2>(arg0, 6, b"Mew2", b"MewTwo", b"congrats, you found it. Mew rugged, Pika rugged, vaporeon rugged, suitto rugged, literally fuck them. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_99441e5fea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEW2>>(v1);
    }

    // decompiled from Move bytecode v6
}

