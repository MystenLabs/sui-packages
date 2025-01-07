module 0x3d7082a0cb3b1bb63dbbe0a8ed1d9dab59745e8578255532fb5165232fe62638::nexf {
    struct NEXF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXF>(arg0, 6, b"Nexf", b"Next fund ai", b"Fund aiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7037_815bbb0dd6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEXF>>(v1);
    }

    // decompiled from Move bytecode v6
}

