module 0xaf49c7affbfa652fd1808da8a031135e493a9f3a98e15bdb040fbbf0670dfe0a::agh {
    struct AGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGH>(arg0, 6, b"AGH", b"Ashaoaj", b"kakakakaakskakakoaiencmaiaj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6352_92f1c87a30.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

