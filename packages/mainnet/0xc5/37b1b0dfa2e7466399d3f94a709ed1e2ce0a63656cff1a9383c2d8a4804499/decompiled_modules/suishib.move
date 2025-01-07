module 0xc537b1b0dfa2e7466399d3f94a709ed1e2ce0a63656cff1a9383c2d8a4804499::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 9, b"SUISHIB", b"SuiShib", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISHIB>(&mut v2, 11000000000000000000, @0x424219e4cb9d3753f49ae5ea5a40b6b0ac70bff7b3e450cc4bad7f5ed2f5d8d9, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

