module 0x61fbfec4009a45919f3f2dcef0e962719678fce9e2680988e9331bddd5ed10d1::mak {
    struct MAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAK>(arg0, 6, b"MAK", b"Minaka", b"sacred", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_mascot_logo_design_of_a_arrogant_looking_witchmascot_l_42eb19a4_3d97_492f_89ed_546b58fe41fe_2_e6744309a6_fa4a2452b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

