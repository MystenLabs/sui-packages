module 0xafdd561091662e41e1cb0e834a8f8df23261010d0b55930f1d84248f0f4170f7::p3p3 {
    struct P3P3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: P3P3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P3P3>(arg0, 6, b"P3P3", b"P3P3 ON SUI", b"Meet $P3P3, the cosmic connoisseur, meme mastermind, and intellectual extraordinaire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K9_L_Jm_Sq_G_400x400_c87d5a3b32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P3P3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<P3P3>>(v1);
    }

    // decompiled from Move bytecode v6
}

