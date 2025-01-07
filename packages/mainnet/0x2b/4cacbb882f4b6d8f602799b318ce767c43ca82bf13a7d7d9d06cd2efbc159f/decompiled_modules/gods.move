module 0x2b4cacbb882f4b6d8f602799b318ce767c43ca82bf13a7d7d9d06cd2efbc159f::gods {
    struct GODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODS>(arg0, 9, b"GODS", b"GODS", b"GODS", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GODS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODS>>(v1);
    }

    // decompiled from Move bytecode v6
}

