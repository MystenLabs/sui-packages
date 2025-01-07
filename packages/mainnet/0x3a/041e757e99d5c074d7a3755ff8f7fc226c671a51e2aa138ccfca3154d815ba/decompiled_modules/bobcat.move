module 0x3a041e757e99d5c074d7a3755ff8f7fc226c671a51e2aa138ccfca3154d815ba::bobcat {
    struct BOBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBCAT>(arg0, 6, b"BOBCAT", b"bobcat", x"43616d6520776974682061207769670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmef_Ht_Bn1y_U5tz21_Fks1ojsg5x_CK_Jp_BEN_1_Ns3_Zmd9n_R6xe_f2be81a7e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

