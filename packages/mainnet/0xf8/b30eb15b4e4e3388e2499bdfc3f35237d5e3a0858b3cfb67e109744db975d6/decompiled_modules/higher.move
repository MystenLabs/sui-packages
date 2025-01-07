module 0xf8b30eb15b4e4e3388e2499bdfc3f35237d5e3a0858b3cfb67e109744db975d6::higher {
    struct HIGHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGHER>(arg0, 6, b"HIGHER", b"MY PRONOUNS ARE HIGH/ER", b"THE MOST SPELLED WORD IN MEMECOINS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_KCGJ_Jp_R_Mtbyd_UDT_Aoc5_Mo_R_Pnqm_JNN_Da_Fwv_B_Dd_SG_6da_C_d4c52b0166.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIGHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

