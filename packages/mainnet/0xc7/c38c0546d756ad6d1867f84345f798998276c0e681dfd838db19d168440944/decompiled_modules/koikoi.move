module 0xc7c38c0546d756ad6d1867f84345f798998276c0e681dfd838db19d168440944::koikoi {
    struct KOIKOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOIKOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOIKOI>(arg0, 6, b"KOIKOI", b"koikoi", b"Make Memecoin Magic with KOIKOI Now on moveppump Network! Dive into the world of KOIKOI we are swimming upstream to catch those gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KOIKOI_T_Hjxwy_j_Bf_BI_Tn_Yc24_I_047d152d4d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOIKOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOIKOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

