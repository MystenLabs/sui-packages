module 0xe22c6a7c1bed8f851bf4fba6c64bdec618972288de37eb6c83d303896e8c15b5::spaceai {
    struct SPACEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPACEAI>(arg0, 6, b"SPACEAI", b"SPACE ORDIMAN A.I. ", b"First Autonomous Artificial Intelligence Agent for the NFT RPG game SPACE ORIDMAN, on the GOTAS SOCIAL platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4586_4fcd647890.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPACEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

