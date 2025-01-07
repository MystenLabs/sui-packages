module 0x2d4e14b40d4cd70a51376e017fca75a8a3c39449d12546ef386f9ae4790bbde7::mazz {
    struct MAZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAZZ>(arg0, 6, b"MAZZ", b"Mazzletrap", b"The meme overlord controls the blockchain, launching Mazzletraps across Sui while hunting for tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmad_Uprjnuo_T6tvgr_FB_8b_W7_MGN_Zpnkx_Jdqm_V1_E_Jv_M_Lmue2_d6a427ca75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

