module 0x208ad2e299e2f1731dbfd365b683e09ba0e82c4388cb794eb123d5841f059378::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 6, b"ALPHA", b"Alpha-152", b"YOUR ALPHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ev_N_Bo_Ww_ZFF_6p_Ppj_Tn_N_Szrurxk_Dfw1_PG_Umih1e_A_Stpump_8cc8ea0da3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

