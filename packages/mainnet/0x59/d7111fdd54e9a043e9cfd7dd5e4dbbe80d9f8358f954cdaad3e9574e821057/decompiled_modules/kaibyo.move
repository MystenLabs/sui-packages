module 0x59d7111fdd54e9a043e9cfd7dd5e4dbbe80d9f8358f954cdaad3e9574e821057::kaibyo {
    struct KAIBYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAIBYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAIBYO>(arg0, 6, b"KAIBYO", b"Kaibyo", b"Kaibyo: strange cats commonly characterized as having the ability to shapeshift into human form.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zm_NBY_8_K_Pv9_Jn_L88_PF_Do_Ji1_QX_Ei_Fsu_Q6_Va_No_YGA_2_Uw7qj_7b1df71d9d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAIBYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAIBYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

