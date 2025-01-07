module 0xe2d339977ffb6f23f0cdbe2033e3b013a36b022b979fe298420b8c3854f3e5b8::goo {
    struct GOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOO>(arg0, 9, b"GOO", b"Goosui", b"Goosy, the majestic canine, stands with an elegance that echoes the pride of a thousand years. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.wagwalkingweb.com/media/daily_wag/blog_articles/hero/1685787498.877709/fun-facts-about-siberian-huskies-1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

