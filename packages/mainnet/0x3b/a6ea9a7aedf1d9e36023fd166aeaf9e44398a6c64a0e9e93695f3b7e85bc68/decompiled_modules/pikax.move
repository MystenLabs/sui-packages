module 0x3ba6ea9a7aedf1d9e36023fd166aeaf9e44398a6c64a0e9e93695f3b7e85bc68::pikax {
    struct PIKAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKAX>(arg0, 6, b"PIKAX", b"PIKAXMAS", b"Happy Xmas! Pika Pikaa!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004594_97a55e37b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

