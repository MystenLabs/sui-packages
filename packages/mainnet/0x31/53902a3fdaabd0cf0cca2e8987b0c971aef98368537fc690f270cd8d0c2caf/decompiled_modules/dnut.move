module 0x3153902a3fdaabd0cf0cca2e8987b0c971aef98368537fc690f270cd8d0c2caf::dnut {
    struct DNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNUT>(arg0, 6, b"DNUT", b"Dognut", b"Dognut.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pj_Ys_Ve86r_Nboo_Fe_Dr6ku_Yu8_Wpp9csz_R7t1ig_KG_Rq_Z14_E_ad149ad728.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

