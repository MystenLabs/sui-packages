module 0x6ef70c08873c2ed546df51611faf056f1e2e11d14db441426df250841ce39baf::truthv2 {
    struct TRUTHV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUTHV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUTHV2>(arg0, 6, b"TRUTHV2", b"Swarm Network V2", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUTHV2>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUTHV2>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUTHV2>>(v2);
    }

    // decompiled from Move bytecode v6
}

