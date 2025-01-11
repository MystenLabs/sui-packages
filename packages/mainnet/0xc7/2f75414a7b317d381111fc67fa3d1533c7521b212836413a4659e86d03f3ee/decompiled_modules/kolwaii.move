module 0xc72f75414a7b317d381111fc67fa3d1533c7521b212836413a4659e86d03f3ee::kolwaii {
    struct KOLWAII has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLWAII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLWAII>(arg0, 6, b"Kolwaii", b"Kolwaii Ai Agent", b"Kolwaii Ai Agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yq7_XR_9_PNYB_Wof_Ba_KK_Uq_CL_4_Qvsg_TLAN_Vu_E_Jmu6gsqnh_Zd_b637310580.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLWAII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLWAII>>(v1);
    }

    // decompiled from Move bytecode v6
}

