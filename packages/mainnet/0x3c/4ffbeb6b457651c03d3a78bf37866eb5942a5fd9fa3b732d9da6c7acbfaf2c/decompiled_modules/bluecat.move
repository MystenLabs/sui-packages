module 0x3c4ffbeb6b457651c03d3a78bf37866eb5942a5fd9fa3b732d9da6c7acbfaf2c::bluecat {
    struct BLUECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECAT>(arg0, 9, b"BLUECAT", b"Blue Cats", b"blue Cats Is meme on sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844717022367948800/turikGoa.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUECAT>(&mut v2, 446000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

