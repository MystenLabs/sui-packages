module 0x574205661a8376e12affe935631c0668a447c906077a9c87321694d24368bdcc::lovecat {
    struct LOVECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVECAT>(arg0, 6, b"LOVECAT", b"McLovin Cat", b"He didn't even have a first name, it's just McLovin; another cat with a fake I.D. trying to score alcohol to get pussy and party with the SUI community. McLovin, the 25 year old Hawaiian organ donor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mc2_a4b683cc30.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOVECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

