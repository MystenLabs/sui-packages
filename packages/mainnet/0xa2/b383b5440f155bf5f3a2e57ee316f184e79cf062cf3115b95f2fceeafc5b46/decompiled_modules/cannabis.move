module 0xa2b383b5440f155bf5f3a2e57ee316f184e79cf062cf3115b95f2fceeafc5b46::cannabis {
    struct CANNABIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANNABIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANNABIS>(arg0, 6, b"CANNABIS", b"CANNABIS COIN ON SUI", b"It's 4:20!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nihx5_K8_Fc_Xi_C_Nunuoqrc_Rwwp7_J59aa2ivp4_Vu2r5_Csi_T_Copy_007179199d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANNABIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANNABIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

