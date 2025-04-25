module 0xc524e52905fe22fd736d05567dabd5ecce06395aea3cb307e2d2b2ce4f81eea4::vasdd {
    struct VASDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VASDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VASDD>(arg0, 9, b"VASDD", b"vv23", b"sdfasdfadsjf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VASDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VASDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

