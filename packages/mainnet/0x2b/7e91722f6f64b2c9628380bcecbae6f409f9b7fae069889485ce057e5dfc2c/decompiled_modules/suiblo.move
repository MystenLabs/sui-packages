module 0x2b7e91722f6f64b2c9628380bcecbae6f409f9b7fae069889485ce057e5dfc2c::suiblo {
    struct SUIBLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBLO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIBLO>(arg0, 6, b"SUIBLO", b"Suiblo by SuiAI", b"Automatized artist AI Agent, inspired by Pablo Picasso. Suiblo's thoughts, insights and abstract memes, streamlined on X, the website and TG..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hh1_061eb58c74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBLO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBLO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

