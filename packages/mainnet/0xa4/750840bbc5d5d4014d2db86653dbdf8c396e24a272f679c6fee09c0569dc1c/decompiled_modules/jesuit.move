module 0xa4750840bbc5d5d4014d2db86653dbdf8c396e24a272f679c6fee09c0569dc1c::jesuit {
    struct JESUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUIT>(arg0, 6, b"JESUIT", b"JESUITS", b"The Jesuits, or Society of Jesus, are a Catholic order founded in 1540 by Ignatius of Loyola. They are known for their educational institutions, missionary work, and commitment to social justice worldwide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_e3576af6b2.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

