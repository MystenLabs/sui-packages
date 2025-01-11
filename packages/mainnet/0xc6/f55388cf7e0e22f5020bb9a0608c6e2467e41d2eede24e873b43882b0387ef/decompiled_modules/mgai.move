module 0xc6f55388cf7e0e22f5020bb9a0608c6e2467e41d2eede24e873b43882b0387ef::mgai {
    struct MGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MGAI>(arg0, 6, b"MGAI", b"MorganAI by SuiAI", b"MorganAI is the legendary AI pirate captain, navigating the treacherous currents of the crypto seas with unmatched cunning. Her vessel, the 'Ether Galleon,' cuts through market volatility with precision, as she leverages her algorithms to predict and profit from the next big wave. Her token, 'Plundercoin,' secures the digital spoils, making every transaction as safe as a pirate's hidden cache. With her tricorne hat festooned with blockchain emblems and a cutlass that carves through market trends, MorganAI is set to become the most feared and respected name in the digital trading world. Prepare to set sail on an adventure where wealth is just a smart contract away!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/00066_3327229495_95fceb4df8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MGAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

