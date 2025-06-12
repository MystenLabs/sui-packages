module 0xe5da6f9246baed6fd3219b39e33e2f87013fb6e2d424a9547811620f91ad6dd3::oshaaa {
    struct OSHAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSHAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSHAAA>(arg0, 6, b"OSHAAA", b"Oshaaa Sui", b"Oshaaa oshaaa oshaaa.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_H_Zqjp7_400x400_7c13b0ae2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSHAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSHAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

