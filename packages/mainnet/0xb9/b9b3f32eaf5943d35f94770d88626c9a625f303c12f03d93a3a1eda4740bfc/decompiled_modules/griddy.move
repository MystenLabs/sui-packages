module 0xb9b9b3f32eaf5943d35f94770d88626c9a625f303c12f03d93a3a1eda4740bfc::griddy {
    struct GRIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIDDY>(arg0, 6, b"GRIDDY", b"griddy", b"Every time someone does the Griddy on TikTok or IRL, 420 GriddyCoins are burned. Elon Musk probably approves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/griddy_cd05435361.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

