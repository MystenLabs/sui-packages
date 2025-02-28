module 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points {
    struct POINTS has drop {
        dummy_field: bool,
    }

    public fun burn_points(arg0: &mut 0x2::coin::TreasuryCap<POINTS>, arg1: 0x2::coin::Coin<POINTS>) {
        0x2::coin::burn<POINTS>(arg0, arg1);
    }

    fun init(arg0: POINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POINTS>(arg0, 0, b"POINTS", b"CROCODILE PROTOCOL POINTS", b"crocodile protocol points token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cro-ag.pages.dev/points.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POINTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POINTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_points(arg0: &mut 0x2::coin::TreasuryCap<POINTS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<POINTS> {
        0x2::coin::mint<POINTS>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

