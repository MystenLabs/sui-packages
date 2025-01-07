module 0xfb7ce5a003833e85a192737c1b11ff2fa874ba6763d7f2b6c58306472ec659ed::moutai {
    struct MOUTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUTAI>(arg0, 6, b"MOUTAI", b"Moutai", b"Not affiliated with MoutaiGlobal, we just love MOUTAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BNY_8_EQKQ_400x400_18e0175439.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOUTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

