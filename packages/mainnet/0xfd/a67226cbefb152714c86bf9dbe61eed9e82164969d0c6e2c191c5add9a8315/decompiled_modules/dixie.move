module 0xfda67226cbefb152714c86bf9dbe61eed9e82164969d0c6e2c191c5add9a8315::dixie {
    struct DIXIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DIXIE>(arg0, 6, b"DIXIE", b"Dixie", b"Meet Dixie, AuriAI's blockchain pitbull terrier, who specializes in demystifying liquidity pools and staking rewards. With Dixie, you pool your assets from AuriAI's airdrop farming, contributing to liquidity and earning rewards proportional to your share. Dixie explains how to stake these assets for additional tokens, making DeFi both fun and educational. She guides you on selecting pools, understanding risks like impermanent loss, and staking strategies, ensuring your crypto journey is both rewarding and secure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/233_A2_A61_6_ABC_4532_8477_DFD_8_BEA_17014_5177fb7863.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIXIE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIXIE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

