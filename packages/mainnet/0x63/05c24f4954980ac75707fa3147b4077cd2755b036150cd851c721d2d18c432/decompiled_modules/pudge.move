module 0x6305c24f4954980ac75707fa3147b4077cd2755b036150cd851c721d2d18c432::pudge {
    struct PUDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGE>(arg0, 6, b"PUDGE", b"Pudgy Doge", b"$Pudge isnt just a look, its a lifestyle. Im here to remind you that slow and steady gets the snacks. With Pudge, were not running to the moonwere rolling there. Community-driven? Absolutely. Memes? Yes. Gains? Heavy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5118734748154440982_589a132618.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

