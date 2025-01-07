module 0x2ce5f7b2f766907316692b35764c23b25ce72e8abb56bd03aa4146d02c12da48::tdf {
    struct TDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDF>(arg0, 6, b"TDF", b"The Dogefather", x"456c6f6e204d75736b206861732073757270617373656420323038206d696c6c696f6e20666f6c6c6f776572732e20486520697320746865206d6f737420666f6c6c6f776564206163636f756e74206f6e202e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gf_M_FT_Ubc_AAIV_Xg_4b59c2f673.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

