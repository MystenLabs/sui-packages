module 0x8a5ee5dcc2df62ac7e6c76c5ab496af657fc880cff647e4abf22594390d33c66::detpengu {
    struct DETPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DETPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DETPENGU>(arg0, 6, b"DETPENGU", b"Det. PENGU - The detective Penguin", b"Sendor or rugs! Detective Pengu can see it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicdlnqjsyql7ba3mtdo4gmt6ank4uv3q7qioe2uxzq7nxmaqoct2m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DETPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DETPENGU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

