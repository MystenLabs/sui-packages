module 0x7690df6b07b6121cb71c65a74787afb42803190ed1755a2eae792131203c0131::metaverse {
    struct METAVERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: METAVERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METAVERSE>(arg0, 6, b"METAVERSE", b"META VERSE", b"Welcome to METAVERSE  where the Internets wildest memes collide with crypto adventures. Explore uncharted territories of humor, collect epic memes, stack crypto rewards, and battle the forces trying to kill the vibe. The fun never stops, and neither should you. Dive in, level up, and let the memes rule!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/565656_a35635ad42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METAVERSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<METAVERSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

