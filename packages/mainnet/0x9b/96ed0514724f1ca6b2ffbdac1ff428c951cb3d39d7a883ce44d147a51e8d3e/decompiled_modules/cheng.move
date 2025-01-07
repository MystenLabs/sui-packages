module 0x9b96ed0514724f1ca6b2ffbdac1ff428c951cb3d39d7a883ce44d147a51e8d3e::cheng {
    struct CHENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENG>(arg0, 6, b"CHENG", b"Shin Cheng", b"baby evan cheng searching for his 0x1play", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shincan_fd81c453af.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

