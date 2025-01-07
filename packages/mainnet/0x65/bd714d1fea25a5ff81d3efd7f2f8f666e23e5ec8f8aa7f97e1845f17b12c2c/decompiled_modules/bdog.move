module 0x65bd714d1fea25a5ff81d3efd7f2f8f666e23e5ec8f8aa7f97e1845f17b12c2c::bdog {
    struct BDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOG>(arg0, 6, b"BDOG", b"breakfast dog", b"what you didn't have this morning cause you were too busy opening pumpfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbp_Ve_Qwz_B_Vy_Ys_X8_UHAN_Gp_XP_444z_Rr_R_Paom_L3u_Dedb_V_Ngz_d7d7fa94bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

