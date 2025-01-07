module 0x4e4eef36fa9d8161b547128e7a8aa0e4cb2f6788d7f63deda150293e8fdec950::pillzumi {
    struct PILLZUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILLZUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PILLZUMI>(arg0, 6, b"PILLZUMI", b"Pillzumi", b"Enter the Mysten Labs pharmacy...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/97_Mbx6_Jym1i_Ek_Qd_Vf_Lf5_PMWL_5t_AR_Gn_Q5na5jh_R9_Lpump_e47bc6d2d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILLZUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PILLZUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

