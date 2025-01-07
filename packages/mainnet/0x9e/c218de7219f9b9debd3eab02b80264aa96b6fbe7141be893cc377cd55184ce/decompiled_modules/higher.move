module 0x9ec218de7219f9b9debd3eab02b80264aa96b6fbe7141be893cc377cd55184ce::higher {
    struct HIGHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGHER>(arg0, 6, b"HIGHER", b"MY PRONOUNS ARE HIGHER", b"MY PRONOUNS ARE HIGH/ER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_KCGJ_Jp_R_Mtbyd_UDT_Aoc5_Mo_R_Pnqm_JNN_Da_Fwv_B_Dd_SG_6da_C_7a646d7d5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIGHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

