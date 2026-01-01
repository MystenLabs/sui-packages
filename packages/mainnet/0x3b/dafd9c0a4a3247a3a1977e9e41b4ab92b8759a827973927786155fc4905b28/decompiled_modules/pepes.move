module 0x3bdafd9c0a4a3247a3a1977e9e41b4ab92b8759a827973927786155fc4905b28::pepes {
    struct PEPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPES>(arg0, 6, b"PEPES", b"PEPE SUI", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPES>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPES>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPES>>(v2);
    }

    // decompiled from Move bytecode v6
}

