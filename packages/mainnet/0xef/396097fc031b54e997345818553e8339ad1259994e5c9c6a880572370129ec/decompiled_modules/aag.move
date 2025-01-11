module 0xef396097fc031b54e997345818553e8339ad1259994e5c9c6a880572370129ec::aag {
    struct AAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAG>(arg0, 6, b"AAG", b"Animal Agent Generator by SuiAI", b"Create Your Own AI Animal Companion.Bring your virtual pets to life with advanced AI technology, natural conversations, and expressive 3D animations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aag_6f547a0329.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

