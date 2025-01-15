module 0xb05665e0137300e590a826e509014f4b2358b909f07609c9b06a0ff0b4caa08d::ab {
    struct AB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AB>(arg0, 6, b"AB", b"Alien Butler", b"Ready to serve you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/agent_75e1382905.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AB>>(v1);
    }

    // decompiled from Move bytecode v6
}

