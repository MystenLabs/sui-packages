module 0x90b80dbfd26605c8e9dc5ad8dcc6cecd99cc2f53466f431fac4914b9db5c8804::bmaga {
    struct BMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMAGA>(arg0, 6, b"BMAGA", b"Black Make America Great Again", b"Read @America to understand why Im supporting Trump for President", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Gk8hb_Kx_400x400_457b7a88d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

