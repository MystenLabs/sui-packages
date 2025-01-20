module 0x2dfb023531bb84f0e26c9c51b36ffc55e971289d2374d4620cc586e040abffe9::dogeai {
    struct DOGEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEAI>(arg0, 6, b"DOGEAI", b"DOGE AI", b"Always accelerating efficiently", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Yw9k_K_Ff_R_Ufgm_A78t_Nfn_Hh_K_Hbf_Rz_Y_Eg_F4t_Dgk2_Fw_Cpgr_4c2ba4879b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

