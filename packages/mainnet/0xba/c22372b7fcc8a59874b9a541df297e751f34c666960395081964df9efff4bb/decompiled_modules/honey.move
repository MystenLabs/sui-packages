module 0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONEY>(arg0, 6, b"HONEY", b"HONEY", x"484f4e455920697320746865206865616c746820736f7572636520666f7220647261676f6e2d62656573206e617669676174696e6720746865206d7973746963616c20537569207365617320f09f8c8a20f09f8fb4e2808de298a0efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1sell8jrx8uwy.cloudfront.net/HoneyLogo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

