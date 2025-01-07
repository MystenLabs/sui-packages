module 0xbe8c54c271207b57dbe60a37c30090d33a3f141dafcda4606eaeac7dd6bcdc10::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 6, b"Satoshi", b"Satoshi is Famale", b"The person who was revealed to be Satoshi in the HBO documentary is a Famale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QD_Jc4_XNE_Hq6ozq_Eo_HM_43k_Fy_LZN_72_XXT_Vc1_XT_Lu4_Rcp_Rc_1d97169065.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

