module 0xeb5b8dee1e7e9fe4eedaebdd531a7d614e7b3514bbac9405a5888ea61a203d13::ntp {
    struct NTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTP>(arg0, 6, b"NTP", b"NEPTUNE", b"Building tools that makes trading and Interactions on Sui easier| Utility driven Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihljn6jstkyu66uoe4j5zau52uve72etoblcrhnp6hhxf5vd7rzyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NTP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

