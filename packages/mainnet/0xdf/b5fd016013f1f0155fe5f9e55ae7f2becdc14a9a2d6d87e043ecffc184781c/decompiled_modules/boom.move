module 0xdfb5fd016013f1f0155fe5f9e55ae7f2becdc14a9a2d6d87e043ecffc184781c::boom {
    struct BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM>(arg0, 6, b"BOOM", b"BOOM ON SUI", b"200 pixel-art tanks on Sui that auto-battle every night at 12 AM GMT unique AI strategies, balanced traits, and daily $BOOM token rewards for the victor. Mint yours on TradePort and join the arena!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifqw2feo4lzc4srvze2quwmvbeg3dsfgmauafljxs6a6o2nraxlse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

