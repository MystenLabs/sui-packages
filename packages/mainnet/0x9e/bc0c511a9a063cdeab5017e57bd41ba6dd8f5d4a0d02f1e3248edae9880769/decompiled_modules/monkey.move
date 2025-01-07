module 0x9ebc0c511a9a063cdeab5017e57bd41ba6dd8f5d4a0d02f1e3248edae9880769::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"ANT", b"ant with black teeth", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONKEY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONKEY>>(v1, @0x96579e4c1ebcd45a370368cf2b167830e11d9ea1aca1e4a50baa610e03416b81);
    }

    // decompiled from Move bytecode v6
}

