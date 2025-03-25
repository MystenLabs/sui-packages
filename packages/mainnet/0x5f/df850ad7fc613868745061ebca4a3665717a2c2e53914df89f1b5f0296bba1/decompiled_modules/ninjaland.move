module 0x5fdf850ad7fc613868745061ebca4a3665717a2c2e53914df89f1b5f0296bba1::ninjaland {
    struct NINJALAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINJALAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742894374866.png"));
        let (v1, v2) = 0x2::coin::create_currency<NINJALAND>(arg0, 6, b"NINJALAND", b"NINJALAND", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINJALAND>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINJALAND>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<NINJALAND>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NINJALAND>>(arg0);
    }

    // decompiled from Move bytecode v6
}

