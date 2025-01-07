module 0x27e893792c0ea207ebfa578681c7062eb3eabc50ef482c71aace25284dc4ca21::hero {
    struct HERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERO>(arg0, 6, b"HERO", b"Luigi Mangione", b"This man needs no socials. He's an american hero.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007689_18bd1be879.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

