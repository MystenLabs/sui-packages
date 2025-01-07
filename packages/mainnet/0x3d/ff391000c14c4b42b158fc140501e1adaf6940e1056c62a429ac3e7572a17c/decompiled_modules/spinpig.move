module 0x3dff391000c14c4b42b158fc140501e1adaf6940e1056c62a429ac3e7572a17c::spinpig {
    struct SPINPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINPIG>(arg0, 6, b"SPINPIG", b"Spinning Pig by steve", b"You spin me right 'round, baby Right 'round, like a record, baby Right 'round, 'round, 'round You spin me right 'round, baby Right 'round, like a record, baby Right 'round, 'round, 'round", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Mx_Ub_Ssdd_Re_J5_D8_Hs_No_JACHF_4_Dw_PG_6j_G_Cbzn_Yjf_Cbc_M7_ad8ae4fc3a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPINPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

