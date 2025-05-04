module 0x3dd5ae857ef02c2d10e77991eaeba41954a4f2d4e1f518a677b84984ab8ed193::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 6, b"Bunny", b"Bunny coin", b"Bunny is a token within the DeFi ecosystem, focusing on providing users with flexible yield farming and staking solutions. The token stands out for its transparent tokenomics, reasonable supply,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiex7tnuykfrpbxb2jmbjazqnr5qau3ldvo4cbymyrl3jmp6absgee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUNNY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

