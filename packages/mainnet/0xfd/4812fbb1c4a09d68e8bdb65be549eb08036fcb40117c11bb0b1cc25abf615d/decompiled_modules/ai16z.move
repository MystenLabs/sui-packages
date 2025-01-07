module 0xfd4812fbb1c4a09d68e8bdb65be549eb08036fcb40117c11bb0b1cc25abf615d::ai16z {
    struct AI16Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI16Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI16Z>(arg0, 6, b"ai16Z", b"ai16z on sui", x"616931367a206973207468652066697273742041492056432066756e642c2066756c6c79206d616e61676564206279204d6172632041496e647265657373656e2077697468207265636f6d6d656e646174696f6e732066726f6d206d656d62657273206f66207468652044414f2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_NTV_Aoy_J7z_Db_Pn_N9jwi_Mo_B8u_Co_JBUP_9_R_Gmmi_GG_Hv44y_X_6038821749.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI16Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI16Z>>(v1);
    }

    // decompiled from Move bytecode v6
}

