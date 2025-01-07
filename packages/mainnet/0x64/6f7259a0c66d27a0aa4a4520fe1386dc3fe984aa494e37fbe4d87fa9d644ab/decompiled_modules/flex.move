module 0x646f7259a0c66d27a0aa4a4520fe1386dc3fe984aa494e37fbe4d87fa9d644ab::flex {
    struct FLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLEX>(arg0, 1, b"FLEX", b"FLEX", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLEX>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLEX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

