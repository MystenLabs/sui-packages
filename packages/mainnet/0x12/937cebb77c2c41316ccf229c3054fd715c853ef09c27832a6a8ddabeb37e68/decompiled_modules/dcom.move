module 0x12937cebb77c2c41316ccf229c3054fd715c853ef09c27832a6a8ddabeb37e68::dcom {
    struct DCOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCOM>(arg0, 6, b"DCOM", b"Degen Communism", x"0a446567656e20436f6d6d756e69736d0a0a28642f636f6d290a3078326336652e2e2e333436630a446567656e20436f6d6d756e69736d2c20646576656c6f70656420627920566974616c6b2c206973206120706f6c69746963616c206964656f6c6f67792074686174206f70656e6c7920656d627261636573206368616f73206275742061646a75737473206b65792072756c657320616e6420696e63656e746976657320746f206372656174652061206261636b67726f756e642070726573737572652077686572652074686520636f6e73657175656e636573206f66206368616f7320616c69676e20776974682074686520636f6d6d6f6e20676f6f642e204d616e69666573746f20627920566974616c696b3a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_YM_My_D_Ne_Ta3_Bnpp_Jb3_G33wj_Tpe_N_Pw_Dco_Qy4_Rk_F6egvsk_0c8244fadd.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

