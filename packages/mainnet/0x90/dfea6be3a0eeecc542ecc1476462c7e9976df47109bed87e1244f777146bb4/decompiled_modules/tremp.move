module 0x90dfea6be3a0eeecc542ecc1476462c7e9976df47109bed87e1244f777146bb4::tremp {
    struct TREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMP>(arg0, 6, b"TREMP", b"Tremp", b"Its a pixel Tremp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme4_Lo5_Y_Xuebx_WUPZ_7_Sz_B3vu1n9sr_Ezhex6a_Gv1_ZN_8_Yf_Z3_6f458ddcec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

