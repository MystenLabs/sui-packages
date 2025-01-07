module 0x671e37bf41df64825ed6e602469e8846d16006361c6c46d1c2f748f3e6fa4df3::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT>(arg0, 6, b"MMT", b"magic money tree", x"6d61676963206d6f6e657920747265650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RGT_Aje_Zg8_TGLPPVZSK_2c_FZL_Kw_N_Uo73v_Foa_J31_Ci_E_Si4_Q_82f5be5ce4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

