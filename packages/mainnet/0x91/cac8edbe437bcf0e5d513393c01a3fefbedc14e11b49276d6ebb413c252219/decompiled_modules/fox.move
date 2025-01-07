module 0x91cac8edbe437bcf0e5d513393c01a3fefbedc14e11b49276d6ebb413c252219::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"Matt Furie's Fox", x"466f78206973206f6e65206f66204d61747420467572696527732062656c6f76656420706574207261747320616e64207468652061646f707465642062726f74686572206f66205761742c20616e6f74686572206f6620467572696527732069636f6e696320726174732e20496e20746865204e696768742052696465727320747269627574652c20466f782773206d656e74696f6e20696d6d6f7274616c697a65732068696d20617320616e20696e74656772616c2070617274206f662046757269652773206372656174697665206a6f75726e65792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VQ_3_Xjf3_DB_7eb_R_Mm7_Lvmcc_CG_Qc_S_Eb_YZW_Ps_N79_J_Az_TEEV_3_cc4d3ec2aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

