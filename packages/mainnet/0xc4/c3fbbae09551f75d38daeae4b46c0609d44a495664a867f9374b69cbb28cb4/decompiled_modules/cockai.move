module 0xc4c3fbbae09551f75d38daeae4b46c0609d44a495664a867f9374b69cbb28cb4::cockai {
    struct COCKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCKAI>(arg0, 6, b"CockAI", b"Cockerel", b"Bold AI, built for Alphas-take control and conquer finance with precision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_A91_C481_7_FF_9_441_E_BDCC_B8_A948_F862_F3_8f228acf0a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

