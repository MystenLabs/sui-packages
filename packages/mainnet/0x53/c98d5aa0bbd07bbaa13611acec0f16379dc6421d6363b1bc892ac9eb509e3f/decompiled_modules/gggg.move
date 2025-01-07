module 0x53c98d5aa0bbd07bbaa13611acec0f16379dc6421d6363b1bc892ac9eb509e3f::gggg {
    struct GGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGGG>(arg0, 6, b"gggg", b"ffff", b"hhhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBGKQ13Y6FNVNTP0JMBHCN76/01JBGMPXDY673AQEJQE85NA89T")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GGGG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

