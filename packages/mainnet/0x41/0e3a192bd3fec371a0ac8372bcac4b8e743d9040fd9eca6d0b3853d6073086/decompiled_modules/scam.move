module 0x410e3a192bd3fec371a0ac8372bcac4b8e743d9040fd9eca6d0b3853d6073086::scam {
    struct SCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM>(arg0, 6, b"SCAM", b"SCAM TOKEN", b"TOKEN SCAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/133_6117fda627.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

