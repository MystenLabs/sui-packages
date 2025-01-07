module 0x4607cb84461ec4ec9ddad26d402eb2b7d610689cc8bb65555570bbe5866cabc6::ETHL {
    struct ETHL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHL>(arg0, 9, b"ETHL", b"EtherLite", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETHL>>(v1);
        0x2::coin::mint_and_transfer<ETHL>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ETHL>>(v2);
    }

    // decompiled from Move bytecode v6
}

