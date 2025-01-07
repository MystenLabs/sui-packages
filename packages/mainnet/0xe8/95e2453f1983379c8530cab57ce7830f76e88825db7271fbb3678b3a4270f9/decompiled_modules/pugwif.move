module 0xe895e2453f1983379c8530cab57ce7830f76e88825db7271fbb3678b3a4270f9::pugwif {
    struct PUGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGWIF>(arg0, 6, b"PUGWIF", b"Pugwif", b"The Pug that doesn't quit. Biggest CTO on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E_T_Wzj_YG_400x400_e26ca46d17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

