module 0xc5805f118f31b8acb995ad0bde3a2e7164fd8126197de1af06ca2032fcee4f3e::aira {
    struct AIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRA>(arg0, 6, b"AiRA", b"AiRA - AI", b"AIRA delivers cutting-edge conversational AI solutions that transform customer interactions. Our technology empowers businesses with intelligent automation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/01_Logo_907bcc8cf1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

