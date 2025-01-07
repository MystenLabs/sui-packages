module 0xad4d71551d31092230db1fd482008ea42867dbf27b286e9c70a79d2a6191d58d::scallop_wormhole_usdc {
    struct SCALLOP_WORMHOLE_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_WORMHOLE_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_WORMHOLE_USDC>(arg0, 6, b"sWUSDC", b"sWUSDC", b"Scallop interest-bearing token for wormhole USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://j5dqwysztfliqgr4vjiiue66wwi3j3pofuxkqpf7oulszpxdj7ma.arweave.net/T0cLYlmZVogaPKpQihPetZG07e4tLqg8v3UXLL7jT9g")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_WORMHOLE_USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_WORMHOLE_USDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

