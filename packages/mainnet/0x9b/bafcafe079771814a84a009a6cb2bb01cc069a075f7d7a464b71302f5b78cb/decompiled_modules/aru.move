module 0x9bbafcafe079771814a84a009a6cb2bb01cc069a075f7d7a464b71302f5b78cb::aru {
    struct ARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARU>(arg0, 6, b"ARU", b"ArrowUp", x"224172726f775570202061206469676974616c2063757272656e63792073796d626f6c697a696e672070726f67726573732c2067726f7774682c20616e6420757077617264206d6f6d656e74756d20696e207468652066696e616e6369616c20776f726c642e220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rd_Y_Vo_Cg_G2km6un_F_Nekh_H_Sk_Bs_Ggy_CWV_Pt_Hv_Y5_Ugx_Muh_P8_7869bf2c23.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

