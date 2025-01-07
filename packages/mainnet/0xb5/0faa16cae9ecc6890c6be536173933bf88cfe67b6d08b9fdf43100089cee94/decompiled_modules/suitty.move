module 0xb50faa16cae9ecc6890c6be536173933bf88cfe67b6d08b9fdf43100089cee94::suitty {
    struct SUITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITTY>(arg0, 6, b"SUITTY", b"Suitty", b"suitty.fun . Where chaos meets crypto in a fuzzy, blue package!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zx1_Tc_R_Xk_B_Mw3_Ux_5433ad8585.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

