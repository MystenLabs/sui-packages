module 0xd9205d4b539588d6779adb2b6808b76927dbc54d7f343040f31fcfac33c12299::dpd {
    struct DPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPD>(arg0, 6, b"DPD", b"Dragon-Powered Dolphin Jet", b"Propelling charts quicker than DPD homes. Potentially viral, funny asf, non toxic meme. NO tg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmao2_GG_4fqo_P_Wy9ma_G_Pn_Vx_CM_Dfu_BF_Bv68_Ny6w3_Xvq_To_D_Sf_67160f29f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

