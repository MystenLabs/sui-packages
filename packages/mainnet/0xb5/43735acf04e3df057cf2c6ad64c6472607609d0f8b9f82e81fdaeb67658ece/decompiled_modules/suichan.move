module 0xb543735acf04e3df057cf2c6ad64c6472607609d0f8b9f82e81fdaeb67658ece::suichan {
    struct SUICHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAN>(arg0, 6, b"SUICHAN", b"Suinosuke", b"Don't get rest after a sucess.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_40_d5040a33c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

