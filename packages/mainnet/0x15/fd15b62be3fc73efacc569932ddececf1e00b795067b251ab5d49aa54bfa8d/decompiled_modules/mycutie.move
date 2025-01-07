module 0x15fd15b62be3fc73efacc569932ddececf1e00b795067b251ab5d49aa54bfa8d::mycutie {
    struct MYCUTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCUTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCUTIE>(arg0, 6, b"MyCutie", b"Bubu", b"the cutest memes around the world, check it out!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bubu_9957940f86.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCUTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYCUTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

