module 0x3fafe995311aa6e1315e18446aa779b3a842c123f1e3bf38a83bc09fd7980b50::brother {
    struct BROTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROTHER>(arg0, 9, b"BROTHER", b"Sons of SUI", b"No roadmaps, no rules, just pure unfiltered degen energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/G85Kr4dnR3M1uymyjfyAWLNtzf7hFELQsmwwwt73dYvA.png?size=xl&key=a66b8e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BROTHER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROTHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROTHER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

