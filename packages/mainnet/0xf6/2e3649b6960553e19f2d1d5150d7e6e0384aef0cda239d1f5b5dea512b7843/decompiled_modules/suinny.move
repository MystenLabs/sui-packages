module 0xf62e3649b6960553e19f2d1d5150d7e6e0384aef0cda239d1f5b5dea512b7843::suinny {
    struct SUINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINNY>(arg0, 6, b"SUINNY", b"THOUSAND SUINNY", b"Thousand Suinny by Straw Hats is about to set sail into the deep waters of Sui to look for the Sea Kings' generation wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_19_23_10_1a9f576ccb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

