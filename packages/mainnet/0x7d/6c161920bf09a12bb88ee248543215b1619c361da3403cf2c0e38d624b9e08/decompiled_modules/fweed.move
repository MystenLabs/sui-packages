module 0x7d6c161920bf09a12bb88ee248543215b1619c361da3403cf2c0e38d624b9e08::fweed {
    struct FWEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWEED>(arg0, 6, b"FWEED", b"Fweedom Fwog", x"2046776565646f6d3a205468652046726565646f6d2046726f6720204c6f636b2026204c6f61642c204677656e732120205768657265206d656d6573206d656574206d75736b65747320262066776f677320666967687420666f722066726565646f6d2120496e202446574545442077652074727573742e204a6f696e2074686520726562656c6c696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RT_Xmu_E_Rz3_Jb_Mkzh_Ke_Bri_G5u_Jxpkp5s47_YAWKN_Fy644_DQ_4c5058b6ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

