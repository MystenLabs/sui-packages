module 0x5b842b060aa3adf5e47682dbc66a9225398806d1c891452c1fd3a5d8e5389270::GUSDC {
    struct GUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUSDC>(arg0, 9, b"GUSDC", b"GUSDC", b"GUSDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUSDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

