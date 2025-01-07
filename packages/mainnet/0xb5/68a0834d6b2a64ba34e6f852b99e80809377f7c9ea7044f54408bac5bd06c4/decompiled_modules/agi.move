module 0xb568a0834d6b2a64ba34e6f852b99e80809377f7c9ea7044f54408bac5bd06c4::agi {
    struct AGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGI>(arg0, 6, b"AGI", b"ANGUS INU", b"The bull  of Bull Run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001870167_09b232cf03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

