module 0x7e95c5ad0e2cc2090f1cb8b7c1158d5f170f08de878da57de9f41bb4f7c9e9c5::monki {
    struct MONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKI>(arg0, 6, b"MONKI", b"Monki On Sui", b"Welcome To The Monki Gang!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibvszgpuswkgxij3jgglwaer2iqtfgqhbzmwy4oa6l2nxlzxkxd2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

