module 0xd2abc9c614ef2aaa28ba5f1c61c682883235025c6691ce3bcbde0ec6f89b699::gems {
    struct GEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMS>(arg0, 0, b"GEMS", b"Gems", b"Accumulate Gems to unlock rewards in the DSL ecosystem", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<GEMS>(&v2, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<GEMS>>(v4, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<GEMS>(v3);
    }

    // decompiled from Move bytecode v6
}

