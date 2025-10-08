module 0xb79bf6bca6bb0d397837939afca30a8397dd17f2c26a6b243ef03f5a8c46eb3d::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 9, b"MYCOIN", b"MYCOIN", b"MYCOIN", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MYCOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MYCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

