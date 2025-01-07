module 0x1fb15ebb1a98630eb2b114fa2d61f008f04d520544d370b733689576beff10d::jer {
    struct JER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JER>(arg0, 9, b"JER", b"JeroToken", b"My token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JER>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JER>>(v1);
    }

    // decompiled from Move bytecode v6
}

