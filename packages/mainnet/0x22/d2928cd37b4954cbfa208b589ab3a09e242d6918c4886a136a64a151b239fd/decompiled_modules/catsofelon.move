module 0x22d2928cd37b4954cbfa208b589ab3a09e242d6918c4886a136a64a151b239fd::catsofelon {
    struct CATSOFELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSOFELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSOFELON>(arg0, 6, b"CatsofElon", b"COF", b"Cats of Elon is a community driven project, with a vision to create an interactive ecosystem to promote blockchain technology through memes, utility and collaboration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/05i2_WE_Vl_400x400_917c714dc3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSOFELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSOFELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

