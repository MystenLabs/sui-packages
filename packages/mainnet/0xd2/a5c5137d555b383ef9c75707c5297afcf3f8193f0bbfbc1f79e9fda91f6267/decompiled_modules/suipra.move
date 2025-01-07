module 0xd2a5c5137d555b383ef9c75707c5297afcf3f8193f0bbfbc1f79e9fda91f6267::suipra {
    struct SUIPRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPRA>(arg0, 6, b"SUIPRA", b"SuiPra", b"Motors make on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/db964567716345_Y3_Jvc_Cw4_NTM_0_LDY_2_Nz_Us_M_Cw5_Mjk_a7ab0f5659.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

