module 0x59f04f0f401e9c4698bb49e7adf2e16a3c3cbb3a14d7e901bf48c2702388df5c::mug {
    struct MUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUG>(arg0, 6, b"MUG", b"Elon's Mug", b"everyone pays attention to Elon Musk. But no-one bothers about his most important accessory, his mug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5009c167f3bb54e5494acb3ef2d9fe11_2249ff54a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

