module 0xc9b3c2859129b67e56b4040160166ebddacb3703dd357c37ff90adf13245c778::mystery {
    struct MYSTERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTERY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MYSTERY>(arg0, 2787549658477961279, b"SUI MYSTERY LAUNCH", b"MYSTERY", x"434f4d45204a4f494e20544720414e44205741495420464f5220544845204752454154455354204c41554e434820455645522e2020474956454157415920464f5220414c4c204e4557204d454d42455253200a0a68747470733a2f2f742e6d652f5355494d595354455259", b"https://images.hop.ag/ipfs/QmWMq4jFvsaCdqXWfSpsrpkXNVJMfuWrQ3Xnph5gaAcDUA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/SUIMYSTERY"), arg1);
    }

    // decompiled from Move bytecode v6
}

