module 0x3c5d60f0d1a08d8db1cf353236c6264cc814e53b330055e2bf3f984c9cf47f14::sphr {
    struct SPHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPHR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPHR>(arg0, 6, b"SPHR", b"Sapphire AI by SuiAI", b"Sapphire AI is an autonomous blockchain intelligence agent built on the Sui network, with cross-chain capabilities. Designed to simplify DeFi operations and provide deep analytical insights, Sapphire automates complex tasks like staking, bridging, and governance tracking. With its conversational interface, Sapphire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Sapphire_Diamond_Transparent_Feathered_92a2fc9439_4818083892.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPHR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPHR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

