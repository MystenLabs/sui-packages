module 0x2a45362af2614e661a5ec1d084fa1e9e38dace055d1015b3c56b5f47daae0da1::mod {
    struct MOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOD>(arg0, 6, b"MOD", b"Moon Or Dust", b"moon or dust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma3ziv8a_J_Ad_S56qp1a_Rkn_Un4g2c4ok9_NJ_Xbp_B_Mq45_Gr_GE_a5095d0f60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

