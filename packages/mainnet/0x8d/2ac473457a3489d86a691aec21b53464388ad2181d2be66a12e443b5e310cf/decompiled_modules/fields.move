module 0x8d2ac473457a3489d86a691aec21b53464388ad2181d2be66a12e443b5e310cf::fields {
    struct FIELDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIELDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIELDS>(arg0, 6, b"FIELDS", b"Fields", b"Dev is a monkey called fields.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeg_JU_Eot7nuhk_Yc_Q_Rg_K6e4_DB_Mh_KP_7r_JRGJ_2z_E_Gj_Fh_Q9_FJ_53612beba7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIELDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIELDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

