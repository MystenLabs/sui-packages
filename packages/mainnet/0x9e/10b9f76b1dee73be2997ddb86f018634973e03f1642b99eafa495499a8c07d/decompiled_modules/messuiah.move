module 0x9e10b9f76b1dee73be2997ddb86f018634973e03f1642b99eafa495499a8c07d::messuiah {
    struct MESSUIAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSUIAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSUIAH>(arg0, 6, b"MESSUIAH", b"King Messuiah", b"I'm The KING ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZT_Cn9d_XQAA_3_H_Qn_5f3f0e7aca.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSUIAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSUIAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

