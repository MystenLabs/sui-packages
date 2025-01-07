module 0xce1eb7edff332185633e50f0ea1dd6ecf2db3a426c07db51f063d1dd224fd527::aisixteenz {
    struct AISIXTEENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISIXTEENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AISIXTEENZ>(arg0, 6, b"AISIXTEENZ", b"AIsixteenz", b"AI led hedge fun / open-source AGI movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ai16z2_9c0ef0ac80.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AISIXTEENZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISIXTEENZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

