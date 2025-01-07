module 0x1c57ffe0eedb129da1b48e4cffbb4951adb2a89927f27aeffd7834a3535878d7::spinpig {
    struct SPINPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINPIG>(arg0, 6, b"SPINPIG", b"Spinning Pig by steve", b"You spin me right 'round, baby Right 'round, like a record, baby Right 'round, 'round, 'round You spin me right 'round, baby Right 'round, like a record, baby Right 'round, 'round, 'round", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Mx_Ub_Ssdd_Re_J5_D8_Hs_No_JACHF_4_Dw_PG_6j_G_Cbzn_Yjf_Cbc_M7_99ab360954.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPINPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

