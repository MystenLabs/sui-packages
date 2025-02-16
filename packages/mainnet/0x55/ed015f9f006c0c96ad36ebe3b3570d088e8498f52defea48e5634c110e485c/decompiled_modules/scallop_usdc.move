module 0x55ed015f9f006c0c96ad36ebe3b3570d088e8498f52defea48e5634c110e485c::scallop_usdc {
    struct SCALLOP_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_USDC>(arg0, 6, b"sUSDC", b"sUSDC", b"Scallop interest-bearing token for USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://j5dqwysztfliqgr4vjiiue66wwi3j3pofuxkqpf7oulszpxdj7ma.arweave.net/T0cLYlmZVogaPKpQihPetZG07e4tLqg8v3UXLL7jT9g")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_USDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

