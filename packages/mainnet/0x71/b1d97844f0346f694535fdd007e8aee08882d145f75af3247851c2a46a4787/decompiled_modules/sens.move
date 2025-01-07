module 0x71b1d97844f0346f694535fdd007e8aee08882d145f75af3247851c2a46a4787::sens {
    struct SENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENS>(arg0, 6, b"SENS", b"SENS SUI", x"546865206669727374206368696e657365204149206d656d65636f696e204465762e205465616368696e6720796f75207468652077617973206f66206d656d65636f696e732032342f372e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3ukz_V_Xd_D_Bwy_PP_3v_DF_Mq952i_GZC_3_B792_Fq_Ms_E4_W_Xcpump_561ac3b99b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

