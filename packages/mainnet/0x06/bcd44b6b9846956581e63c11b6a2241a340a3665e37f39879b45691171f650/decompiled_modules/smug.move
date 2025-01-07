module 0x6bcd44b6b9846956581e63c11b6a2241a340a3665e37f39879b45691171f650::smug {
    struct SMUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUG>(arg0, 6, b"SMUG", b"SMUG FROG", x"50656f706c652063616c6c206d65205065706520627574204920616d2061637475616c6c792024534d55470a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZI_Zg_V6_XAA_Ax_W_Bm_d93f677559.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

