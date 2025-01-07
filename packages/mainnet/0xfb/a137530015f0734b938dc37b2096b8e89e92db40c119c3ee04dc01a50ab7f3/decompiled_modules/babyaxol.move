module 0xfba137530015f0734b938dc37b2096b8e89e92db40c119c3ee04dc01a50ab7f3::babyaxol {
    struct BABYAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAXOL>(arg0, 6, b"BabyAXOL", b"BabyAxol", b" Cute, gilled, and ready to chill! $AXOL brings axolotl magic to the blockchain and joins the cutest token revolution ever! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uotgv6k_D_Kmv2_DQTWD_3_Z_Karvdon_YVYYXP_Rgbxba_Uv1_F_Re_1_1_1_3841334cf2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYAXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

