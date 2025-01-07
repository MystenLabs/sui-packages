module 0x3e5f7705494c81ba2c7f1f4892b1d80614a381a1cf181507879262b4c8f9931b::pull {
    struct PULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PULL>(arg0, 6, b"PULL", b"Mythical Pull", b" When the stars align, and thou clicketh the right buttons, thats when one will experience the legendary Mythical Pull.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ns_G_Jn9qo_Svg_Lcn9a5_X4s_Yixkn_D_Tg_Ks_Ke_Tdu_B5u_J4brz9_460489162c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

