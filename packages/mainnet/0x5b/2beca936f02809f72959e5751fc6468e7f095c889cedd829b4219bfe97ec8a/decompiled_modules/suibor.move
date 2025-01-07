module 0x5b2beca936f02809f72959e5751fc6468e7f095c889cedd829b4219bfe97ec8a::suibor {
    struct SUIBOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOR>(arg0, 6, b"Suibor", b"SuiborCoin", b"The dwarves of Erbor went deeper into the Lonely Mountain and discovered a new mystical mine, where they mined a bright blue ore. They discovered that this ore was more valuable than gold and diamonds, so they began to mint coins from it and named the coin Suibor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/555_90a49db879.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

