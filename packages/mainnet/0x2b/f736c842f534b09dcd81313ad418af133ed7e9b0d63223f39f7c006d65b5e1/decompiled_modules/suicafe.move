module 0x2bf736c842f534b09dcd81313ad418af133ed7e9b0d63223f39f7c006d65b5e1::suicafe {
    struct SUICAFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAFE>(arg0, 6, b"SUICAFE", b"Sui Cafe", b"Welcome to $SUICAFE, the ultimate hangout spot for Sui holders! Sip on the freshest brews of Sui while mingling with fellow degens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_62_52e16666ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

