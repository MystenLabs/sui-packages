module 0x193496dcef38f611e2f9d33931b2e78b94c9086cdc7d8b2f426af47400d52537::og {
    struct OG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OG>(arg0, 9, b"OG", b"OG", b"OH Game. Gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.shutterstock.com/shutterstock/photos/1972527140/display_1500/stock-vector-gg-logo-unique-for-different-projects-1972527140.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OG>>(v1);
    }

    // decompiled from Move bytecode v6
}

