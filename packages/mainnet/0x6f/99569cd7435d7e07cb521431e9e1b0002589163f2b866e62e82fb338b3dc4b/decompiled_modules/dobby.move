module 0x6f99569cd7435d7e07cb521431e9e1b0002589163f2b866e62e82fb338b3dc4b::dobby {
    struct DOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBBY>(arg0, 6, b"DOBBY", b"Dobby", b"Choo-wawa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tq1b_Wd71n_J2w5_NL_Bhr_Y8_Vrmes_S92vso_S_Bbh_EPCE_Vzy_Zs_d5c6515eab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

