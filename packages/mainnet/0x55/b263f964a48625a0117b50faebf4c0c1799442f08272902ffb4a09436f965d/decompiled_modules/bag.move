module 0x55b263f964a48625a0117b50faebf4c0c1799442f08272902ffb4a09436f965d::bag {
    struct BAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAG>(arg0, 6, b"BAG", b"catinbluebag", b"just a cat in a blue bag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catwifbluebag_18580d6f6b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

