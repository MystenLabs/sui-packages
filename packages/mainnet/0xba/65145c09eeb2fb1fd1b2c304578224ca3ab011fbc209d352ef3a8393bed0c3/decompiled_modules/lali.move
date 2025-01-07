module 0xba65145c09eeb2fb1fd1b2c304578224ca3ab011fbc209d352ef3a8393bed0c3::lali {
    struct LALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALI>(arg0, 9, b"LALI", b"LALI", b"LALI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LALI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LALI>>(v1);
    }

    // decompiled from Move bytecode v6
}

