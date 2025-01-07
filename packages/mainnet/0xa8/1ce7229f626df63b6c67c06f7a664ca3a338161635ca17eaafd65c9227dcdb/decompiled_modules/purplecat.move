module 0xa81ce7229f626df63b6c67c06f7a664ca3a338161635ca17eaafd65c9227dcdb::purplecat {
    struct PURPLECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURPLECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURPLECAT>(arg0, 6, b"PURPLECAT", b"PurpleCat", x"68656c702069276d207472617070656420696e206120636174277320626f647920200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdy_En5h_Q9t_Lo_Dg_A6hu_P7_Y_Lqknig_XR_Lnik_M5_Sz4u_Km4m_Ku_63accba140.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURPLECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURPLECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

