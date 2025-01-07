module 0x4bd7fa788baab9428036a6db6fdb3c531e961bc70b2cc2dea5ec6da7d95a7bdc::dom {
    struct DOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOM>(arg0, 6, b"DOM", b"SUIDOM", b"Fast and Furious on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOM_logo_06c45b374c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

