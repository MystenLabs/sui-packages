module 0x55849ec2647cd28755f4d9a854ff65559c25401119fb6cedf8e945427a2b1cf5::atter {
    struct ATTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATTER>(arg0, 6, b"ATTER", b"Aaaa Otter", b"Otter says Aaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6q_Kwvj76_A2zc_K_Av7_G_Vyn_Hf_QG_Xz_Pbi_X_Fg_MR_2_GH_Amwp_Wk_X_433ffe1b9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

