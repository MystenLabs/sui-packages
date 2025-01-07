module 0x4761d9b78969a3b0a08882af3b8e5b821c1e951529c9d11c090bb8bed382e08d::cheese {
    struct CHEESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEESE>(arg0, 6, b"CHEESE", b"Cheeseball the Wizard", b"Cheeseball the Wizard on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_IC_Hq9_Ewq_J_Ai_Uicmck_IJ_8gfwow_BRA_Ak_Iv_A_Iz_RD_8d4050a2d9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

