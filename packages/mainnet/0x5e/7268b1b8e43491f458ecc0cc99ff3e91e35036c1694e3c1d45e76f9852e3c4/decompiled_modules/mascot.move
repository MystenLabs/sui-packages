module 0x5e7268b1b8e43491f458ecc0cc99ff3e91e35036c1694e3c1d45e76f9852e3c4::mascot {
    struct MASCOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASCOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASCOT>(arg0, 6, b"Mascot", b"Mascotsui", b"$Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pqr_ET_4c_A_Eq_Low_F_Vtz_Fz_Kr8dm6_PU_Ug_Ekm_Rz5p_A2c_EEBV_3_84d23f6657.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASCOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASCOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

