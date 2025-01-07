module 0x1cf55d84fffa7a06356b41ad122b071d410f61a6692ced003c74d90a3f6c2a44::world {
    struct WORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORLD>(arg0, 6, b"WORLD", b"Camerons's World", b"Hi I'm Cameron and I would love to welcome you to my $WORLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_D_Gs4_S_Sj_Qc_Hv_QK_Nahsq_Ya2oa9z_Ggq4_M_Jq4ir4r_KUL_Uz_T_0bdd0157db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

