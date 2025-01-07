module 0x4be54cf79c87488504182f8fe698829e0ce647c9d47316cb8adabd75056a8464::rain {
    struct RAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAIN>(arg0, 11, b"RAIN", b"RAIN", b"rain for everthing", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<RAIN>(&mut v2, 2100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIN>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

