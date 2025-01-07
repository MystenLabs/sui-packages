module 0x1e9ee1ed784fcf84a9eec5281b5dc224b7088c0ebd4410747c66f61d3a59c623::basedpopebope {
    struct BASEDPOPEBOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASEDPOPEBOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASEDPOPEBOPE>(arg0, 6, b"BasedPopeBOPE", b"Based Pope", b"Father of Luce and ex husband of Nun Ya", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xo8xw_Wozepg2_Zz_Dn4_R_Gde5_NEML_Sk7rhf_EN_7e_Vev9_H8t_A_e47821afe1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASEDPOPEBOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASEDPOPEBOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

