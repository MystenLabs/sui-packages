module 0x3ce94ce19d6b2f563d26a15432ae722c42eeacdd6789e7b4ac533a6ebf311db::suigilly {
    struct SUIGILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGILLY>(arg0, 6, b"SuiGilly", b"Sui-Gilly", b" Gilly's the flappiest slicker from the waters of the planet Sui. She's got the speed and agility and knows her way around all kinds of blocks and their chains. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Gilly_The_collector_dab87683f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

