module 0x1ae37cd3973481b7982b0155072886b82320c1c0ab2f1785b768cc3a4242d9bd::myst {
    struct MYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MYST>(arg0, 6, b"MYST", b"Myst Privacy by SuiAI", b"Empowering Privacy with The Precision Of AI..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Dvqm_X4mk_400x400_2151281f76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MYST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

