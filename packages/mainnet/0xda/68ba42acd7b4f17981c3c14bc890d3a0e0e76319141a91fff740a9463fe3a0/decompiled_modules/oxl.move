module 0xda68ba42acd7b4f17981c3c14bc890d3a0e0e76319141a91fff740a9463fe3a0::oxl {
    struct OXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OXL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OXL>(arg0, 6, b"OXL", b"OxiLabs", b"OxiLabs is a high-performance, permissionless DeFi ecosystem designed for creators, developers, and communities. From token launches and cross-chain bridging to staking, swapping, and building on testnet or Mainnet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidyp2tn2jthicmq2osduipizqf5542mk2njycfck7vqlv6wu5pgbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OXL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OXL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

