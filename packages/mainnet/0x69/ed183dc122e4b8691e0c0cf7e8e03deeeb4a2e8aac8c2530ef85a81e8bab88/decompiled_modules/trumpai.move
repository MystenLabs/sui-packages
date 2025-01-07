module 0x69ed183dc122e4b8691e0c0cf7e8e03deeeb4a2e8aac8c2530ef85a81e8bab88::trumpai {
    struct TRUMPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPAI>(arg0, 6, b"TrumpAI", b"Trump Yuge AI", b"Its Trump, but AI and unfiltered. Same fire, more chaos. Buckle up, folks!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Stg1_Bb_K98tsw_B_De6c_F6_Fw_U_Ym_F1_GTX_Ktsj3gj_E2_Qbe_Vd_R_815bb1039b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

