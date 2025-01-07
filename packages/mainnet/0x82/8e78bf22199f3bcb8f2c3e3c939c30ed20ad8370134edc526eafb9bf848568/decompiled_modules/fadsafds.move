module 0x828e78bf22199f3bcb8f2c3e3c939c30ed20ad8370134edc526eafb9bf848568::fadsafds {
    struct FADSAFDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FADSAFDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FADSAFDS>(arg0, 6, b"Fadsafds", b"dafds", b"sdfasdfa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zb_YAM_8je_Jn_Tpr_Bnor9n_Ajv_PR_69b_Rbuo_RX_Hmef3chk3w_U_66c57b6b72.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FADSAFDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FADSAFDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

