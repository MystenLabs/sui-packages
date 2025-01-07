module 0xf85534157a077af7f01bb1a3604278572039b65381374b0fea79fe656b5594a0::blink {
    struct BLINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINK>(arg0, 6, b"Blink", b"Blink Man", b"The blink man has been saved by", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ynr_J_Se_FNJF_Aw_RF_7_Rd_L_Li9f_Gf_Q7w_Pv496_Hxd4_Jvc_AU_1t_X_d3f0d7979b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

