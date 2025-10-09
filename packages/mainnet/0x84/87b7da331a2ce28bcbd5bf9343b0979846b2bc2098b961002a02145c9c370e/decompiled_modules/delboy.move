module 0x8487b7da331a2ce28bcbd5bf9343b0979846b2bc2098b961002a02145c9c370e::delboy {
    struct DELBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELBOY>(arg0, 9, b"DELBOY", b"DELBOY", b"DEL BOY", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DELBOY>>(0x2::coin::mint<DELBOY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DELBOY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DELBOY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

