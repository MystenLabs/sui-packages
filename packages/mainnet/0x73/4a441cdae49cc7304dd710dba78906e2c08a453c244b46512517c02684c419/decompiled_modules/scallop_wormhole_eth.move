module 0x734a441cdae49cc7304dd710dba78906e2c08a453c244b46512517c02684c419::scallop_wormhole_eth {
    struct SCALLOP_WORMHOLE_ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_WORMHOLE_ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_WORMHOLE_ETH>(arg0, 8, b"sWETH", b"sWETH", b"Scallop interest-bearing token for wormhole ETH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibaercu3fplp3k4qd3rnvbuotndy3upykeajirfiba2ueu3tnc7ki")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_WORMHOLE_ETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_WORMHOLE_ETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

