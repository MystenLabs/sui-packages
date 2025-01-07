module 0xef0f04b81992a0cf0d94ae44006c98024b2e18e462665831c0904803c8e1d0d7::blyzedog {
    struct BLYZEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLYZEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLYZEDOG>(arg0, 6, b"BlyzeDog", b"BlyzeDog On Sui", b"Absorb what is useful, discard what is useless, and add what is specifically your own. - Adrian's Media guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y2c5vf_Pq_C_Qkkt31n_MK_85_DL_Hf5x_Hi_M_Zgxyo_Jwo_Vr_BJZ_Gb_8b09e3f4e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLYZEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLYZEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

