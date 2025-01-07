module 0xdb1d3f52641ba0783921bb40164d838e58ff69d56673fbb4e1ae843fe0220ebb::suiwonderland {
    struct SUIWONDERLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWONDERLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWONDERLAND>(arg0, 1, b"SUIWONDERLAND", b"SUIWONDERLAND", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWONDERLAND>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWONDERLAND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWONDERLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

