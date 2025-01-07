module 0x8d8d88ace2c6c0f1126e40b48f1aa8838b80d241902363e5ea1979758ddfeb1d::mysterys {
    struct MYSTERYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTERYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTERYS>(arg0, 6, b"MysteryS", b"MysterySeries", b"Utility token of the P2E project MysteryS. Comic series with mysteries in the detective genre.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016829_e1d480ea1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTERYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYSTERYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

