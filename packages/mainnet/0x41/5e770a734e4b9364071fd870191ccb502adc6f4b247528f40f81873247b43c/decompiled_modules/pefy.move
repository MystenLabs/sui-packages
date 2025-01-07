module 0x415e770a734e4b9364071fd870191ccb502adc6f4b247528f40f81873247b43c::pefy {
    struct PEFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEFY>(arg0, 6, b"PEFY", b"Pefy the Frog", b"PEFY represents Pepes inner child, a community-centric meme token that draws inspiration from the cherished internet sensation, Pepe the Frog. Immerse yourself in the fun, contribute to the communitys growth, and potentially enjoy a fruitful journey along the way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042486_89be50e82b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

