module 0x996ec85c5f50578fcdd4bb6cfc3331958653101cfefc2753efcff4f3ed6e1043::wd {
    struct WD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WD>(arg0, 6, b"WD", b"WiseDegen", b"This is a meme and a movement against people trying to: take over projects, just being lame to devs and admins. always want to be lead and incharge of someone else's work! No emotions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiagdxbf7qxbp3o7lc4vh7fx77cxb4fdxnnblka5q7jri7scqp66de")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

