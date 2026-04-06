module 0x9a598681dea0ecd6d75a046fc619e684c677987ffa5cb1fd105c2fc5167aa8da::as {
    struct AS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AS>(arg0, 6, b"AS", b"As Token", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AS>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AS>>(v2);
    }

    // decompiled from Move bytecode v6
}

