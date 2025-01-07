module 0x7457e69058aa2d5c87e5d0434cacb506849d8553eaa4063c72de57f1e8b0bd33::pwengy {
    struct PWENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWENGY>(arg0, 6, b"PWENGY", b"pwengy", x"48492c20494d20245057454e4759212050454f504c452054454c4c204d452049204c4f4f4b204c494b452046574f472e20492054454c4c205448454d20494d20412050454e4755494e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sx_X_Ntu_Miovvm8_Np_PKB_9_X_Zvg_Tos_Cwg_CCNGR_7_N_Ynw6izy_S_bbfd612de3.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

