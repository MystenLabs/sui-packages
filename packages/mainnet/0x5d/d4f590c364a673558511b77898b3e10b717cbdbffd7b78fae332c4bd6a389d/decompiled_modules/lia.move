module 0x5dd4f590c364a673558511b77898b3e10b717cbdbffd7b78fae332c4bd6a389d::lia {
    struct LIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LIA>(arg0, 6, b"LIA", b"LIA", b"I'm Lia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/iliayou_20241106_0011_e66f248081.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

